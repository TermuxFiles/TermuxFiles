#!/bin/bash

# Proot-Distro Installation Script
bc() { echo -e "\e[01;96m$1\e[0m"; }

# Function to clear the screen and display the header
show_header() {
    clear
    echo "=================================================="
    bc "     	  Proot-Distro Installation Script"
    echo "=================================================="
}

# Function to set echo color outputs
yellow() { echo -e "\e[01;93m$1\e[0m"; }
green() { echo -e "\e[01;92m$1\e[0m"; }
red() { echo -e "\e[01;91m$1\e[0m"; }
cyan() { echo -e "\e[01;36m$1\e[0m"; }

# Clear screen and display header
show_header

# Update and Upgrade Packages
green "Updating and upgrading packages..."
apt update && apt upgrade -y

# Check if proot and proot-distro are installed
if dpkg -l | grep -q proot && dpkg -l | grep -q proot-distro; then
    green "Proot and proot-distro are already installed."
    sleep 2
else
    green "Installing proot and proot-distro..."
    sleep 2
    apt install proot proot-distro -y
fi

# Function to display options
show_options() {
    yellow "Select an option:"
    green "1) Install Debian"
    green "2) Install ArchLinux"
}

# Start the loop for user input
while true; do
    show_header
    show_options
    read -p "$(yellow 'Enter your choice [1-2]: ')" choice

    case $choice in
        1)
            # Install and log in to Debian
            cyan "Installing Debian..."
            proot-distro install debian
            cyan "Logging into Debian..."
            proot-distro login debian
            break
            ;;
        2)
            # Install and log in to ArchLinux
            cyan "Installing ArchLinux..."
            proot-distro install archlinux
            cyan "Logging into ArchLinux..."
            proot-distro login archlinux
            break
            ;;
        *)
            red "Invalid Choice. Please enter a valid option (1 or 2)."
            sleep 2  # Pause for 2 seconds before re-prompting
            ;;
    esac
done
