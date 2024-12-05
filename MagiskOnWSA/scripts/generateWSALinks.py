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

import html
import logging
import re
import sys

from pathlib import Path
from threading import Thread
from typing import Any, OrderedDict
from xml.dom import minidom

from requests import Session
from packaging import version


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


logging.captureWarnings(True)
arch = sys.argv[1]

release_name_map = {"retail": "Retail", "RP": "Release Preview",
                    "WIS": "Insider Slow", "WIF": "Insider Fast"}
release_type = sys.argv[2] if sys.argv[2] != "" else "Retail"
release_name = release_name_map[release_type]
download_dir = Path.cwd().parent / \
    "download" if sys.argv[3] == "" else Path(sys.argv[3])
ms_account_conf = download_dir/".ms_account"
tempScript = sys.argv[4]
skip_wsa_download = sys.argv[5] == "1" if len(sys.argv) >= 6 else False
cat_id = '858014f3-3934-4abe-8078-4aa193e74ca8'
user = ''
session = Session()
session.verify = False
if ms_account_conf.is_file():
    with open(ms_account_conf, "r") as f:
        conf = Prop(f.read())
        user = conf.get('user_code')
print(
    f"Generating WSA download link: arch={arch} release_type={release_name}\n", flush=True)
with open(Path.cwd().parent / ("xml/GetCookie.xml"), "r") as f:
    cookie_content = f.read().format(user)

out = session.post(
    'https://fe3.delivery.mp.microsoft.com/ClientWebService/client.asmx',
    data=cookie_content,
    headers={'Content-Type': 'application/soap+xml; charset=utf-8'}
)
doc = minidom.parseString(out.text)
cookie = doc.getElementsByTagName('EncryptedData')[0].firstChild.nodeValue

with open(Path.cwd().parent / "xml/WUIDRequest.xml", "r") as f:
    cat_id_content = f.read().format(user, cookie, cat_id, release_type)

out = session.post(
    'https://fe3.delivery.mp.microsoft.com/ClientWebService/client.asmx',
    data=cat_id_content,
    headers={'Content-Type': 'application/soap+xml; charset=utf-8'}
)

doc = minidom.parseString(html.unescape(out.text))

filenames = {}
for node in doc.getElementsByTagName('ExtendedUpdateInfo')[0].getElementsByTagName('Updates')[0].getElementsByTagName('Update'):
    node_xml = node.getElementsByTagName('Xml')[0]
    node_files = node_xml.getElementsByTagName('Files')
    if not node_files:
        continue
    else:
        for node_file in node_files[0].getElementsByTagName('File'):
            if node_file.hasAttribute('InstallerSpecificIdentifier') and node_file.hasAttribute('FileName'):
                filenames[node.getElementsByTagName('ID')[0].firstChild.nodeValue] = (f"{node_file.attributes['InstallerSpecificIdentifier'].value}_{node_file.attributes['FileName'].value}",
                                                                                      node_xml.getElementsByTagName('ExtendedProperties')[0].attributes['PackageIdentityName'].value)

identities = {}
for node in doc.getElementsByTagName('NewUpdates')[0].getElementsByTagName('UpdateInfo'):
    node_xml = node.getElementsByTagName('Xml')[0]
    if not node_xml.getElementsByTagName('SecuredFragment'):
        continue
    else:
        id = node.getElementsByTagName('ID')[0].firstChild.nodeValue
        update_identity = node_xml.getElementsByTagName('UpdateIdentity')[0]
        if id in filenames:
            fileinfo = filenames[id]
            if fileinfo[0] not in identities:
                identities[fileinfo[0]] = ([update_identity.attributes['UpdateID'].value,
                                            update_identity.attributes['RevisionNumber'].value], fileinfo[1])

with open(Path.cwd().parent / "xml/FE3FileUrl.xml", "r") as f:
    FE3_file_content = f.read()

if not download_dir.is_dir():
    download_dir.mkdir()

tmpdownlist = open(download_dir/tempScript, 'a')
download_files = {}


def send_req(i, v, out_file_name):
    out = session.post(
        'https://fe3.delivery.mp.microsoft.com/ClientWebService/client.asmx/secured',
        data=FE3_file_content.format(user, i, v, release_type),
        headers={'Content-Type': 'application/soap+xml; charset=utf-8'}
    )
    doc = minidom.parseString(out.text)
    for l in doc.getElementsByTagName("FileLocation"):
        url = l.getElementsByTagName("Url")[0].firstChild.nodeValue
        if len(url) != 99:
            download_files[out_file_name] = url


threads = []
wsa_build_ver = 0
for filename, values in identities.items():
    if re.match(rf"MicrosoftCorporationII\.WindowsSubsystemForAndroid_.*\.msixbundle", filename):
        tmp_wsa_build_ver = re.search(
            r'\d{4}.\d{5}.\d{1,}.\d{1,}', filename).group()
        if (wsa_build_ver == 0):
            wsa_build_ver = tmp_wsa_build_ver
        elif version.parse(wsa_build_ver) < version.parse(tmp_wsa_build_ver):
            wsa_build_ver = tmp_wsa_build_ver
for filename, values in identities.items():
    if re.match(rf"Microsoft\.UI\.Xaml\..*_{arch}_.*\.appx", filename):
        out_file_name = f"{values[1]}_{arch}.appx"
        out_file = download_dir / out_file_name
    elif re.match(rf"Microsoft\.VCLibs\..+\.UWPDesktop_.*_{arch}_.*\.appx", filename):
        out_file_name = f"{values[1]}_{arch}.appx"
        out_file = download_dir / out_file_name
    elif re.match(rf"Microsoft\.VCLibs\..+_.*_{arch}_.*\.appx", filename):
        out_file_name = f"{values[1]}_{arch}.appx"
        out_file = download_dir / out_file_name
    elif not skip_wsa_download and re.match(rf"MicrosoftCorporationII\.WindowsSubsystemForAndroid_.*\.msixbundle", filename):
        tmp_wsa_build_ver = re.search(
            r'\d{4}.\d{5}.\d{1,}.\d{1,}', filename).group()
        if (wsa_build_ver != tmp_wsa_build_ver):
            continue
        version_splitted = wsa_build_ver.split(".")
        major_ver = version_splitted[0]
        minor_ver = version_splitted[1]
        build_ver = version_splitted[2]
        revision_ver = version_splitted[3]
        out_file_name = f"wsa-{release_type}.zip"
        out_file = download_dir / out_file_name
    else:
        continue
    th = Thread(target=send_req, args=(
        values[0][0], values[0][1], out_file_name))
    threads.append(th)
    th.daemon = True
    th.start()
for th in threads:
    th.join()
print(f'WSA Build Version={wsa_build_ver}\n', flush=True)
for key, value in download_files.items():
    print(f"download link: {value}\npath: {download_dir / key}\n", flush=True)
    tmpdownlist.writelines(value + '\n')
    tmpdownlist.writelines(f'  dir={download_dir}\n')
    tmpdownlist.writelines(f'  out={key}\n')
tmpdownlist.close()
