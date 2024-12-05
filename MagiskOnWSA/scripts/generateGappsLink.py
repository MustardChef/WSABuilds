#!/usr/bin/python3
#
# This file is part of MagiskOnWSALocal.
#
# MagiskOnWSALocal is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# MagiskOnWSALocal is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with MagiskOnWSALocal.  If not, see <https://www.gnu.org/licenses/>.
#
# Copyright (C) 2024 LSPosed Contributors
#

from datetime import datetime
import sys

import requests
import json
import re
from pathlib import Path


class BearerAuth(requests.auth.AuthBase):
    def __init__(self, token):
        self.token = token

    def __call__(self, r):
        r.headers["authorization"] = "Bearer " + self.token
        return r


github_auth = None
if Path.cwd().joinpath('token').exists():
    with open(Path.cwd().joinpath('token'), 'r') as token_file:
        github_auth = BearerAuth(token_file.read())
        print("Using token file for authentication", flush=True)
arch = sys.argv[1]
arg2 = sys.argv[2]
download_dir = Path.cwd().parent / "download" if arg2 == "" else Path(arg2)
tempScript = sys.argv[3]
android_api = sys.argv[4]
file_name = sys.argv[5]
print(f"Generating GApps download link: arch={arch}", flush=True)
abi_map = {"x64": "x86_64", "arm64": "arm64"}
android_api_map = {"30": "11.0", "32": "12.1", "33": "13.0"}
release = android_api_map[android_api]
res = requests.get(f"https://api.github.com/repos/LSPosed/WSA-Addon/releases/latest", auth=github_auth)
json_data = json.loads(res.content)
headers = res.headers
x_ratelimit_remaining = headers["x-ratelimit-remaining"]
if res.status_code == 200:
    download_files = {}
    assets = json_data["assets"]
    for asset in assets:
        if re.match(rf'gapps.*{release}.*\.rc$', asset["name"]):
            download_files[asset["name"]] = asset["browser_download_url"]
        elif re.match(rf'gapps.*{release}.*{abi_map[arch]}.*\.img$', asset["name"]):
            download_files[asset["name"]] = asset["browser_download_url"]
    with open(download_dir/tempScript, 'a') as f:
        for key, value in download_files.items():
            print(f"download link: {value}\npath: {download_dir / key}\n", flush=True)
            f.writelines(value + '\n')
            f.writelines(f'  dir={download_dir}\n')
            f.writelines(f'  out={key}\n')
elif res.status_code == 403 and x_ratelimit_remaining == '0':
    message = json_data["message"]
    print(f"Github API Error: {message}", flush=True)
    ratelimit_reset = headers["x-ratelimit-reset"]
    ratelimit_reset = datetime.fromtimestamp(int(ratelimit_reset))
    print(
        f"The current rate limit window resets in {ratelimit_reset}", flush=True)
    exit(1)
