import os
import json
import requests
import logging
import subprocess
logging.captureWarnings(True)
env_file = os.getenv('GITHUB_ENV')
new_version_found = False
currentver = requests.get(f"https://raw.githubusercontent.com/MustardChef/WSABuilds/update/kernelsu.appversion").text.replace('\n', '')
git = (
    "git checkout -f update || git switch --discard-changes --orphan update"
)
with open('kernelsu.appversion', 'w') as file:
    file.write(currentver)
if not new_version_found:
    latestver = ""
    kernelsumsg = ""
    latestver = json.loads(requests.get(f"https://api.github.com/repos/tiann/kernelsu/releases/latest").content)['tag_name'].replace('v', '').replace('\n', '')
    kernelsumsg="Update KernelSU Version from `v" + currentver + "` to `v" + latestver + "`"
    if currentver != latestver:
        print("New version found: " + latestver)
        new_version_found = True
        subprocess.Popen(git, shell=True, stdout=None, stderr=None, executable='/bin/bash').wait()
        with open('kernelsu.appversion', 'w+') as file:
            file.seek(0)
            file.truncate()
            file.write(latestver)
        with open(env_file, "a") as wr:
             wr.write(f"KERNEL_SU_MSG={kernelsumsg}\n")
    else:
        kernelsumsg = "KernelSU Version: `" + latestver + "`"
        with open(env_file, "a") as wr:
             wr.write(f"KERNEL_SU_MSG={kernelsumsg}\n")
    file.close() 
