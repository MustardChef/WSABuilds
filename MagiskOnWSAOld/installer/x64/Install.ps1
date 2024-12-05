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
# Copyright (C) 2023 LSPosed Contributors
#

$Host.UI.RawUI.WindowTitle = "Installing MagiskOnWSA..."

function Finish {
    Clear-Host
    Start-Process "shell:AppsFolder\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe!SettingsApp"
    Start-Process "wsa://com.topjohnwu.magisk"
    Start-Process "wsa://com.android.vending"
    Start-Process "wsa://com.android.settings"

    Write-Output "All Done!`r`nPress any key to exit"
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    exit 0
}

$pwsh = "powershell.exe"

if ((New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) -ne $true) {
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force
    $Proc = Start-Process -PassThru -Verb RunAs $pwsh -Args "-ExecutionPolicy Bypass -Command Set-Location '$PSScriptRoot'; &'$PSCommandPath' EVAL"
    if ($null -ne $Proc) {
        $Proc.WaitForExit()
    }
    if ($null -eq $Proc -or $Proc.ExitCode -ne 0) {
        Write-Warning "`r`nFailed to launch start as Administrator`r`nPress any key to exit"
        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
    }
    exit
} elseif (($args.Count -eq 1) -and ($args[0] -eq "EVAL")) {
    Start-Process $pwsh -NoNewWindow -Args "-ExecutionPolicy Bypass -Command Set-Location '$PSScriptRoot'; &'$PSCommandPath'"
    exit
}

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"

if ($(Get-WindowsOptionalFeature -Online -FeatureName 'VirtualMachinePlatform').State -ne "Enabled") {
    Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName 'VirtualMachinePlatform'
    Write-Warning "`r`nNeed restart to enable virtual machine platform`r`nPress y to restart or press any key to exit"
    $Key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    if ("y" -eq $Key.Character) {
        Restart-Computer -Confirm
    } else {
        exit 1
    }
}

if ((Test-Path -Path 'uwp') -eq $true) {
    [xml]$Xml = Get-Content ".\AppxManifest.xml";
    $Name = $Xml.Package.Identity.Name;
    Write-Output "Installing $Name version: $($Xml.Package.Identity.Version)"
    $ProcessorArchitecture = $Xml.Package.Identity.ProcessorArchitecture;
    $Dependencies = $Xml.Package.Dependencies.PackageDependency;
    $Dependencies | ForEach-Object {
        $InstalledVersion = Get-AppxPackage -Name $_.Name  | ForEach-Object { if ($_.Architecture -eq  $ProcessorArchitecture) { $_ } } | Sort-Object -Property Version | Select-Object -ExpandProperty Version -Last 1
        if ( $InstalledVersion -lt $_.MinVersion ) {
            if ($env:WT_SESSION) {
                $env:WT_SESSION = $null
                Write-Output "`r`nDependency should be installed but Windows Terminal is in use. Restarting to conhost.exe"
                Start-Process conhost.exe -Args "powershell.exe -ExecutionPolicy Bypass -Command Set-Location '$PSScriptRoot'; &'$PSCommandPath'"
                exit 1
            }
            Write-Output "Dependency package $($_.Name) $ProcessorArchitecture required minimum version: $($_.MinVersion). Installing..."
            Add-AppxPackage -ForceApplicationShutdown -ForceUpdateFromAnyVersion -Path "uwp\$($_.Name)_$ProcessorArchitecture.appx"
        } else {
            Write-Output "Dependency package $($_.Name) $ProcessorArchitecture current version: $InstalledVersion.`r`nNothing to do."
        }
    }
} else {
    Write-Warning "`r`nIgnored install WSA dependencies."
}

$Installed = $null
$Installed = Get-AppxPackage -Name $Name

if (($null -ne $Installed) -and (-not ($Installed.IsDevelopmentMode))) {
    Write-Warning "`r`nThere is already one installed WSA.`r`nPlease uninstall it first.`r`n`r`nPress y to uninstall existing WSA or press any key to exit"
    $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    if ("y" -eq $key.Character) {
        Clear-Host
        Remove-AppxPackage -Package $Installed.PackageFullName
    } else {
        exit 1
    }
}

if ($Installed) {
    Write-Output "`r`nShutting down WSA..."
    Start-Process WsaClient -Wait -Args "/shutdown"
}
Stop-Process -Name "WsaClient" -ErrorAction SilentlyContinue

Write-Output "`r`nInstalling MagiskOnWSA..."

Add-AppxPackage -ForceApplicationShutdown -ForceUpdateFromAnyVersion -Register .\AppxManifest.xml
if ($?) {
    Finish
} elseif ($null -ne $Installed) {
    Write-Error "`r`nFailed to update.`r`nPress any key to uninstall existing installation while preserving user data.`r`nTake in mind that this will remove the Android apps' icon from the start menu.`r`nIf you want to cancel, close this window now."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    Clear-Host
    Remove-AppxPackage -PreserveApplicationData -Package $Installed.PackageFullName
    Add-AppxPackage -ForceApplicationShutdown -ForceUpdateFromAnyVersion -Register .\AppxManifest.xml
    if ($?) {
        Finish
    }
}
