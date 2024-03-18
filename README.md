# Using Intune to install of Cisco Secure Client with Umbrella for MacOS
How to make a customized install of Cisco Secure Client with Cisco Umbrella for MacOS


THIS IS A UNOFFICAL GUIDE USE AT YOUR OWN RISK.

AS OF WRITITING  3/18/24
THERE IS NO WAY TO MAKE PKG INSTALLER SHOW UP IN THE COMPANY PORTAL YOU CAN ONLY SET THEM TO REQUIRE INSTALL WHICH WILL FORCE INSTALL THE APP


Firstly, as we utilize Cisco Umbrella, accessing the download client is only feasible through the Cisco Umbrella admin panel. The crucial element to obtain is the Headend Deployment Package. Without it, extracting the individual package files necessary for creating a customized installer with specific applications becomes impossible.

![image](https://github.com/darossi87/intune/assets/45303117/9f8464a4-f2e6-493a-b660-a68879a28833)

The Headinstaller will download file named: cisco-secure-client-macos-5.1.2.42-webdeploy-k9.pkg

If you grabbed a predeploy file it will not work I noticed only the webdeploy(aka Headend Deployment) file is the only one that can be extracted like this

While there also grab your Orginfo.json file while there

![image](https://github.com/darossi87/intune/assets/45303117/37a2a85a-4100-41c2-9f60-799386013ca5)


Once you download it I used 7zip to extract the installer

![image](https://github.com/darossi87/intune/assets/45303117/cc4f74a0-3710-49c4-ae3c-7ff3adeeb233)

You should see something like this
cisco-secure-client-macos-5.1.2.42-webdeploy-k9\binaries

Now you we will see each DMG of each app

![image](https://github.com/darossi87/intune/assets/45303117/c72ab80c-c19c-4549-b1fd-449d154e2b35)

Now do the same steps on the DMG for each package you need.

![image](https://github.com/darossi87/intune/assets/45303117/d54256be-74e9-4ca6-a7c8-6867bc1ab5b0)

![image](https://github.com/darossi87/intune/assets/45303117/1b597379-abd1-49e6-8881-dcdaa87f5b48)

For Umbrella you will need the Core VPN even though you might just want umbrella. You still need to install the Core VPN because Umbrella client is dependant on it. I recommend Dart as well incase you need assistant from Cisco.

Once done you will have the PKG for the Intune Install but you need to prep the OS for the app so it not prompting the user for admin login for Permission for the app.

# Prepping MacOS via intune for Cisco Secure Client

Using the mobileconfig file I have attach to this project allow you set almost all the system varabiles need in intune to get this done. At time of writing this can change over time. 
please view the link below and make sure it on the latest verison incase cisco changes something in this config it listed as "Sample MDM Configuration Profile for Cisco Secure Client System and Kernel Extension Approval"
<br>
<br>
https://www.cisco.com/c/en/us/td/docs/security/vpn_client/anyconnect/Cisco-Secure-Client-5/admin/guide/b-cisco-secure-client-admin-guide-5-1/macos11-on-ac.html

How to set the CiscoSecureClient.mobileconfig in intune
browse to Devices --> macOS --> Configuration profiles --> Create --> New Policy --> Profile type: Templates --> Custom --> Create

Next Name the Policy I suggest "MacOS Cisco Secure Connect Mobileconfig" Then hit Next

On the Configration Setting Page Name your Custom Policy "Custom configuration profile name" Then choose "Device Channel" for your Deployment Channel.

Then Select the folder icon and import the CiscoSecureClient.mobileconfig and hit next, 
![Intune Mobileconfig settings](https://github.com/darossi87/intune/assets/45303117/26148586-aed9-4a39-ba3f-f3385e41c48a)



Cisco Secure Client Changes Related to macOS 11 (And Later)

Create --> New Policy --> Profile type: Settings catalog -->
Name: ManagedLoginItems --> Add Settings --> search for Managed Login Items -> select Login > Service Management - Managed Login Items --> expand the rules at the bottom and select Comment, Rule Type, and Rule Value. 

![image](https://github.com/darossi87/intune/assets/45303117/6c0c9d03-e108-4451-bbc9-f58307eab2c9)

Close the right side panel and click + Edit Instance and enter the following values, removing the last row for "Team Identifiers":
Comment: Cisco Secure Client
Rule Type: Team Identifier
Rule Value: DE8Y96K9QP

![image](https://github.com/darossi87/intune/assets/45303117/5f45b827-9240-47f1-ae87-67be7b2d78c6)


In Scopes and Assignments, select your desired user/device assignment and click Create. 


# DEPLOYING THE APP

Now add the Cisco Secure Client Core VPN to the Intune via PKG

![image](https://github.com/darossi87/intune/assets/45303117/016a52bf-a3ab-451c-8e72-95bb81ba6383)
![image](https://github.com/darossi87/intune/assets/45303117/e4d3fd5e-7e48-42e7-b955-9628afec36b1)

**THIS STEP IS ONLY NEEDED IF YOU WANT TO HIDE THE VPN CLIENT**

copy OrgfileMove.sh into Pre-Install Script. If not needed hit Next to skip

![image](https://github.com/darossi87/intune/assets/45303117/37165e59-4157-4908-aec0-fe184e756fbb)


Leave these settings below alone do not touch them

![image](https://github.com/darossi87/intune/assets/45303117/8b53b2a2-481e-4b4b-81ef-cf8b50d3c7fb)
![image](https://github.com/darossi87/intune/assets/45303117/4703c1b3-1d18-4f1c-8421-4533d9591976)

In Scopes and Assignments, select your desired user/device assignment and click Create. 

Finaly we do Umbrella

![image](https://github.com/darossi87/intune/assets/45303117/016a52bf-a3ab-451c-8e72-95bb81ba6383)
![image](https://github.com/darossi87/intune/assets/45303117/42404266-23a3-41fa-8bb7-fbe2d568f6f9)

Now copy OrgfileMove.sh editing the URL of were your Orginfo.json is located and copy it into the Pre-Intall Script Area

![image](https://github.com/darossi87/intune/assets/45303117/b54474ff-ed55-4f48-948b-192cabcfd7ec)
![image](https://github.com/darossi87/intune/assets/45303117/8b53b2a2-481e-4b4b-81ef-cf8b50d3c7fb)

Leave these settings below alone do not touch them

![image](https://github.com/darossi87/intune/assets/45303117/78439863-4dc1-4d6c-b446-e1510066bf0f)

In Scopes and Assignments, select your desired user/device assignment and click Create. 

Once it all push to the Mac it will need a restart for Umbrella to fully work it might show umbrella working but it will not filter till restart.

![image](https://github.com/darossi87/intune/assets/45303117/f8feb199-8a2a-4426-8026-f68df16cc958)
