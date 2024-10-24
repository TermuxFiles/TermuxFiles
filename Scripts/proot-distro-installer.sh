#!/bin/bash

# Define color functions
function green() { echo -e "\e[01;32m$1\e[0m"; }
function yellow() { echo -e "\e[01;33m$1\e[0m"; }
function red() { echo -e "\e[01;31m$1\e[0m"; }
function cyan() { echo -e "\e[01;36m$1\e[0m"; }
function purple() { echo -e "\e[01;35m$1\e[0m"; }
function white() { echo -e "\e[01;37m$1\e[0m"; }

# Function to display a timestamped message with a specific color
function display_message() {
    cyan "[$(date +"%T")] $1"
}

# Function to Show Header
show_header() {
    clear
    white "==================================================\n"
    purple "   Welcome to the proot-distro Installation Tool\n"
    white "==================================================\n"
}

# Function to check if a package is installed
function check_installed() {
    dpkg -s "$1" &> /dev/null
    if [ $? -ne 0 ]; then
        return 1
    else
        return 0
    fi
}

# Function to check if a distribution is already installed by looking at the rootfs directory
function check_distro_installed() {
    if [ -d "$PREFIX/var/lib/proot-distro/installed-rootfs/$1" ]; then
        return 0  # Distro is installed
    else
        return 1  # Distro is not installed
    fi
}

# Function to update and upgrade the package list
function update_system() {
    display_message "Updating and upgrading system packages..."
    apt update && apt upgrade -y
}

# Function to install necessary packages
function install_required_packages() {
    for package in proot proot-distro; do
        if ! check_installed "$package"; then
            display_message "$(yellow "${package} is not installed. Installing...")"
	    sleep 2
            apt install "$package" -y
        else
            display_message "$(green "${package} is already installed.")"
	    sleep 2
        fi
    done
}

# Start Script Execution
show_header

# Step 1: Update and Upgrade System
update_system

# Step 2: Install required packages (proot and proot-distro)
install_required_packages

red "\n**************************************************\n"

# Next Part : Installing Actual Distro 
show_header

# Step 3: Optionally list available distributions
read -p "$(yellow "Do you want to list available distributions? (y/n): ")" list_choice
if [ "$list_choice" = "y" ]; then
    display_message "Listing available distributions..."
    proot-distro list
    echo ""
else {
	echo ""
}
fi

# Step 4: Get user input for the distribution alias
read -p "$(green "Enter the alias of the distribution you want to install (e.g., 'debian', 'ubuntu'): ")" distro_alias

red "\n**************************************************\n"

# Step 5: Check if the distribution is already installed by checking the filesystem
display_message "Checking if $distro_alias is already installed...\n"
check_distro_installed "$distro_alias"
distro_status=$?

if [ $distro_status -eq 0 ]; then
    green "$distro_alias is already installed.\n"
else
    # Step 6: Install the selected distribution if not already installed
    display_message "$(yellow "Installing $distro_alias...")"
    proot-distro install "$distro_alias"
    if [ $? -eq 0 ]; then
        display_message "$(green "Installation of $distro_alias completed successfully.")"
    else
        red "Installation of $distro_alias failed."
        exit 1
    fi
fi

# Final step: Notify the user
white "\n##################################################\n"
purple "      Proot-Distro Installation Complete!         \n"
white "##################################################\n"
