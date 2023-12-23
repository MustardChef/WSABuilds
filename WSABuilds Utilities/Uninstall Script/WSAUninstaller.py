# WSAUninstaller 
# Version: 1.1.0
#
#
# This file is part of the WSABuilds project.
#
# WSAUninstaller is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# WSAUninstaller is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with WSAUninstaller.  If not, see <https://www.gnu.org/licenses/>.
#
# Copyright (C) 2023 MustardChef
#


import os
import shutil
import subprocess
import winreg
import ctypes
import logging
import tkinter as tk
from tkinter import messagebox

# Check if the script is running as an administrator
def is_admin():
    try:
        return ctypes.windll.shell32.IsUserAnAdmin()
    except:
        return False

if not is_admin():
    print("Please run this script as an administrator.")
    exit()

# Define the package full name
package_full_name = 'MicrosoftCorporationII.WindowsSubsystemForAndroid'

target_string = "MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe"
start_menu_dir = "C:\\ProgramData\\Microsoft\\Windows\\Start Menu\\Programs"

# Define the directories to check
dirs_to_check = [
    os.path.expandvars(r'%LocalAppData%\Microsoft\WindowsApps\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe'),
    os.path.expandvars(r'%LocalAppData%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe'),
    os.path.expandvars(r'C:\Windows\System32\config\systemprofile\AppData\Local\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe'),
    os.path.expandvars(r'%LocalAppData%\Microsoft\WindowsApps\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe'),
    os.path.expandvars(r'C:\ProgramData\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe'),
    os.path.expandvars(r'%LocalAppData%\Local\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe')
]

def with_restore_point_creation_frequency(minutes, func):
    # Define the key path
    key_path = r'SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore'

    # Open the key
    key = winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, key_path, 0, winreg.KEY_ALL_ACCESS)

    # Save the current value
    try:
        current_value, _ = winreg.QueryValueEx(key, 'SystemRestorePointCreationFrequency')
    except FileNotFoundError:
        current_value = None

    # Set the new value
    winreg.SetValueEx(key, 'SystemRestorePointCreationFrequency', 0, winreg.REG_DWORD, minutes)

    try:
        # Call the function
        func()
    finally:
        # Restore the original value
        if current_value is not None:
            winreg.SetValueEx(key, 'SystemRestorePointCreationFrequency', 0, winreg.REG_DWORD, current_value)
        else:
            winreg.DeleteValue(key, 'SystemRestorePointCreationFrequency')

    # Close the key
    winreg.CloseKey(key)

def create_restore_point(name):
    # Define the command
    cmd = f'powershell.exe -Command "Checkpoint-Computer -Description \'{name}\' -RestorePointType \'MODIFY_SETTINGS\'"'

    # Run the command
    result = subprocess.run(cmd, shell=True)

    # Check the return code
    if result.returncode != 0:
        raise Exception(f'Failed to create restore point. Command returned {result.returncode}')

def uninstall_msix_package(package_full_name):
    # Define the PowerShell command
    cmd = f'powershell.exe -Command "Get-AppxPackage *{package_full_name}* | Remove-AppxPackage"'

    # Run the command
    subprocess.run(cmd, shell=True)

def delete_directory(dir_path):
    # Check if the directory exists
    if os.path.exists(dir_path):
        # Delete the directory
        shutil.rmtree(dir_path)

def delete_registry_folders():
    try:
        key = winreg.OpenKey(winreg.HKEY_CURRENT_USER, r"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall", 0, winreg.KEY_ALL_ACCESS)
    except WindowsError as e:
        logging.error(f"Failed to open key: {e}")
        return
    i = 0
    while True:
        try:
            subkey_name = winreg.EnumKey(key, i)
            if "MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe" in subkey_name:
                try:
                    winreg.DeleteKeyEx(key, subkey_name)
                    logging.info(f"Deleted key: {subkey_name}")
                except WindowsError as e:
                    logging.error(f"Failed to delete key {subkey_name}: {e}")
            i += 1
        except WindowsError:
            # No more subkey to enumerate
            break
    winreg.CloseKey(key)

def delete_folders_and_files(root_path):
    target_string = 'MicrosoftCorporationII.WindowsSubsystemForAndroid'
    
    # Walk through the file system starting from the root_path
    for dirpath, dirnames, filenames in os.walk(root_path):
        
        # Check each directory
        for dirname in dirnames:
            if target_string in dirname:
                full_dir_path = os.path.join(dirpath, dirname)
                print(f"Deleting directory: {full_dir_path}")
                shutil.rmtree(full_dir_path)
        
        # Check each file
        for filename in filenames:
            if target_string in filename:
                full_file_path = os.path.join(dirpath, filename)
                print(f"Deleting file: {full_file_path}")
                os.remove(full_file_path)    

def delete_shortcuts(target_string, start_menu_dir):
    # Walk through the file system starting from the start_menu_dir
    for dirpath, dirnames, filenames in os.walk(start_menu_dir):
        for filename in filenames:
            full_file_path = os.path.join(dirpath, filename)
            target_location = os.path.realpath(full_file_path)
            if target_string in target_location:
                print(f"Deleting shortcut: {full_file_path}")
                os.remove(full_file_path)



def main():
    # Create a system restore point
    create_restore_point("WSABuilds Uninstallation Script Restore Point")

    # Uninstall the MSIX package
    uninstall_msix_package(package_full_name)

    # Check and delete the directories
    for dir_path in dirs_to_check:
        delete_directory(dir_path)

    # Delete the files and folders in the WindowsApps folder
    delete_folders_and_files('C:\\ProgramData\\Microsoft\\Windows\\WindowsApps')

    # Delete the registry folders
    delete_registry_folders()
    
    # Delete the shortcuts
    delete_shortcuts(target_string, start_menu_dir)

if __name__ == '__main__':
    with_restore_point_creation_frequency(0, main)