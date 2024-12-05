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

import os
import sys
from typing import Any, OrderedDict

import zipfile
from pathlib import Path
import re
import shutil


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


arch = sys.argv[1]

zip_name = ""
wsa_zip_path = Path(sys.argv[2])
rootdir = Path(sys.argv[3])
env_file = Path(sys.argv[4])

workdir = rootdir / "wsa"
archdir = Path(workdir / arch)
pridir = workdir / archdir / 'pri'
xmldir = workdir / archdir / 'xml'
if not Path(rootdir).is_dir():
    rootdir.mkdir()

if Path(workdir).is_dir():
    shutil.rmtree(workdir)
else:
    workdir.unlink(missing_ok=True)

if not Path(workdir).is_dir():
    workdir.mkdir()

if not Path(archdir).is_dir():
    archdir.mkdir()
uid = os.getuid()
workdir_rw = os.access(workdir, os.W_OK)

with zipfile.ZipFile(wsa_zip_path) as zip:
    for f in zip.filelist:
        filename_lower = f.filename.lower()
        if arch in filename_lower:
            zip_name = f.filename
            if not Path(workdir / zip_name).is_file():
                print(f"unzipping {zip_name} to {workdir}", flush=True)
                zip_path = zip.extract(f, workdir)
                with zipfile.ZipFile(zip_path) as wsa_zip:
                    stat = Path(zip_path).stat()
                    print(f"unzipping from {zip_path}", flush=True)
                    wsa_zip.extractall(archdir)
                ver_no = zip_name.split("_")
                long_ver = ver_no[1]
                ver = long_ver.split(".")
                major_ver = ver[0]
                rel = ver_no[3].split(".")
                rel_long = str(rel[0])
                with open(env_file, 'r') as environ_file:
                    env = Prop(environ_file.read())
                    env.WSA_VER = long_ver
                    env.WSA_MAJOR_VER = major_ver
                    env.WSA_REL = rel_long
                with open(env_file, 'w') as environ_file:
                    environ_file.write(str(env))
        if 'language' in filename_lower or 'scale' in filename_lower:
            name = f.filename.split("_")[2].split(".")[0]
            zip.extract(f, workdir)
            with zipfile.ZipFile(workdir / f.filename) as l:
                for g in l.filelist:
                    if g.filename == 'resources.pri':
                        g.filename = f'resources.{name}.pri'
                        l.extract(g, pridir)
                    elif g.filename == 'AppxManifest.xml':
                        g.filename = f'resources.{name}.xml'
                        l.extract(g, xmldir)
                    elif re.search(r'Images/.+\.png', g.filename):
                        l.extract(g, archdir)
