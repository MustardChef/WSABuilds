import os
import json
import requests
import logging
import subprocess
logging.captureWarnings(True)
env_file = os.getenv('GITHUB_ENV')
new_version_found = False
git = (
    "git checkout -f update || git switch --discard-changes --orphan update"
)
currentver = requests.get(f"https://raw.githubusercontent.com/MustardChef/WSABuilds/update/magiskstable.appversion").text.replace('\n', '')
with open('magiskstable.appversion', 'w') as file:
    file.write(currentver)
if not new_version_found:
    latestver = ""
    magiskstablemsg = ""
    latestver = json.loads(requests.get(f"https://github.com/topjohnwu/magisk-files/raw/master/stable.json").content)['magisk']['version'].replace('\n', '')
    magiskstablemsg="Update Magisk Stable Version from `v" + currentver + "` to `v" + latestver + "`"
    if currentver != latestver:
        print("New version found: " + latestver)
        new_version_found = True
        subprocess.Popen(git, shell=True, stdout=None, stderr=None, executable='/bin/bash').wait()
        with open('magiskstable.appversion', 'w+') as file:
            file.seek(0)
            file.truncate()
            file.write(latestver)
        with open(env_file, "a") as wr:
            wr.write(f"MAGISK_STABLE_MSG={magiskstablemsg}\n")
    else:
        magiskstablemsg = "Magisk Stable Version: `" + latestver + "`" 
        with open(env_file, "a") as wr:
            wr.write(f"MAGISK_STABLE_MSG={magiskstablemsg}\n")
    file.close()
