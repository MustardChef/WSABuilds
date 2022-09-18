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

from __future__ import annotations
from io import TextIOWrapper
from typing import OrderedDict
from pathlib import Path
import sys
class Prop(OrderedDict):
    def __init__(self, file: TextIOWrapper) -> None:
        super().__init__()
        for i, line in enumerate(file.read().splitlines(False)):
            if '=' in line:
                k, v = line.split('=', 2)
                self[k] = v
            else:
                self[f".{i}"] = line

    def __str__(self) -> str:
        return '\n'.join([v if k.startswith('.') else f"{k}={v}" for k, v in self.items()])

    def __iadd__(self, other: str) -> Prop:
        self[f".{len(self)}"] = other
        return self


new_props = {
    ("product", "brand"): "google",
    ("product", "manufacturer"): "Google",
    ("build", "product"): "redfin",
    ("product", "name"): "redfin",
    ("product", "device"): "redfin",
    ("product", "model"): "Pixel 5",
    ("build", "flavor"): "redfin-user"
}


def description(sec: str, p: Prop) -> str:
    return f"{p[f'ro.{sec}.build.flavor']} {p[f'ro.{sec}.build.version.release_or_codename']} {p[f'ro.{sec}.build.id']} {p[f'ro.{sec}.build.version.incremental']} {p[f'ro.{sec}.build.tags']}"


def fingerprint(sec: str, p: Prop) -> str:
    return f"""{p[f"ro.product.{sec}.brand"]}/{p[f"ro.product.{sec}.name"]}/{p[f"ro.product.{sec}.device"]}:{p[f"ro.{sec}.build.version.release"]}/{p[f"ro.{sec}.build.id"]}/{p[f"ro.{sec}.build.version.incremental"]}:{p[f"ro.{sec}.build.type"]}/{p[f"ro.{sec}.build.tags"]}"""


def fix_prop(sec, prop):
    if not Path(prop).is_file():
        return

    print(f"fixing {prop}", flush=True)
    with open(prop, 'r') as f:
        p = Prop(f)

    p += "# extra prop added by MagiskOnWSA"

    for k, v in new_props.items():
        p[f"ro.{k[0]}.{k[1]}"] = v

        if k[0] == "build":
            p[f"ro.{sec}.{k[0]}.{k[1]}"] = v
        elif k[0] == "product":
            p[f"ro.{k[0]}.{sec}.{k[1]}"] = v

    p["ro.build.description"] = description(sec, p)
    p[f"ro.build.fingerprint"] = fingerprint(sec, p)
    p[f"ro.{sec}.build.description"] = description(sec, p)
    p[f"ro.{sec}.build.fingerprint"] = fingerprint(sec, p)
    p[f"ro.bootimage.build.fingerprint"] = fingerprint(sec, p)

    with open(prop, 'w') as f:
        f.write(str(p))


sys_path = sys.argv[1]
for sec, prop in {"system": sys_path+"/system/build.prop", "product": sys_path+"/product/build.prop", "system_ext": sys_path+"/system_ext/build.prop", "vendor": sys_path+"/vendor/build.prop", "odm": sys_path+"/vendor/odm/etc/build.prop"}.items():
    fix_prop(sec, prop)
