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

$Host.UI.RawUI.WindowTitle = "Merging resources...."
If ((Test-Path -Path "pri") -Eq $true -And (Test-Path -Path "xml") -Eq $true) {
    $AppxManifestFile = ".\AppxManifest.xml"
    Copy-Item .\resources.pri -Destination ".\pri\resources.pri" | Out-Null
    $ProcNew = Start-Process -PassThru makepri.exe -NoNewWindow -Args "new /pr .\pri /cf .\xml\priconfig.xml /of .\resources.pri /mn $AppxManifestFile /o"
    $null = $ProcNew.Handle
    $ProcNew.WaitForExit()
    If ($ProcNew.ExitCode -Ne 0) {
        Write-Warning "Failed to merge resources from pris`r`nTrying to dump pris to priinfo...."
        New-Item -Path "." -Name "priinfo" -ItemType "directory"
        Clear-Host
        $i = 0
        $PriItem = Get-Item ".\pri\*" -Include "*.pri"
        Write-Output "Dumping resources...."
        $Processes = ForEach ($Item in $PriItem) {
            Start-Process -PassThru -WindowStyle Hidden makepri.exe -Args "dump /if $($Item | Resolve-Path -Relative) /o /es .\pri\resources.pri /of .\priinfo\$($Item.Name).xml /dt detailed"
            $i = $i + 1
            $Completed = ($i / $PriItem.count) * 100
            Write-Progress -Activity "Dumping resources" -Status "Dumping $($Item.Name):" -PercentComplete $Completed
        }
        $Processes | Wait-Process
        Write-Progress -Activity "Dumping resources" -Status "Ready" -Completed
        Clear-Host
        Write-Output "Creating pri from dumps...."
        $ProcNewFromDump = Start-Process -PassThru -NoNewWindow makepri.exe -Args "new /pr .\priinfo /cf .\xml\priconfig.xml /of .\resources.pri /mn $AppxManifestFile /o"
        $null = $ProcNewFromDump.Handle
        $ProcNewFromDump.WaitForExit()
        Remove-Item 'priinfo' -Recurse
        If ($ProcNewFromDump.ExitCode -Ne 0) {
            Write-Error "Failed to create resources from priinfos"
            exit 1
        }
    }

    $ProjectXml = [xml](Get-Content $AppxManifestFile)
    $ProjectResources = $ProjectXml.Package.Resources;
    $(Get-Item .\xml\* -Exclude "priconfig.xml" -Include "*.xml") | ForEach-Object {
        $($([xml](Get-Content $_)).Package.Resources.Resource) | ForEach-Object {
            $ProjectResources.AppendChild($($ProjectXml.ImportNode($_, $true)))
        }
    }
    $ProjectXml.Save($AppxManifestFile)
    Remove-Item 'pri' -Recurse
    Set-Content -Path "filelist.txt" -Value (Get-Content -Path "filelist.txt" | Select-String -Pattern '^pri$' -NotMatch)
    Remove-Item 'xml' -Recurse
    Set-Content -Path "filelist.txt" -Value (Get-Content -Path "filelist.txt" | Select-String -Pattern '^xml$' -NotMatch)
    Remove-Item 'makepri.exe'
    Set-Content -Path "filelist.txt" -Value (Get-Content -Path "filelist.txt" | Select-String -Pattern 'makepri.exe' -NotMatch)
    Remove-Item $PSCommandPath -Force
    Set-Content -Path "filelist.txt" -Value (Get-Content -Path "filelist.txt" | Select-String -Pattern 'MakePri.ps1' -NotMatch)
    exit 0
}
