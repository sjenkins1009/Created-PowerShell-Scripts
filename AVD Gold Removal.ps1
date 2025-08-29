#Uninstall LTAgent
 function UnInstall-AutomateAgent (
    param (
        OptionalParameters
    )
    echo "Uninstalling LT Service Agent"
    (new-object Net.WebClient).DownloadString('https://bit.ly/LTPoSh') | iex
    Uninstall-LTService    
 )
 #Uninstall ConnectSecure CyberCNS Anget
function UnInstall-ConnectSecure (
    param (
        OptionalParameters
    )
    echo "Uninstalling Connect Secure Agent"
    cd "C:\Program Files (x86)\CyberCNSAgent"
    cybercnsagent.exe -r
        
)
 #Uninstall ScreenConnect
 function Uninstall-ScreenConnect (
    param (
        OptionalParameters
    )
    echo "Uninstalling ScreenConnect Agent"
    $ScreenConnect = Get-ItemProperty HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object ($_.DisplayName -like "ScreenConnect*") | Select-Object -ExpandProperty DisplayName
    
    foreach ($sc in $ScreenConnect) (
        wmic product where "name= '$sc'" call uninstall /nointeractive
            
        )   
 )
 #Uninstall ImmyBot
  function Uninstall-ImmyBot 
( 
    echo "Uninstalling ImmyBot Agent"
    $product = Get-WmiObject win32_product | where($_.name -eq "ImmyBot Agent") $product.IdentifyingNumber

msiexec /x $product.IdentifyingNumber /quiet /noreboot
 ) 
       
 
#Uninstall Quickpass
 function UnInstall-QuickPass (
    param (
        OptionalParameters
    )
    #CyberQP Uninstall Script Updated 9.18.2023
    #Script for Uninstalling the Agent from the Package Cache on the System instead of relying on the Latest Download.
    
    
    # Specify a display name or a partial display name of the application
    $partialDisplayName = "Quickpass" # Replace with the display name or partial display name
    
    # Specify the MSI name
    $msiName = "Quickpass-Agent-x64.msi"
    
    # Specify the executable name
    $executableName = "quickpass-agent-setup.exe"
    
    # Specify the uninstall arguments
    $uninstallArguments = "/uninstall /quiet"
    
    # Path to search for the executable
    $searchPath = "C:\ProgramData\Package Cache"
    
    # Search for the executable and uninstall if found
    $executablePath = Get-ChildItem -Path $searchPath -Recurse -Filter $executableName -File | Select-Object -ExpandProperty FullName
    
    # Enumerate subkeys under the specified registry path
    $productsRegistryPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Products"
    $subkeys = Get-ChildItem -Path $productsRegistryPath
    
    foreach ($subkey in $subkeys) (
    $installPropertiesPath = Join-Path -Path $subkey.PSPath -ChildPath "InstallProperties"
    
    if (Test-Path -Path $installPropertiesPath) (
    $installProperties = Get-ItemProperty -Path $installPropertiesPath -ErrorAction SilentlyContinue
    
    if ($installProperties -and $installProperties.DisplayName -like "*$partialDisplayName*") (
    $installSource = $installProperties.InstallSource
    
    if (-not [string]::IsNullOrWhiteSpace($installSource)) (
    $msiPath = Join-Path -Path $installSource -ChildPath $msiName
    
    Write-Host "Uninstalling application with DisplayName matching '$partialDisplayName' from MSI: $msiPath"
    Start-Process msiexec -ArgumentList "/x `"$msiPath`" /qb" -Wait
    ) else (
    Write-Host "InstallSource not found for application with DisplayName matching '$partialDisplayName'."
    )
    )
    )
    )
    if ($executablePath) (
    Write-Host "Found $executableName at: $executablePath"
    Write-Host "Uninstalling $executableName..."
    
    # Run the uninstall command
    Start-Process -FilePath $executablePath -ArgumentList $uninstallArguments -Wait
    
    Write-Host "$executableName has been uninstalled."
    ) else (
    Write-Host "$executableName not found in $searchPath."
    )
)
 
UnInstall-AutomateAgent
Uninstall-ScreenConnect
Uninstall-ImmyBot
