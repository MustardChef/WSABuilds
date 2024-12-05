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
    workdir.mkdir(parents=True, exist_ok=True)

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
    if 'WSA_WORK_ENV' in os.environ and Path(os.environ['WSA_WORK_ENV']).is_file():
        with open(os.environ['WSA_WORK_ENV'], 'r') as environ_file:
            env = Prop(environ_file.read())
            env.MAGISK_VERSION_NAME = versionName
            env.MAGISK_VERSION_CODE = versionCode
        with open(os.environ['WSA_WORK_ENV'], 'w') as environ_file:
            environ_file.write(str(env))
    if f"lib/{ abi_map[arch][0] }/libmagisk64.so" in zip.namelist():
        extract_as(zip, f"lib/{ abi_map[arch][0] }/libmagisk64.so", "magisk64", "magisk")
        extract_as(zip, f"lib/{ abi_map[arch][1] }/libmagisk32.so", "magisk32", "magisk")
    else:
        extract_as(zip, f"lib/{ abi_map[arch][0] }/libmagisk.so", "magisk", "magisk")
    if f"lib/{ abi_map[arch][0] }/libinit-ld.so" in zip.namelist():
        extract_as(zip, f"lib/{ abi_map[arch][0] }/libinit-ld.so", "init-ld", "magisk")
    extract_as(zip, f"lib/{ abi_map[arch][0] }/libmagiskinit.so", "magiskinit", "magisk")
    extract_as(zip, f"lib/{ abi_map[host_abi][0] }/libmagiskboot.so", "magiskboot", "magisk")

    standalone_policy = False
    try:
        zip.getinfo(f"lib/{ abi_map[arch][0] }/libmagiskpolicy.so")
        standalone_policy = True
    except:
        pass

    if standalone_policy:
        extract_as(zip, f"lib/{ abi_map[arch][0] }/libmagiskpolicy.so", "magiskpolicy", "magisk")
    else:
        extract_as(zip, f"lib/{ abi_map[arch][0] }/libmagiskinit.so", "magiskpolicy", "magisk")

    extract_as(zip, f"lib/{ abi_map[arch][0] }/libbusybox.so", "busybox", "magisk")

    if standalone_policy:
        extract_as(zip, f"lib/{ abi_map[host_abi][0] }/libmagiskpolicy.so", "magiskpolicy", ".")
    else:
        extract_as(zip, f"lib/{ abi_map[host_abi][0] }/libmagiskinit.so", "magiskpolicy", ".")

    extract_as(zip, f"assets/boot_patch.sh", "boot_patch.sh", "magisk")
    extract_as(zip, f"assets/util_functions.sh", "util_functions.sh", "magisk")