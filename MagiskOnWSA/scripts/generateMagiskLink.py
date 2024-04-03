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
# Copyright (C) 2023 LSPosed Contributors
#

from datetime import datetime
import re
import sys

import json
import requests
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

magisk_ver = sys.argv[1]
download_dir = Path.cwd().parent / \
    "download" if sys.argv[2] == "" else Path(sys.argv[2])
tempScript = sys.argv[3]
download_files = {}
print(
    f"Generating Magisk download link: release type={magisk_ver}", flush=True)
if not magisk_ver:
    magisk_ver = "stable"
if magisk_ver == "stable" or magisk_ver == "beta" or magisk_ver == "canary" or magisk_ver == "debug":
    try:
        magisk_link = json.loads(requests.get(
            f"https://github.com/topjohnwu/magisk-files/raw/master/{magisk_ver}.json").content)['magisk']['link']
        download_files[f"magisk-{magisk_ver}.zip"] = magisk_link
    except Exception:
        print("Failed to fetch from GitHub API, fallbacking to jsdelivr...")
        magisk_link = json.loads(requests.get(
            f"https://fastly.jsdelivr.net/gh/topjohnwu/magisk-files@master/{magisk_ver}.json").content)['magisk']['link']
        download_files[f"magisk-{magisk_ver}.zip"] = magisk_link
res = requests.get(
    f"https://api.github.com/repos/LSPosed/WSA-Addon/releases/latest", auth=github_auth)
json_data = json.loads(res.content)
headers = res.headers
x_ratelimit_remaining = headers["x-ratelimit-remaining"]
if res.status_code == 200:
    assets = json_data["assets"]
    for asset in assets:
        if re.match(f'cust.img$', asset["name"]):
            download_files[asset["name"]] = asset["browser_download_url"]
            break

elif res.status_code == 403 and x_ratelimit_remaining == '0':
    message = json_data["message"]
    print(f"Github API Error: {message}", flush=True)
    ratelimit_reset = headers["x-ratelimit-reset"]
    ratelimit_reset = datetime.fromtimestamp(int(ratelimit_reset))
    print(
        f"The current rate limit window resets in {ratelimit_reset}", flush=True)
    exit(1)
with open(download_dir/tempScript, 'a') as f:
    for key, value in download_files.items():
        print(
            f"download link: {value}\npath: {download_dir / key}\n", flush=True)
        f.writelines(value + '\n')
        f.writelines(f'  dir={download_dir}\n')
        f.writelines(f'  out={key}\n')
