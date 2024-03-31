import os
import json
import requests
import logging
import subprocess
logging.captureWarnings(True)
env_file = os.getenv('GITHUB_ENV')
new_version_found = False
currentver = requests.get(f"https://raw.githubusercontent.com/MustardChef/WSABuilds/update/gapps.appversion").text.replace('\n', '')
git = (
    "git checkout -f update || git switch --discard-changes --orphan update"
)
with open('gapps.appversion', 'w') as file:
  file.write(currentver)
if not new_version_found:
    latestver = ""
    mtgmsg = ""
    latestver = json.loads(requests.get(f"https://api.github.com/repos/MustardChef/MindTheGappsArchived/releases/latest").content)['name'].replace('\n', '')
    mtgmsg="Update MindTheGapps Version from `v" + currentver + "` to `v" + latestver + "`"
    if currentver != latestver:
        print("New version found: " + latestver)
        new_version_found = True
        subprocess.Popen(git, shell=True, stdout=None, stderr=None, executable='/bin/bash').wait()
        with open('gapps.appversion', 'w+') as file:
            file.seek(0)
            file.truncate()
            file.write(latestver)
        with open(env_file, "a") as wr:
           wr.write(f"MTG_MSG={mtgmsg}\n")
    else:
        mtgmsg = "MindTheGapps Package Version: `" + latestver + "`"
        with open(env_file, "a") as wr:
           wr.write(f"MTG_MSG={mtgmsg}\n")
    file.close()   
