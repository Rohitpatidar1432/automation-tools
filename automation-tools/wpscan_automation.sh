#!/bin/bash

# Ask user for wpscan binary location
read -p "Enter the path to the wpscan binary (e.g., /usr/share/bin/wpscan): " wpscan_path

# Check if wpscan binary exists
if [ -f "$wpscan_path" ]; then
    echo "wpscan binary found at $wpscan_path"
else
    echo "Error: wpscan binary not found at $wpscan_path. Please provide the correct path and run the script again."
    exit 1
fi

# Ask user for the URL of the WordPress site
read -p "Enter the URL of the WordPress site to scan (e.g., https://www.example.com): " wordpress_url

# Run normal wpscan
echo "Running normal wpscan..."
"$wpscan_path" --url "$wordpress_url"

# Run aggressive enumeration
echo "Running aggressive enumeration..."
"$wpscan_path" --url "$wordpress_url" --enumerate uap,ap,at,dbe

# Continue user enumeration
echo "Continuing user enumeration..."
"$wpscan_path" --url "$wordpress_url" --enumerate u

# Check for valid users
echo "Checking for valid users..."
valid_users=$("$wpscan_path" --url "$wordpress_url" --enumerate u | grep '[+]' | awk '{print $2}')

if [ -n "$valid_users" ]; then
    echo "Valid users found: $valid_users"
    
    # Ask user for password brute force
    read -p "Would you like to perform password brute force? (y/n): " brute_force_choice
    
    if [ "$brute_force_choice" == "y" ]; then
        read -p "Enter path to password wordlist: " wordlist_path
        echo "Performing password brute force..."
        "$wpscan_path" --url "$wordpress_url" --passwords "$wordlist_path" --usernames $valid_users
    else
        echo "Scan completed."
    fi
else
    echo "No valid users found. Scan completed."
fi

