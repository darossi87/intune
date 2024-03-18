Using Intune to install of Cisco Secure Client with Umbrella for MacOS
How to make a customized install of Cisco Secure Client with Cisco Umbrella for MacOS

Firstly, as we utilize Cisco Umbrella, accessing the download client is only feasible through the Cisco Umbrella admin panel. The crucial element to obtain is the Headend Package. Without it, extracting the individual package files necessary for creating a customized installer with specific applications becomes impossible.



Prepping MacOS via intune for Cisco Secure Client
Using the mobileconfig file I have attach to this project allow you set almost all the system varabiles need in intune to get this done. At time of writing this can change over time. 
*please view the link below and make sure it on the latest verison incase cisco changes something in this config* it listed as "Sample MDM Configuration Profile for Cisco Secure Client System and Kernel Extension Approval"
https://www.cisco.com/c/en/us/td/docs/security/vpn_client/anyconnect/Cisco-Secure-Client-5/admin/guide/b-cisco-secure-client-admin-guide-5-1/macos11-on-ac.html

How to set the CiscoSecureClient.mobileconfig in intune
browse to Devices --> macOS --> Configuration profiles --> Create --> New Policy --> Profile type: Templates --> Custom --> Create

Next Name the Policy I suggest "MacOS Cisco Secure Connect Mobileconfig" Then hit Next

On the Configration Setting Page Name your Custom Policy "Custom configuration profile name" Then "Choose Device Channel" for your Deployment Channel.

Then Select the folder icon and import the CiscoSecureClient.mobileconfig and hit next, then choose your devices you want to push the config to and hit next.
