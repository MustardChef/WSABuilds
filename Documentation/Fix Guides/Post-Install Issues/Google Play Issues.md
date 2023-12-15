# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 
<br/>


## Issue: After signing in to your Google Account from the Play Store App, Play Store keeps crashing

### Preface: 
##### This issue will prevent you from opening Play Store and effectively prevent the function of MindTheGapps/OpenGapps. This issue may usually occur after signing in. Known cases indicate that this issue is pretty common on newer hardware (12th or 13th Gen Intel Processors, for example)

---

## Solution:

######  Step 1. 

Open Android Settings by pressing the Windows Key and "R" key, Open Run****

######  Step 2. 

****Type wsa://com.android.settings, and then select OK.****

######  Step 3. 

****Wait for Android Settings to load and open.****

######  Step 4. 

****In Android Settings, click on the "Apps" Section and then click on "All Apps".****

######  Step 5. 

****In the "All Apps" Section, find the "Google Play Services" app .****

######  Step 6. 

****Click on the "Google Play Services" app, which should open a page with various different options for the app ("Permissions", "Notification", "Storage and Cache" etc.)****

######  Step 7. 

****Click on "Storage and Cache"****

######  Step 8. 

****Find the "Manage Space" button and click on it, which should popup a window reading "Google Play services storage"****

######  Step 9. 

****Click on "Clear All Data"****

</br>

The issue should now be fixed


</br>
</br>
</br>
</br>



## Issue: Could not sign-in. There was a problem connecting to play.google.com

### Preface: 
##### This issue will prevent you from signing into Play Store and effectively prevent the function of MindTheGapps/OpenGapps. This issue may usually occur after updating. Known cases have occured after updating from a non Google Apps WSA build to a Google Apps build 

![image](https://github.com/MustardChef/WSABuilds/assets/68516357/6491854b-9ad2-4e64-94ea-45e7b444cafe)

---

## Solution:

### Internet is working on other app in WSA?

<br/>

######  Step 1: 
Turn WSA off through the Windows Subsystem For Android Settings app

###### Step 2:
Open up your favourite VPN and connect to a server. You can use any VPN for this. VPNs recommended: ProtonVPN, AtlasVPN

###### Step 3:
Turn on WSA and open Play Store.

###### Step 4:
You should now be able to log in to Google Play and hopefully download apps!

<br/>

### Internet is not working on other app in WSA?

##### Take a look at the [Internet Fixes Guide](https://github.com/MustardChef/WSABuilds/blob/master/Documentation/Fix%20Guides/Post-Install%20Issues/FixInternet.md)



<br />

---

## Have futher question or need help?

#### Join the Discord if you have any other questions or need help!

[<img src="https://invidget.switchblade.xyz/2thee7zzHZ" style="width: 400px;"/>](https://discord.gg/2thee7zzHZ)
