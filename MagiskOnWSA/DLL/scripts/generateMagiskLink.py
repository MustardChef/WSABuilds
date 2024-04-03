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

#Android header
headers = {
    'User-Agent': 'Mozilla/5.0 (Linux; Android 13; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.6045.163 Mobile Safari/537.36',
}

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

magisk_branch = sys.argv[1]
magisk_ver = sys.argv[2]
download_dir = Path.cwd().parent / \
    "download" if sys.argv[3] == "" else Path(sys.argv[3])
tempScript = sys.argv[4]
download_files = {}
print(
    f"Generating Magisk download link: release type={magisk_ver}", flush=True)
if not magisk_ver:
    magisk_ver = "stable"

if magisk_branch == "vvb2060":
    try:
        magisk_link = json.loads(requests.get(
            f"https://install.appcenter.ms/api/v0.1/apps/vvb2060/magisk/distribution_groups/public/releases/latest?is_install_page=true", headers=headers).content)['download_url']
        download_files[f"magisk-{magisk_ver}.zip"] = magisk_link
    except Exception:
        print("Failed to fetch from AppCenter API...")
else:
    try:
        magisk_link = json.loads(requests.get(
            f"https://github.com/{magisk_branch}/magisk-files/raw/master/{magisk_ver}.json").content)['magisk']['link']
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
