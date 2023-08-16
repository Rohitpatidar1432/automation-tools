#!/bin/bash

# Update the system
echo "Updating the system..."
apt-get update -y

# Install desired packages
echo "Installing vim..."
apt-get install vim -y

echo "Installing virtualbox..."
apt-get install virtualbox -y

echo "Installing sublime-text..."
apt-get install sublime-text -y

echo "Installing gobuster..."
apt-get install gobuster -y

echo "Installing wfuzz..."
apt-get install wfuzz -y

echo "Installing apt-transport-https..."
apt-get install apt-transport-https -y

echo "Installing google-chrome-stable..."
apt-get install google-chrome-stable -y

echo "Installing openvpn..."
apt-get install openvpn -y

echo "Installing Remmina and plugins..."
apt-get install remmina remmina-plugin-rdp remmina-plugin-secret -y

echo "Installing nvidia-cuda-toolkit..."
apt-get install nvidia-cuda-toolkit -y

echo "All installations completed!"

# Update and upgrade the system
echo "Updating the system once again..."
apt-get update -y
echo "Performing full system upgrade..."
apt-get upgrade -y
echo "Performing distribution upgrade..."
apt-get dist-upgrade -y

# Ask user if they want to restart
read -p "Would you like to restart the system? (y/n): " restart_choice
if [ "$restart_choice" == "y" ]; then
    echo "Restarting the system..."
    reboot
else
    echo "Installation and updates completed."
fi

