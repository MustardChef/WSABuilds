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
# Copyright (C) 2022 LSPosed Contributors
#

import sys

import warnings
import zipfile
import os
from pathlib import Path

warnings.filterwarnings("ignore")

arch = sys.argv[1]

zip_name = ""
wsa_zip_path= Path(sys.argv[2]).resolve()
workdir = Path(sys.argv[3]) / "wsa"
if not Path(workdir).is_dir():
    workdir.mkdir()
with zipfile.ZipFile(wsa_zip_path) as zip:
    for f in zip.filelist:
        if arch in f.filename.lower():
            zip_name = f.filename
            output_name = zip_name[11:-5]
            if not Path(workdir / zip_name).is_file():
                zip_path = workdir / zip_name
                print(f"unzipping to {workdir}", flush=True)
                zip.extract(f, workdir)
                ver_no = zip_name.split("_")
                long_ver = ver_no[1]
                ver = long_ver.split(".")
                main_ver = ver[0]
                rel = ver_no[3].split(".")
                rel_long = str(rel[0])
                with open(os.environ['WSA_WORK_ENV'], 'a') as environ_file:
                    environ_file.write(f'WSA_VER={long_ver}\n')
                    environ_file.write(f'WSA_MAIN_VER={main_ver}\n')
                    environ_file.write(f'WSA_REL={rel_long}\n')
                with open(os.environ['GITHUB_ENV'], 'a') as environ_file:
                    environ_file.write(f'WSA_VER={long_ver}\n')
        if 'language' in f.filename.lower() or 'scale' in f.filename.lower():
            name = f.filename.split("-", 1)[1].split(".")[0]
            zip.extract(f, workdir)
            with zipfile.ZipFile(workdir / f.filename) as l:
                for g in l.filelist:
                    if g.filename == 'resources.pri':
                        g.filename = f'{name}.pri'
                        l.extract(g, workdir / 'pri')
                    elif g.filename == 'AppxManifest.xml':
                        g.filename = f'{name}.xml'
                        l.extract(g, workdir / 'xml')
with zipfile.ZipFile(zip_path) as zip:
    if not Path(workdir / arch).is_dir():
        print(f"unzipping from {zip_path}", flush=True)
        zip.extractall(workdir / arch)
