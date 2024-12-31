# Using Intune to install of Cisco Secure Client with Umbrella for MacOS

THIS IS A **UNOFFICAL** GUIDE USE AT YOUR OWN RISK

As of the current date, March 18, 2024, there isn't a method available to display a PKG installer within the company portal. The only option is to configure PKG installers to require installation, which effectively mandates the installation of the application without offering it for user selection in the company portal.

Building a customized installation of Cisco Secure Client with Cisco Umbrella for macOS involves several steps. Here's a breakdown of the process:

Firstly, as we utilize Cisco Umbrella, accessing the download client is only feasible through the Cisco Umbrella admin panel. The crucial element to obtain is the Headend Deployment Package. Without it, extracting the individual package files necessary for creating a customized installer with specific applications becomes impossible.

![image](https://github.com/darossi87/intune/assets/45303117/9f8464a4-f2e6-493a-b660-a68879a28833)

The Headinstaller will download file named: cisco-secure-client-macos-5.1.2.42-webdeploy-k9.pkg

If you've obtained a predeploy file, it won't function as expected. From my observations, only the webdeploy file (also known as Headend Deployment) is capable of being extracted in this manner.

Also, remember to retrieve your Orginfo.json file if using Cisco Umbrella during this process. This is will be REQUIRED for OrgfileMove.sh script that move your Orginfo.json file

![image](https://github.com/darossi87/intune/assets/45303117/37a2a85a-4100-41c2-9f60-799386013ca5)


After downloading it, I utilized 7zip to extract the installer.

![image](https://github.com/darossi87/intune/assets/45303117/cc4f74a0-3710-49c4-ae3c-7ff3adeeb233)

You should see something like this
cisco-secure-client-macos-5.1.2.42-webdeploy-k9\binaries

Now you we will see each DMG of each app

![image](https://github.com/darossi87/intune/assets/45303117/c72ab80c-c19c-4549-b1fd-449d154e2b35)

Now do the same steps on the DMG for each package you need.

![image](https://github.com/darossi87/intune/assets/45303117/d54256be-74e9-4ca6-a7c8-6867bc1ab5b0)

![image](https://github.com/darossi87/intune/assets/45303117/1b597379-abd1-49e6-8881-dcdaa87f5b48)


To set up Umbrella, it's essential to install the Core VPN, even if your primary focus is on using Umbrella alone. This is because the Umbrella client relies on the Core VPN. Additionally, I suggest installing Dart from Cisco in case you require assistance.

After installation, you'll have the PKG file for Intune installation. However, it's crucial to prepare the operating system to prevent prompting the user for admin login to grant permissions for the app.

# Prepping MacOS via intune for Cisco Secure Client

The mobileconfig file provided with this project enables you to configure nearly all the necessary system variables required in Intune for this setup. Please ensure that you're using the latest version of the file from the link provided, as Cisco might update the configuration. It's labeled as "Sample MDM Configuration Profile for Cisco Secure Client System and Kernel Extension Approval."
<br>
<br>
https://www.cisco.com/c/en/us/td/docs/security/vpn_client/anyconnect/Cisco-Secure-Client-5/admin/guide/b-cisco-secure-client-admin-guide-5-1/macos11-on-ac.html

How to set the CiscoSecureClient.mobileconfig in intune
browse to Devices --> macOS --> Configuration profiles --> Create --> New Policy --> Profile type: Templates --> Custom --> Create

Next, Name the Policy I suggest "MacOS Cisco Secure Connect Mobileconfig" Then hit Next

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

# Deploying the Cisco Umbrella Root Certificate:
This step only applies to new deployments of Cisco Secure Client or devices that does not have the Cisco Umbrella Root Certificate deployed previously. If you're migrating over from the Umbrella Roaming Client or Cisco AnyConnect 4.10 client, and/or have deployed the Cisco Umbrella Root Certificate already in the past, you may skip this step. 
 
1.	In your Umbrella dashboard, under Deployments --> Configuration --> Root
Certificate, download the Cisco Umbrella Root Certificate. 
2.	In Intune, on the far left menu, navigate to Devices --> macOS --> Configuration profiles --> Create --> New Policy --> Profile type: Templates --> Trusted certificate --> Create. 
3.	Give it a unique name like "Cisco Umbrella Root Certificate". In Configuration settings, upload the root certificate downloaded from the previous step. 
4.	In Assignments, select your desired user/device assignment and click Create.
5.	Navigate back to the overview of your macOS devices and click Sync. Just like previously in Step 18, this allows the desired macOS device(s) to pick up the changes during the device's next check-in with Intune. 
 
Verify:
You may verify Cisco Secure Client with Umbrella module is working by either browsing to https://policy-debug.checkumbrella.com or by running the following command:

dig txt debug.opendns.com

Either output should contain unique and relevant information to your Umbrella organization such as your OrgID. 

# DEPLOYING THE APP

Now add the Cisco Secure Client Core VPN to the Intune via PKG

![image](https://github.com/darossi87/intune/assets/45303117/016a52bf-a3ab-451c-8e72-95bb81ba6383)
![image](https://github.com/darossi87/intune/assets/45303117/e4d3fd5e-7e48-42e7-b955-9628afec36b1)

**THIS STEP IS ONLY NEEDED IF YOU WANT TO HIDE THE VPN CLIENT**

Copy OrgfileMove.sh into Pre-Install Script required for Umbrella. Script is link below.  If you're not using Umbrella you can Skipt this step.
*This moves your license file to the licese file location also you must edit the script for it work. 

https://github.com/darossi87/intune/blob/Cisco-Secure-Client-With-Umbrella-MacOS/OrgfileMove.sh


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

