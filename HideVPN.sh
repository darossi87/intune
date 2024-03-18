#!/bin/bash

# File name
file_name="VPNDisable_ServiceProfile.xml"

# Content of the file
xml_content='<?xml version="1.0" encoding="utf-8"?>
<!--
    Cisco AnyConnect VPN Profile -

    This profile is a sample intended to allow for the disabling of VPN service
    for those installations that do not require VPN support.
-->
<AnyConnectProfile xmlns="http://schemas.xmlsoap.org/encoding/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://schemas.xmlsoap.org/encoding/ AnyConnectProfile.xsd">
  <ClientInitialization>
    <ServiceDisable>true</ServiceDisable>
  </ClientInitialization>
</AnyConnectProfile>'

# Destination directory
destination_dir="/opt/cisco/secureclient/vpn/profile/"

# Ensure destination directory exists
mkdir -p "$destination_dir"

# Write content to the file
echo "$xml_content" > "$destination_dir$file_name"

# Check if file creation was successful
if [ $? -eq 0 ]; then
    echo "File \"$file_name\" created successfully in \"$destination_dir\"."
else
    echo "Error creating \"$file_name\" in \"$destination_dir\"."
fi
