#!/bin/bash

# URL of the file to download
file_url="URL_HERE"

# Destination directory
destination_dir="/opt/cisco/secureclient/umbrella/"

# Ensure destination directory exists
sudo mkdir -p "$destination_dir"

# Download the file
echo "Downloading file..."
sudo curl -L -o "$destination_dir/Orginfo.json" "$file_url"

# Check if download was successful
if [ $? -eq 0 ]; then
    echo "File downloaded successfully."

    # Move the downloaded file to the destination directory
    sudo mv "$destination_dir/Orginfo.json" "$destination_dir"

    # Check if move was successful
    if [ $? -eq 0 ]; then
        echo "File moved to $destination_dir"
    else
        echo "Error moving file to $destination_dir"
    fi
else
    echo "Error downloading file from $file_url"
fi
