import base64
from os import getenv
import html
import json
import re
import requests
import logging
import subprocess

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
env_file = getenv('GITHUB_ENV')
token = getenv("API_KEY")
authorization = f'Bearer {token}'
reqheaders = {
    "Accept": "application/vnd.github.v3+json",
    "Authorization" : authorization,
}
#Catagory ID
cat_id = '858014f3-3934-4abe-8078-4aa193e74ca8'

release_type = "WIF"

new_version_found = False

session = Session()
session.verify = False

git = (
    "git checkout -f update || git switch --discard-changes --orphan update"
)

def MagiskandGappsChecker(type):
    global new_version_found
    # Get current version
    currentver = requests.get(f"https://raw.githubusercontent.com/YT-Advanced/WSA-Script/update/" + type + ".appversion").text.replace('\n', '')
    # Write for pushing later
    file = open('../' + type + '.appversion', 'w')
    file.write(currentver)
    if new_version_found:
        return 0;

    # Get latest version
    latestver = ""
    msg = ""
    if (type == "magisk"):
        latestver = json.loads(requests.get(f"https://github.com/topjohnwu/magisk-files/raw/master/stable.json").content)['magisk']['version'].replace('\n', '')
        msg="Update Magisk Version from `v" + currentver + "` to `v" + latestver + "`"
    elif (type == "gapps"):
        latestver = json.loads(requests.get(f"https://api.github.com/repos/YT-Advanced/MindTheGappsBuilder/releases/latest", headers=reqheaders).content)['name']
        msg="Update MindTheGapps Version from `v" + currentver + "` to `v" + latestver + "`"

    # Check if version is the same or not
    if (currentver != latestver):
        print("New version found: " + latestver)
        new_version_found = True
        # Write appversion content
        subprocess.Popen(git, shell=True, stdout=None, stderr=None, executable='/bin/bash').wait()
        file.seek(0)
        file.truncate()
        file.write(latestver)
        # Write Github Environment
        with open(env_file, "a") as wr:
            wr.write("SHOULD_BUILD=yes\nMSG=" + msg)
    file.close()

def WSAChecker(user, release_type):
    global new_version_found
    currentver = requests.get(f"https://raw.githubusercontent.com/YT-Advanced/WSA-Script/update/" + release_type + ".appversion").text.replace('\n', '')

    # Write for pushing later
    file = open('../' + release_type + '.appversion', 'w')
    file.write(currentver)

    if new_version_found:
        return 0;
    # Get information
    with open("../xml/GetCookie.xml", "r") as f:
        cookie_content = f.read().format(user)
        f.close()
    try:
        out = session.post(
            'https://fe3.delivery.mp.microsoft.com/ClientWebService/client.asmx',
            data=cookie_content,
            headers={'Content-Type': 'application/soap+xml; charset=utf-8'}
        )
    except:
        print("Network Error!")
        return 1
    doc = minidom.parseString(out.text)
    cookie = doc.getElementsByTagName('EncryptedData')[0].firstChild.nodeValue
    with open("../xml/WUIDRequest.xml", "r") as f:
        cat_id_content = f.read().format(user, cookie, cat_id, release_type)
        f.close()
    try:
        out = session.post(
            'https://fe3.delivery.mp.microsoft.com/ClientWebService/client.asmx',
            data=cat_id_content,
            headers={'Content-Type': 'application/soap+xml; charset=utf-8'}
        )
    except:
        print("Network Error!")
        return 1
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
    wsa_build_ver = 0
    for filename, value in identities.items():
        if re.match(f"MicrosoftCorporationII.WindowsSubsystemForAndroid_.*.msixbundle", filename):
            tmp_wsa_build_ver = re.search(r"\d{4}.\d{5}.\d{1,}.\d{1,}", filename).group()
            if (wsa_build_ver == 0):
                wsa_build_ver = tmp_wsa_build_ver
            elif version.parse(wsa_build_ver) < version.parse(tmp_wsa_build_ver):
                wsa_build_ver = tmp_wsa_build_ver
     
    # Check new WSA version
    if version.parse(currentver) < version.parse(wsa_build_ver):
        print("New version found: " + wsa_build_ver)
        new_version_found = True
        # Write appversion content
        subprocess.Popen(git, shell=True, stdout=None, stderr=None, executable='/bin/bash').wait()
        file.seek(0)
        file.truncate()
        file.write(wsa_build_ver)
        # Write Github Environment
        msg = 'Update WSA Version from `v' + currentver + '` to `v' + wsa_build_ver + '`'
        with open(env_file, "a") as wr:
            wr.write("SHOULD_BUILD=yes\nRELEASE_TYPE=" + release_type + "\nMSG=" + msg)
    file.close()

# Get user_code (Thanks to @bubbles-wow because of his repository)
users = {""}
try:
    response = requests.get("https://api.github.com/repos/bubbles-wow/MS-Account-Token/contents/token.cfg")
    if response.status_code == 200:
        content = response.json()["content"]
        content = content.encode("utf-8")
        content = base64.b64decode(content)
        text = content.decode("utf-8")
        user_code = Prop(text).get("user_code")
        updatetime = Prop(text).get("update_time")
        print("Successfully get user token from server!")
        print(f"Last update time: {updatetime}\n")
    else:
        user_code = ""
        print(f"Failed to get user token from server! Error code: {response.status_code}\n")
except:
    user_code = ""

if user_code == "":
    users = {""}
else:
    users = {"", user_code}
for user in users:
    if user == "":
        print("Checking WSA Stable version...\n")
        if WSAChecker(user, "retail") == 1:
            break
        print("Checking Magisk version...\n")
        if MagiskandGappsChecker("magisk") == 1:
            break
        print("Checking MindTheGapps version...\n")
        if MagiskandGappsChecker("gapps") == 1:
            break
    else:
        print("Checking WSA Insider version...\n")
        if WSAChecker(user, "WIF") == 1:
            break
