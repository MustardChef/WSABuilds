#!/usr/bin/python
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
# Copyright (C) 2022 LSPosed Contributors
#

import sys

import json
import requests
from pathlib import Path

magisk_ver = sys.argv[1]
download_dir = Path.cwd().parent / "download" if sys.argv[2] == "" else Path(sys.argv[2]).resolve()
tempScript = sys.argv[3]
print(f"Generating Magisk download link: release type={magisk_ver}", flush=True)
if not magisk_ver:
    magisk_ver = "stable"
if magisk_ver == "stable" or magisk_ver == "beta" or magisk_ver == "canary" or magisk_ver == "debug":
    try:
        magisk_link = json.loads(requests.get(
            f"https://github.com/topjohnwu/magisk-files/raw/master/{magisk_ver}.json").content)['magisk']['link']
    except Exception:
        print("Failed to fetch from GitHub API, fallbacking to jsdelivr...")
        magisk_link = json.loads(requests.get(
            f"https://fastly.jsdelivr.net/gh/topjohnwu/magisk-files@master/{magisk_ver}.json").content)['magisk']['link']
print(f"download link: {magisk_link}", flush=True)

with open(download_dir/tempScript, 'a') as f:
    f.writelines(f'{magisk_link}\n')
    f.writelines(f'  dir={download_dir}\n')
    f.writelines(f'  out=magisk-{magisk_ver}.zip\n')
