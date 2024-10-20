# Function to print colorful text
function Write-Color {
    param (
        [string]$Text,
        [string]$Color = "White"
    )
    $Host.UI.RawUI.ForegroundColor = $Color
    Write-Host $Text
    $Host.UI.RawUI.ForegroundColor = "White"
}

# ASCII Dragon
function Show-Dragon {
    Write-Host "         __====-_  _-====__ "
    Write-Host "      _--^^^#####//      \\#####^^^--_ "
    Write-Host "   _-^##########// (    ) \\##########^-_ "
    Write-Host "  -############//  |\^^/|  \\############- "
    Write-Host " -#############((   \\//   ))#############- "
    Write-Host " -###############\\    ^^    //###############- "
    Write-Host "  -#################\\____//#################- "
    Write-Host "   -###################\\  //###################- "
    Write-Host "    -###################\\/###################- "
    Write-Host "     -###################\\###################- "
    Write-Host "       -#################\\#################- "
    Write-Host "          -###############\\###############- "
    Write-Host "            -###############\\#############- "
    Write-Host "                -###############- "
}

# Show the dragon
Show-Dragon

# Install OpenSSH Server
Write-Color "Installing OpenSSH Server..." "Yellow"
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# Start and configure OpenSSH
Write-Color "Starting and enabling OpenSSH service..." "Green"
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'

# Open firewall for SSH
Write-Color "Configuring firewall to allow SSH..." "Cyan"
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22

# Set root (admin) password
Write-Color "Setting password for Administrator (replace with your own)..." "Magenta"
$password = ConvertTo-SecureString "kali" -AsPlainText -Force
$user = [ADSI]"WinNT://./Administrator, user"
$user.SetPassword($password)

# Check SSH status
$sshStatus = Get-Service sshd | Select-Object -ExpandProperty Status
if ($sshStatus -eq "Running") {
    Write-Color "SSH service is running!" "Green"
} else {
    Write-Color "SSH service is not running!" "Red"
}

# Show IP address
$ipAddress = (Get-NetIPAddress | Where-Object { $_.AddressFamily -eq 'IPv4' -and $_.InterfaceAlias -ne 'Loopback Pseudo-Interface 1' }).IPAddress
Write-Color "Your IP address is: $ipAddress" "Blue"

# Show SSH connection command
Write-Color "Use the following command to connect via SSH:" "Yellow"
Write-Color "ssh Administrator@$ipAddress" "White"
