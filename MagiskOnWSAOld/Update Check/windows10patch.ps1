Clear-Host
Write-Output "`r`nPatching Windows 10 AppxManifest file..."
$xml = [xml](Get-Content '.\AppxManifest.xml')
$nsm = New-Object Xml.XmlNamespaceManager($xml.NameTable)
$nsm.AddNamespace('rescap', "http://schemas.microsoft.com/appx/manifest/foundation/windows10/restrictedcapabilities")
$nsm.AddNamespace('desktop6', "http://schemas.microsoft.com/appx/manifest/desktop/windows10/6")
$node = $xml.Package.Capabilities.SelectSingleNode("rescap:Capability[@Name='customInstallActions']", $nsm)
$xml.Package.Capabilities.RemoveChild($node) | Out-Null
$node = $xml.Package.Extensions.SelectSingleNode("desktop6:Extension[@Category='windows.customInstall']", $nsm)
$xml.Package.Extensions.RemoveChild($node) | Out-Null
$xml.Package.Dependencies.TargetDeviceFamily.MinVersion = "10.0.19041.264"
$xml.Save(".\AppxManifest.xml")
Clear-Host
Write-Output "`r`nDownloading modifided DLL file..."
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri "https://github.com/MustardChef/WSAPatch/raw/main/DLLs%20for%20WSABuilds/winhttp.dll" -OutFile "$outputDir\WSAClient\winhttp.dll"
Invoke-WebRequest -Uri "https://github.com/MustardChef/WSAPatch/raw/main/DLLs%20for%20WSABuilds/WsaPatch.dll" -OutFile "$outputDir\WSAClient\WsaPatch.dll"
Invoke-WebRequest -Uri "https://github.com/MustardChef/WSAPatch/raw/main/DLLs%20for%20WSABuilds/icu.dll" -OutFile "$outputDir\WSAClient\icu.dll"
