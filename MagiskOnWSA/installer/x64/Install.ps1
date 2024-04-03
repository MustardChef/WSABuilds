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

$Host.UI.RawUI.WindowTitle = "Installing MagiskOnWSA...."
function Test-Administrator {
    [OutputType([bool])]
    param()
    process {
        [Security.Principal.WindowsPrincipal]$user = [Security.Principal.WindowsIdentity]::GetCurrent();
        return $user.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator);
    }
}

function Get-InstalledDependencyVersion {
    param (
        [string]$Name,
        [string]$ProcessorArchitecture
    )
    PROCESS {
        If ($null -Ne $ProcessorArchitecture) {
            return Get-AppxPackage -Name $Name | ForEach-Object { if ($_.Architecture -Eq $ProcessorArchitecture) { $_ } } | Sort-Object -Property Version | Select-Object -ExpandProperty Version -Last 1;
        }
    }
}

Function Test-CommandExist {
    Param ($Command)
    $OldPreference = $ErrorActionPreference
    $ErrorActionPreference = 'stop'
    try { if (Get-Command $Command) { RETURN $true } }
    Catch { RETURN $false }
    Finally { $ErrorActionPreference = $OldPreference }
} #end function Test-CommandExist

Function Finish {
    Clear-Host
    Start-Process "wsa://com.topjohnwu.magisk"
    Start-Process "wsa://com.android.vending"
}

If (Test-CommandExist pwsh.exe) {
    $pwsh = "pwsh.exe"
}
Else {
    $pwsh = "powershell.exe"
}

If (-Not (Test-Administrator)) {
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force
    $Proc = Start-Process -PassThru -Verb RunAs $pwsh -Args "-ExecutionPolicy Bypass -Command Set-Location '$PSScriptRoot'; &'$PSCommandPath' EVAL"
    If ($null -Ne $Proc) {
        $Proc.WaitForExit()
    }
    If ($null -Eq $Proc -Or $Proc.ExitCode -Ne 0) {
        Write-Warning "Failed to launch start as Administrator`r`nPress any key to exit"
        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
    }
    exit
}
ElseIf (($args.Count -Eq 1) -And ($args[0] -Eq "EVAL")) {
    Start-Process $pwsh -NoNewWindow -Args "-ExecutionPolicy Bypass -Command Set-Location '$PSScriptRoot'; &'$PSCommandPath'"
    exit
}

$FileList = Get-Content -Path .\filelist.txt
If (((Test-Path -Path $FileList) -Eq $false).Count) {
    Write-Error "Some files are missing in the folder. Please try to build again. Press any key to exit"
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    exit 1
}

If (((Test-Path -Path "MakePri.ps1") -And (Test-Path -Path "makepri.exe")) -Eq $true) {
    $ProcMakePri = Start-Process $pwsh -PassThru -NoNewWindow -Args "-ExecutionPolicy Bypass -File MakePri.ps1" -WorkingDirectory $PSScriptRoot
    $null = $ProcMakePri.Handle
    $ProcMakePri.WaitForExit()
    If ($ProcMakePri.ExitCode -Ne 0) {
        Write-Warning "Failed to merge resources, WSA Seetings will always be in English`r`nPress any key to continue"
        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    }
    $Host.UI.RawUI.WindowTitle = "Installing MagiskOnWSA...."
}

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"

# When using PowerShell which is installed with MSIX
# Get-WindowsOptionalFeature and Enable-WindowsOptionalFeature will fail
# See https://github.com/PowerShell/PowerShell/issues/13866
if ($PSHOME.contains("8wekyb3d8bbwe")) {
    Import-Module DISM -UseWindowsPowerShell
}

If ($(Get-WindowsOptionalFeature -Online -FeatureName 'VirtualMachinePlatform').State -Ne "Enabled") {
    Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName 'VirtualMachinePlatform'
    Write-Warning "Need restart to enable virtual machine platform`r`nPress y to restart or press any key to exit"
    $Key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    If ("y" -Eq $Key.Character) {
        Restart-Computer -Confirm
    }
    Else {
        exit 1
    }
}

[xml]$Xml = Get-Content ".\AppxManifest.xml";
$Name = $Xml.Package.Identity.Name;
Write-Output "Installing $Name version: $($Xml.Package.Identity.Version)"
$ProcessorArchitecture = $Xml.Package.Identity.ProcessorArchitecture;
$Dependencies = $Xml.Package.Dependencies.PackageDependency;
$Dependencies | ForEach-Object {
    $InstalledVersion = Get-InstalledDependencyVersion -Name $_.Name -ProcessorArchitecture $ProcessorArchitecture;
    If ( $InstalledVersion -Lt $_.MinVersion ) {
        If ($env:WT_SESSION) {
            $env:WT_SESSION = $null
            Write-Output "Dependency should be installed but Windows Terminal is in use. Restarting to conhost.exe"
            Start-Process conhost.exe -Args "powershell.exe -ExecutionPolicy Bypass -Command Set-Location '$PSScriptRoot'; &'$PSCommandPath'"
            exit 1
        }
        Write-Output "Dependency package $($_.Name) $ProcessorArchitecture required minimum version: $($_.MinVersion). Installing...."
        Add-AppxPackage -ForceApplicationShutdown -ForceUpdateFromAnyVersion -Path "$($_.Name)_$ProcessorArchitecture.appx"
    }
    Else {
        Write-Output "Dependency package $($_.Name) $ProcessorArchitecture current version: $InstalledVersion. Nothing to do."
    }
}

$Installed = $null
$Installed = Get-AppxPackage -Name $Name

If (($null -Ne $Installed) -And (-Not ($Installed.IsDevelopmentMode))) {
    Write-Warning "There is already one installed WSA. Please uninstall it first.`r`nPress y to uninstall existing WSA or press any key to exit"
    $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    If ("y" -Eq $key.Character) {
        Clear-Host
        Remove-AppxPackage -Package $Installed.PackageFullName
    }
    Else {
        exit 1
    }
}

If (Test-CommandExist WsaClient) {
    Write-Output "Shutting down WSA...."
    Start-Process WsaClient -Wait -Args "/shutdown"
}
Stop-Process -Name "WsaClient" -ErrorAction SilentlyContinue
Write-Output "Installing MagiskOnWSA...."
Add-AppxPackage -ForceApplicationShutdown -ForceUpdateFromAnyVersion -Register .\AppxManifest.xml
If ($?) {
    Finish
}
ElseIf ($null -Ne $Installed) {
    Write-Error "Failed to update.`r`nPress any key to uninstall existing installation while preserving user data.`r`nTake in mind that this will remove the Android apps' icon from the start menu.`r`nIf you want to cancel, close this window now."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    Clear-Host
    Remove-AppxPackage -PreserveApplicationData -Package $Installed.PackageFullName
    Add-AppxPackage -ForceApplicationShutdown -ForceUpdateFromAnyVersion -Register .\AppxManifest.xml
    If ($?) {
        Finish
    }
}
Write-Output "All Done!`r`nPress any key to exit"
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
