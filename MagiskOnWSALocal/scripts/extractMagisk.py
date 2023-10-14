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

import sys
import zipfile
from pathlib import Path
import platform
import os
from typing import Any, OrderedDict


class Prop(OrderedDict):
    def __init__(self, props: str = ...) -> None:
        super().__init__()
        for i, line in enumerate(props.splitlines(False)):
            if '=' in line:
                k, v = line.split('=', 1)
                self[k] = v
            else:
                self[f".{i}"] = line

    def __setattr__(self, __name: str, __value: Any) -> None:
        self[__name] = __value

    def __repr__(self):
        return '\n'.join(f'{item}={self[item]}' for item in self)


is_x86_64 = platform.machine() in ("AMD64", "x86_64")
host_abi = "x64" if is_x86_64 else "arm64"
arch = sys.argv[1]
magisk_zip = sys.argv[2]
workdir = Path(sys.argv[3]) / "magisk"
if not Path(workdir).is_dir():
    workdir.mkdir()

abi_map = {"x64": ["x86_64", "x86"], "arm64": ["arm64-v8a", "armeabi-v7a"]}


def extract_as(zip, name, as_name, dir):
    info = zip.getinfo(name)
    info.filename = as_name
    zip.extract(info, workdir / dir)


with zipfile.ZipFile(magisk_zip) as zip:
    props = Prop(zip.comment.decode().replace('\000', '\n'))
    versionName = props.get("version")
    versionCode = props.get("versionCode")
    print(f"Magisk version: {versionName} ({versionCode})", flush=True)
    with open(os.environ['WSA_WORK_ENV'], 'r') as environ_file:
        env = Prop(environ_file.read())
        env.MAGISK_VERSION_NAME = versionName
        env.MAGISK_VERSION_CODE = versionCode
    with open(os.environ['WSA_WORK_ENV'], 'w') as environ_file:
        environ_file.write(str(env))
    extract_as(
        zip, f"lib/{ abi_map[arch][0] }/libmagisk64.so", "magisk64", "magisk")
    extract_as(
        zip, f"lib/{ abi_map[arch][1] }/libmagisk32.so", "magisk32", "magisk")
    standalone_policy = False
    try:
        zip.getinfo(f"lib/{ abi_map[arch][0] }/libmagiskpolicy.so")
        standalone_policy = True
    except:
        pass
    extract_as(
        zip, f"lib/{ abi_map[arch][0] }/libmagiskinit.so", "magiskinit", "magisk")
    if standalone_policy:
        extract_as(
            zip, f"lib/{ abi_map[arch][0] }/libmagiskpolicy.so", "magiskpolicy", "magisk")
    else:
        extract_as(
            zip, f"lib/{ abi_map[arch][0] }/libmagiskinit.so", "magiskpolicy", "magisk")
    extract_as(
        zip, f"lib/{ abi_map[arch][0] }/libmagiskboot.so", "magiskboot", "magisk")
    extract_as(
        zip, f"lib/{ abi_map[arch][0] }/libbusybox.so", "busybox", "magisk")
    if standalone_policy:
        extract_as(
            zip, f"lib/{ abi_map[host_abi][0] }/libmagiskpolicy.so", "magiskpolicy", ".")
    else:
        extract_as(
            zip, f"lib/{ abi_map[host_abi][0] }/libmagiskinit.so", "magiskpolicy", ".")
    extract_as(zip, f"assets/boot_patch.sh", "boot_patch.sh", "magisk")
    extract_as(zip, f"assets/util_functions.sh",
               "util_functions.sh", "magisk")
