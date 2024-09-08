# PowerShell script to create an IIS server

# Check if the script is running with administrator privileges
if (-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Please run this script as an administrator."
    exit 1
}

# Install IIS feature
Write-Host "Installing IIS..."
Install-WindowsFeature -Name Web-Server -IncludeManagementTools

# Start the IIS service
Write-Host "Starting the IIS service..."
Start-Service -Name W3SVC

# Set the service to start automatically on boot
Write-Host "Configuring IIS to start automatically on boot..."
Set-Service -Name W3SVC -StartupType 'Automatic'

# Display the server's IP address and IIS version
$ipAddress = (Get-NetIPAddress | Where-Object { $_.InterfaceAlias -eq 'Ethernet' -and $_.AddressFamily -eq 'IPv4' }).IPAddress
$iisVersion = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\InetStp').MajorVersion
Write-Host "IIS installation completed!"
Write-Host "Server IP Address: $ipAddress"
Write-Host "IIS Version: $iisVersion"
