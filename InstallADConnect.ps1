$downloadUrl = "https://download.msappproxy.net/Subscription/d3c8b69d-6bf7-42be-a529-3fe9c2e70c90/Connector/AADConnectSyncInstaller"
$outputPath = "C:\ITS\Downloads\AADConnectSyncInstaller.exe"

Invoke-WebRequest -Uri $downloadUrl -OutFile $outputPath

Write-Host "Download complete: $outputPath"