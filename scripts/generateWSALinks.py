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

import requests
from xml.dom import minidom
import html
import warnings
import re
from pathlib import Path

warnings.filterwarnings("ignore")

arch = sys.argv[1]

release_name_map = {"retail": "Retail", "RP": "Release Preview",
                    "WIS": "Insider Slow", "WIF": "Insider Fast"}
release_type = sys.argv[2] if sys.argv[2] != "" else "Retail"
release_name = release_name_map[release_type]
download_dir = Path.cwd().parent / "download" if sys.argv[3] == "" else Path(sys.argv[3]).resolve()
tempScript = sys.argv[4]
cat_id = '858014f3-3934-4abe-8078-4aa193e74ca8'
print(f"Generating WSA download link: arch={arch} release_type={release_name}", flush=True)
with open(Path.cwd().parent / ("xml/GetCookie.xml"), "r") as f:
    cookie_content = f.read()

out = requests.post(
    'https://fe3.delivery.mp.microsoft.com/ClientWebService/client.asmx',
    data=cookie_content,
    headers={'Content-Type': 'application/soap+xml; charset=utf-8'},
    verify=False
)
doc = minidom.parseString(out.text)
cookie = doc.getElementsByTagName('EncryptedData')[0].firstChild.nodeValue

with open(Path.cwd().parent / "xml/WUIDRequest.xml", "r") as f:
    cat_id_content = f.read().format(cookie, cat_id, release_type)

out = requests.post(
    'https://fe3.delivery.mp.microsoft.com/ClientWebService/client.asmx',
    data=cat_id_content,
    headers={'Content-Type': 'application/soap+xml; charset=utf-8'},
    verify=False
)

doc = minidom.parseString(html.unescape(out.text))

filenames = {}
for node in doc.getElementsByTagName('Files'):
    filenames[node.parentNode.parentNode.getElementsByTagName(
        'ID')[0].firstChild.nodeValue] = f"{node.firstChild.attributes['InstallerSpecificIdentifier'].value}_{node.firstChild.attributes['FileName'].value}"
    pass

identities = []
for node in doc.getElementsByTagName('SecuredFragment'):
    filename = filenames[node.parentNode.parentNode.parentNode.getElementsByTagName('ID')[
        0].firstChild.nodeValue]
    update_identity = node.parentNode.parentNode.firstChild
    identities += [(update_identity.attributes['UpdateID'].value,
                    update_identity.attributes['RevisionNumber'].value, filename)]

with open(Path.cwd().parent / "xml/FE3FileUrl.xml", "r") as f:
    file_content = f.read()

if not download_dir.is_dir():
    download_dir.mkdir()
tmpdownlist = open(download_dir/tempScript, 'a')
for i, v, f in identities:
    if re.match(f"Microsoft\.UI\.Xaml\..*_{arch}_.*\.appx", f):
        out_file_name = f"Microsoft.UI.Xaml_{arch}.appx"
        out_file = download_dir / out_file_name
    # elif re.match(f"Microsoft\.VCLibs\..+\.UWPDesktop_.*_{arch}_.*\.appx", f):
    #     out_file_name = f"Microsoft.VCLibs.140.00.UWPDesktop_{arch}.appx"
    #     out_file = download_dir / out_file_name
    elif re.match(f"MicrosoftCorporationII\.WindowsSubsystemForAndroid_.*\.msixbundle", f):
        out_file_name = f"wsa-{arch}-{release_type}.zip"
        out_file = download_dir / out_file_name
    else:
        continue
    out = requests.post(
        'https://fe3.delivery.mp.microsoft.com/ClientWebService/client.asmx/secured',
        data=file_content.format(i, v, release_type),
        headers={'Content-Type': 'application/soap+xml; charset=utf-8'},
        verify=False
    )
    doc = minidom.parseString(out.text)
    for l in doc.getElementsByTagName("FileLocation"):
        url = l.getElementsByTagName("Url")[0].firstChild.nodeValue
        if len(url) != 99:
            print(f"download link: {url} to {out_file}", flush=True)
            tmpdownlist.writelines(url + '\n')
            tmpdownlist.writelines(f'  dir={download_dir}\n')
            tmpdownlist.writelines(f'  out={out_file_name}\n')
tmpdownlist.writelines(f'https://aka.ms/Microsoft.VCLibs.{arch}.14.00.Desktop.appx\n')
tmpdownlist.writelines(f'  dir={download_dir}\n')
tmpdownlist.close()
