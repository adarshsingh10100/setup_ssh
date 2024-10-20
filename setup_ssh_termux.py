#!/data/data/com.termux/files/usr/bin/bash

# Function to print colorful text
print_color() {
    local color=$1
    shift
    echo -e "\e[${color}m$*\e[0m"
}

# ASCII Dragon
dragon() {
    echo "         __====-_  _-====__ "
    echo "      _--^^^#####//      \\#####^^^--_ "
    echo "   _-^##########// (    ) \\##########^-_ "
    echo "  -############//  |\^^/|  \\############- "
    echo " -#############((   \\//   ))#############- "
    echo " -###############\\    ^^    //###############- "
    echo "  -#################\\____//#################- "
    echo "   -###################\\  //###################- "
    echo "    -###################\\/###################- "
    echo "     -###################\\###################- "
    echo "       -#################\\#################- "
    echo "          -###############\\###############- "
    echo "            -###############\\#############- "
    echo "                -###############- "
}

# Print the dragon
dragon

# Update package lists
print_color "1;34" "Updating package lists..."
pkg update -y

# Install OpenSSH server
print_color "1;32" "Installing OpenSSH server..."
pkg install -y openssh

# Set password for SSH (change 'kali' to your desired password)
print_color "1;33" "Setting password for user 'root'..."
passwd

# Enable and start SSH service
print_color "1;32" "Starting SSH service..."
sshd

# Check if SSH service is active
if pgrep -x "sshd" > /dev/null; then
    print_color "1;32" "SSH service is enabled and running!"
else
    print_color "1;31" "SSH service is not running!"
fi

# Show the IP address
IP_ADDRESS=$(hostname -I | awk '{print $1}')
print_color "1;36" "Your IP address is: $IP_ADDRESS"

# Show command to connect via SSH
print_color "1;35" "Use the following command to connect via SSH:"
print_color "1;37" "ssh root@$IP_ADDRESS"
