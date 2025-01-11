## Updated on 11/01/2025

## Legend

This page currently uses Unicode characters from [Unicode Emoji (1.0)](https://unicode.org/Public/emoji/1.0/emoji-data.txt). If you are unable to see these characters, please open an issue.

- ✅ Works
- 🆖 Works, but needs Google Mobile Services
- ⚠️ Works, but with some notable problems
- ❌ Broken

## Support table (OS features)

| Feature | Support level | Notes |
|---------|---------------|-------|
| Multi-touch | ✅ | Demo: [Arcaea](https://www.bilibili.com/video/BV1Ph411n7M5)
| Virtual Wifi (VirtWifi) | ✅
| Bluetooth | ❌ ([GitHub issue](https://github.com/microsoft/WSA/issues/103))
| IPv6 | ✅ | Loading `ipv6.google.com` in Fennec F-Droid on a PC with IPv6 access, works well
| Fingerprint Reader | ❌ | Test failed on ROG Flow X13, with SATRIA app
| VPN | ❌ | VPN Connection request dialog does not appear
| OpenGL ES 3.1 | ❌
| Vulkan | ✅ | Added as experimental feature in [2307.40000.2.0](https://github.com/microsoft/WSA/discussions/374)

### Workarounds

#### VPN

There is no `com.android.vpndialogs` in official builds of WSA. However, it's possible to manually grant the VPN activation permission with AppOps via `adb shell` on these builds. WSABuilds build i.e builds from this repo will contain the `com.android.vpndialogs` and hence will not need the workaround above:

```shell
appops set [package name] ACTIVATE_VPN allow
```

#### Launching Android Apps with URI scheme

Microsoft provides a custom URI scheme for WSA, making it easier to launch apps:

```shell
wsa://[App Package Name]
```

For example, to launch Apple Music in WSA, use:

```shell
wsa://com.apple.android.music
```

## Support tables

* [Apps](#apps)
* [Games](#games)

### Apps
| Application | Latest tested version | Android versions | Support level | Known Issues | Notes |
|-------------|-----------------------|------------------|---------------|--------------|-------|
| 23andMe | 5.114.0 | 11 | ✅ |
| 4PDA | 1.9.35 | 11 | ✅ |
| A+ Gallery | 2.2.55.4 | 11 | ✅ | You might face graphical glitches when using dark theme, hence it's recommended to use light theme instead.
| Activity Launcher | 1.14.6 | 13, 12 | ⚠️ | As of WSA version 2209.40000.28.0, you can't pin shortcuts to a home area of a launcher (like Lawnchair or Rootless Pixel Launcher) with the error `Current launcher does not support PinShortcut. Unable to create shortcut.` | You can still launch specific activities on any app 
| AdGuard | 3.6.10 | 12 | ⚠️ | "Local VPN" doesn't work even with the above workaround. "HTTPS Filtering" doesn't work due to problems with recognition of manually installed certificates. | Not to be confused with "AdGuard Content Blocker"
| ADM | 12.5.4 | 11 | ✅ |
| ADM Pro | 6.4.0 | 11 | ✅ |
| Aegis | 2.0.2 | 11 | ✅ |
| AIDE | 3.2.210316 | 11 | ✅ || Might optionally require GMS
| AIMP | 3.10.1052 | 11 | ✅
| AliExpress | 8.101.15 | 13 | ⚠️ | Sometimes the app crashes after `Sorry, we have detected unusual traffic from your network`, has significant scaling issues that can be mitigated by maximizing the window
| Amaze File Manager | 3.5.3 | 11 | ✅ || Avoid updating the app
| Amazon Alexa | 2.2.466191.0 | 12 | ✅ |
| Android System Info | 1.4.2 | 11 | ✅ ||
| Android System Webview | 118.0.5993.111 | 13, 12 | ✅ ||
| Android System Webview Dev | 103.0.5060.22 | 11 | ✅ || App installs correctly 
| AniLabX | 3.8.12 (Iridium) - Beta | 11 | ✅
| Animiru | 0.16.0.0 | 13 | ✅ | 
| Aniyomi | 0.15.2.1 | 13, 12 | ✅ |
| AntennaPod | 2.5.0 | 11 | ✅
| APKMirror Installer (Beta) | 1.3.2 | 11 | ⚠️ | Cannot remove ads without a subscription which requires Location to be turned on. Apart from this, there are random crashes
| APKPure | 3.17.26 | 11 | ✅ | Sometimes, it might require multiple attempts to install an app
| Apple Music | 3.7.1 | 11 | ✅ | To achieve Hi-Res Lossless, turn off WSA, open settings>sound>more sound settings>pick your device>properties>advanced and set format as 24-bit 192000 Hz (Studio Quality), then start WSA
| App分享 (AppShare) | 2.1.1 (164) | 11 | ❌ | Can't login
| Aptoide App Store | 9.20.2.1 | 11 | ✅ | Sometimes, downloads might get stuck
| AquaMail (Pro) | 1.34.0-118 | 11 | ✅
| ASUS Router | 1.0.0.7.35 | 12 | ✅ | The text on the bottom bar is more narrow than it should be, resulting in cutting off the last letters or taking up two lines. | 
| AtB | 1.23 | 12 | ❌ | Crashes during loading, as it relies on Google Services Framework and on having the latter be given `read_device_config` permissions, which doesn't seem to be possible to give.
| Audible | 3.15.0 | 11 | ✅
| Aurora Store | 4.1.1 | 12, 11 | ✅
| Authy | 26.1.0 | 11 | ❌ | This device does not meet the minimum integrity requirements. |
| BandLab | 10.45.0 | 13, 12 | 🆖 | Slight audio lag with Android 12, it was fixed in Microsoft's 2303.40000.3.0 update | Only tested from installing from Google Play Store with Google services, otherwise app has no issues whatsoever. It's responsive, and in Android 13 there's no audio lag. |
| BankID (Norway) | 2.1 | 12 | ❌ | Spams the desktop browser with new tabs about how the app thinks the phone is rooted. 
| BBC iPlayer | 4.137.0.25403 | 11 | ✅ | Sideloaded
| BBC Sounds | 2.13.0.19989 | 13 | ✅
| Berry Browser | 3.57.8 | 12, 11 | ✅
| Binance | 2.36.5 | 11 | ✅
| Bloons TD 6 - NETFLIX | 43.3 | 13 | ✅ | Scaling can be a problems unless F11 and re-scaling is enabled |
| Boost for Reddit | 1.12.5 | 12 | ✅ 
| Bouncer | 1.26.3 | 11 | ⚠️
| Brave Browser | 1.30.87 | 11 | ✅
| BritBox by BBC & ITV | 2.1.2 (20043) | 11 | ❌ | App crashes on start
| Bromite | 94.0.4606.94 | 11 | ✅ || Use x64 build
| Camera | 2.0.002 | 13 | ⚠️ | While taking pictures or video works fine but changing the camera (to an inactive virtual camera) freezes the app. | Included in the subsystem
| CamScanner | 6.3.0.2110240000 | 11 | ❌ | WSA freezes after taking a snap
| Canvas Student | 6.14.1 | 11 | ✅
| Character.AI | 1.7.5 | 13 | ✅ | Sometimes, the text box for the prompt is broken when you resize the window. Restarting the app will restore the textbox.
| ChMate | 0.8.10.153 | 11 | ✅
| Clubhouse | 1.0.11 | 11 | ⚠️ | Unable to login via phone number, it throws an error after entering the OTP
| Comixology | 3.10.18.310421 | 11 | ✅
| Cignal Play | 2.2-play | 13 | ⚠️ | Stuck on loading animation when viewing live tv
| Coop Medlem | 3.4.30 | 12 | ⚠️ | Coopay activation fails because the app looks for whether a lock screen is enabled or not | Core functionality works, although a bit slowly. 
| CPU-Z | 1.41 | 11 | ✅
| Cronometer | 3.13.1 | 11 | ✅
| Cryptography | 1.24.0 | 12 | ✅
| CX File Explorer | 2.2.0 | 13, 12 | ✅
| Dantotsu | 3.0.0 | 13 | ✅ | To sign-in to the anilist integration, set the default browser to use a browser app in WSA (e.g. Firefox) since it opens the default brower on Windows. This also happens with links as well. | Hovering the mouse pointer, highlights the input element. Keyboard usage is supported on the Manga reader and Media Player.
| Dcoder | 4.0.76 | 11 | ✅
| Decibel X | 6.4.2 | 11 | ⚠️ | App crashes
| Decrypto | 1.4.7 | 12 | ✅
| Delivery Club | 4.64.0 | 11 | ❌ | App crashes after selecting a shipping address
| DevCheck | 3.39 | 11 | ❌ | Blank screen on startup
| Device Info HW | 5.4.1 | 11 | ✅
| Deezer | 7.0.14.1 beta | 12 | ✅ | The Deezer Labs crossfade function doesn't seem to work as of September 2022 | Music and menus seem to work pretty well, even with HiFi bitrates.
| Digital Wellness | 1.5.500315346 (471337) | 13 | ✅ | It's not available in the Settings App by default, requires Activity Launcher to launch it. | You can make it show in the launcher if you enable "Show icon on app list".
| DirecTV for Tablet | 5.29.001 | 11 | ⚠️ || Frequent crashing, other functionality proper.
| Discord | 98.6 | 11 | ✅
| DMM Games Store | 2.8.0 | 11 | 🆖 | Requires GMS
| Duolingo | 5.2.35 | 11 | ✅
| DuckDuckGo Privacy Browser+ | 5.142.2 | 12 | ✅
| Easybell | 2.1.30 | 11 | ✅
| EDS Lite | 2.0.0.237 | 12 | ✅ || Tested on an Intel x86-64 CPU (may work on AMD64 or ARM64). Recommended to add the exFAT module if you have a container that uses this filesystem.
| eGovPH | 2.3.5 | 13 | ⚠️ | Tested on 3 WSA builds, stock WSA, with GMS installed and no root/Magisk/KernelSU, and with GMS-Magisk/KernelSU installed ([WSABuilds non-LTS, no Magisk/root installed, 2311.40000.5.0](https://github.com/MustardChef/WSABuilds/releases/tag/Windows_11_2311.40000.5.0)), ([WSABuilds LTS, with GMS, KernelSU/Magisk installed, 2311.40000.5.0](https://github.com/MustardChef/WSABuilds/releases/tag/Windows_11_2311.40000.5.0_LTS_3)). It is also recommended to temporarily disable developer settings before starting the app. With Magisk/root installed, it would alert "This device is jailbroken, you cannot continue". If no GMS services are present, it will tell you "This device is not supported for required Google Play Services".  The app doesn't start properly if you didn't grant the permissions beforehand in Android settings. For eReport, the app can't progress beyond the Current Location permission prompt as clicking the "Enable Location" doesn't do anything (even with the location permission granted for WSA in Windows); the workaround is to access it via the Suggested eGovPH Services part (found on the Home tab), however, it is stuck in report details as it still checks for the location permission. eKYC verification is problematic for laptop users is wonky with eGovPH's image handling, affecting the verification process (this also applies if you're registering an account from the same device for its face verification). Some pages display no content (notably FAQs and application details in some cases) |  Basic features work such as navigating through the app features/pages. The PhilSys Digital ID page works as well and can recognize it in the verification site from another device. Recommended to use an up-to-date version of Android System WebView since the app mostly relies on it.
| Emby | 2.0.48g | 11 | ✅
| ES File Explorer | 4.2.1.8 | 11 | ✅ || Avoid updating the app
| Excel | 16.0.14527.20162 | 11 | ✅
| F-Droid | 1.19.1 | 13, 12, 11 | ✅
| F1 TV | 2.0.5 | 11 | ⚠️ | Terrible app experience including screen flashes and crashes while watching a video
| FaceApp: Face Editor || 11 | ❌
| Facebook | 377.0.0.22.107 | 12 | ✅ | 
| Facebook Lite | 339.0.0.10.100 | 12 | ✅ |
| Facebook Messenger | 330.0.0.12.116 (x86_64) | 11 | ⚠️ | Chat Heads don't work
| Facebook Messenger Lite | 334.0.0.10.101 | 12 | ✅ | 
| FAST Speed Test | 1.0.8 (88) | 11 | ✅
| FDM (Free Download Manager) (Play Store) | 6.18.1.4896 | 13 | ✅ | The app crashed after the splash screen (after granting its needed permissions) on some versions of the subsystem (due to libhoudini). Works fine again as of WSA 2301.40000.7.0 | Tested on an Intel x86_64 CPU
| Fennec F-Droid | 105.1.0 | 12 | ❌ | While the app is correctly installed, it crashes very often, and sites load very, very slowly compared to Firefox Nightly.
| Files by Google | Unknown | 11 | ✅ || Works fine
| Firefox |124.2.0 (2016012559) | 13, 12, 11 | ✅ | On Android 11, it works albeit with broken rendered webpages. On Android 12, works (without white box after updating WSA to 2205.40000.21.0) | Tested on Intel HD integrated graphics.
| Firefox Nightly | 95.0a1 | 11 | ✅
| Firefox Focus | 106.1 | 12 | ✅
| foobar2000 | 1.2.30 | 11 | ✅
| Formula 1 | 11.0.1533 | 11 | ⚠️ | Live Timing is broken, keeps crashing on initialization
| FX File Explorer | 9.0.1.2 (r9012) | 13, 12, 11 | ✅ | Tested only on the base version (without FX Plus)
| Game Pass | 2110.17.1005 | 11 | ✅ | GMS warnings might appear but these can be safely ignored | Cloud games can be launched but controlling them with controller or touch has not been tested.
| GBoard | Unknown | 12, 11 | ⚠️ | Will not work as expected in newest WSA (2204.x)
| GCash | 5.62.0 | 13, 12, 11 | 🆖 | Requires GMS and developer options disabled. Will warn "limited functionality" if no GMS is present, if present, it works normally. When it is launched for the first time, it will crash due to a lack of permissions granted on previous versions (5.61.0 and below). Starting with 5.62.0, an alert pops up `We have detected that you are running the GCash app on emulator. You will not be able to proceed.` 
| Geekbench | 5.4.1 | 11 | ✅
| GeoGebra | 5.0.674.0 | 11 | ✅
| GitHub | 1.146.0 | 13 | ✅ | Opening any web links using the "Windows default app" doesn't work (including the sign-in). | Set a default browser app first (like Chrome) if you want to use external links within the app
| Globe2Go | 4.7.4.20.0810/3890 | 11 | ✅
| GlobeOne | 1.9.39 | 12, 13| ✅ || May require GMS (otherwise use other login methods available in the app)
| Gmail | 2022.05.01.440951655.Release | 11 | ✅ || May require GMS
| Gojek | 4.30.1 | 11 | 🆖 | Requires GMS
| Google | 14.44.29.28.x86_64 | 13 | 🆖 | Requires GMS
| Google Calendar | 2022.18.2-448173739-release | 11 | ✅ | Requires GMS | Works fine
| Google Camera | Unknown | 11 | ✅ || Works fine
| Google Chrome | 119.0.6045.66 | 13, 12, 11 | ✅ | Requires microG or GMS to sync with Google Account |
| Google Classroom | 8.0.181.20.90.3 | 11 | ✅ || Notifications are generic (do not show content), clicking on them may not open the app. Uploading attachments locally is not possible.
| Google Contacts | 3.68.0.445910596 | Unknown | ✅ || The app may be glitchy from time to time, if that happens, restart the app
| Google Drive | 2.24.127.0.all.alldpi | 13, 11 | ✅ | Works fine, may require GMS
| Google Home | 3.14.1.5 | 13 | 🆖 | Requires GMS. | Tested on a WSA install with GMS. Bluetooth permissions can be easily bypassed by closing and opening the app again.
| Google Keep Notes | 5.24.092.02.90 | 13 | 🆖 | Requires GMS | Tested inside WSA with GMS. The app works properly, including notes, and account syncing, and responds accordingly to app window sizing including its landscape mode.
| Google Meet | 233.0.611229457<br>duo.android<br>20240218.16_p2 | 11, 13 | 🆖 | Requires GMS.| Tested with an NVIDIA RTX 4060 Laptop GPU. The share screen doesn't work due to WSA's windowed nature. Camera effects apart from lighting cannot be enabled and instead display "Something went wrong and the effect can't be started" 
| Google Messages | messages.android<br>20240312_00_RC02<br>phone_dynamic | 13 | 🆖 | Requires GMS.| Tested under WSA with GMS installed. Phone pairing works, along with RCS messaging to phone contacts. Responsive design by resizing also works, albeit it can be quite finicky. Syncing also works, provided a Google account is present.|
| Google Photos | 5.91.0.448844219 | 11 | ✅ | Requires GMS |
| Google Play Games | 2023.08.46243 | 13 | 🆖 | Requires GMS
| Google Play Store | 43.0.18-31 [0] [PR] 679686942 | 13 | 🆖 | Requires GMS. If you're changing languages a lot in the app, there's a prompt to restart the app to complete the update. Wait for a few seconds, then tap/click restart to proceed (sometimes works, sometimes not) or alternatively, clear the app data and open it again. | Play Protect certification status will be `Device is uncertified`
| Google Services Framework (APK) | 12, API 32 | 12 | ❌ | Although installation succeeds and apps become aware of it, it lacks a lot of permissions needed for most functions, e.g. `read_device_config`, which can't be given even with the Settings app.
| Google Translate | 6.45.0.474938783.2-release | 12 | ❌ | Crashes on startup due to reliance on Google Services Framework
| GoTyme | 1.36.0 | 13 | ❌ | App crashes immediately upon launching the app 
| Grab | 5.172.200 | 11 | ✅
| Grayjay | 253 | 13 | ✅ || Tested with the unversal installer variant. Works well on an Intel CPU with integrated graphics (performance may vary)
| Gycso | 1.1.0 | 12, 11 | ✅ |
| HBO Max | 52.15.0.53 | 11 | ⚠️ | Failed to play video (internal player fails to display image and play sound).
| Hidden Settings | 1.7.5 | 12 | ✅
| Hiragana Pro | 1.4.4 | 12 | ✅ | Scaling issue when the app is in landscape mode.
| Hobi | 2.1.7 | 11 | 🆖 | Requires GMS
| Home Assistant | 2022.3.0-full | 11 | ✅ | Basic functionality works, additional/extended functionality has not been yet tested.
| Housesigma Canada Real Estate | 4.3.6 (121) | 11 | ✅
| HTV (hanime tv) | 3.6.7 | 11 | ⚠️ | Failed to play video | Internal player doesn't work, asks for external player and fails again
| huaCtrl PRO | 1.0.27 | 11 | ✅
| Huawei AppGallery | 11.4.2.300 | 11 | ✅ | Frequent crashes were experienced, otherwise the app functionality is fine
| Hyper Square | 3.0.1 | 11 | ✅
| IFTTT | 4.29.2 | 12 | 🆖 | Need GMS to receive notification. Ignore the Notification Reader Access error. | To avoid Play Protect blocking login to the Google Store, use GMS version open_gapps-x86_64-11.0-pico-20220215. (See also: WSAGAScript issue #213). 
| Infinity | 7.2.9 | 13 | ✅ ||Works well in portrait and landscape resizing.
| Instagram | 244.0.0.17.110 | 12, 11 | ⚠️ || Need to use an Android keyboard (eg. MS SwiftKey) to be able to reply to stories (only works in 11. Keyboard app support in 12 is broken.
| Instagram Lite | 339.0.0.10.100 | 12 | ✅ 
| Intra | 1.3.8 | 12 | ✅ || VPN workaround is needed after installation to allow the app to create VPN connections.
| iOS app (any) || 11 | ❌ | Thanks for testing, Brad.
| Ipsos MediaLink | 5.2.20 | 13 | ✅ || The VPN workaround is required, as are Accessibility permissions, and a CA certificate needs to be installed (wsa://com.android.settings) 
| iPusnas | 1.5.1 | 11 | ✅
| iRobot | 5.2.4-release | 12 | ❌ | Error message `java.lang.UnsatisfiedLinkError: dlopen failed: library "libcore_jni.so" not found`
| Insta360 | 1.49.0 | 12 | ❌ | Error message `Sorry, Insta360 app is temporarily incompatible with your device.`
| J2ME Loader | 1.7.9-open | 13, 12, 11 | ✅
| JAKI - Jakarta Kini | 1.2.34 | 11 | 🆖 | Some features require GMS
| JioSaavn | 8.2.1 | 11 | ✅ | Doesn't support fullscreen and rare crashes but running fine
| Jiocinema | 3.0.2.7 | 11 | ✅ | May crash initially but subsequent runs should work correctly. 
| Jlpt | 4.7 | 12 | ✅ ||
| Joey (Reddit client) | 2.0.0.1 | 11 | ✅
| Jolibee  | 1.21.1 | 13 | ✅
| Joplin | 2.4.3 (2097651) | 11 | ✅
| JuiceSSH | 3.2.2 | 11 | ⚠️ | Connecting to SSH server needs multiple tries
| Kahoot || 11 | ✅
| Katakana Pro | 1.4.4 | 12 | ✅
| KawaiiNihongo | 3.10.9 | 12 | ✅
| KDE Connect | 1.29.0 | 13-7 | ❌ | Does not see any device on discover besides host computer, cannot connect to an external phone or computer |
| KernelSU | v0.7.0 | 13 | ✅ || Download this manager app after installing KernelSU root
| Khan Academy | 7.3.3 | 11 | ✅
| Kik | 7.10.1.176 (82) | 11 | ✅
| Kindle | 8.47.1.3370 | 11 | ✅
| Kiwi Browser | 107.0.5304.74 | 13, 12 | ✅ |
| Kobo Books | 8.40.29843 | 11 | ⚠️ | Aspect ratio and resolution are fixed, appears blurry when resized
| Koguma | 0.0.1 | 13 | ✅
| Kotatsu | 6.8.3 | 13 | ✅ | | Keyboard navigation is supported
| KRL Access | 4.1.0 | 11 | ❌ | App crashes
| LANDBANK | 6.1.1 | 13 | ✅ | The app runs for the most part, however, during the user signing up for a bank account, it alerts you to `Error: The device is incompatible with the SDK` when verifying the identity of the user signing up
| Lawnchair | 14 beta 2 | 13, 12, 11 | ✅ | The app drawer seems to be blank in portrait. A workaround would be either maximizing the app or resize it to be in a landscape orientation. Can't change the wallpaper with a toast notification: `Disabled by your admin`.
| Lazada | 7.37.0 | 13 | ⚠️ | Google login requires GMS installed (use Email or Facebook login as alternatives). `Slide to verify` appears too often if logging in. Weird scaling options (interface elements are too large) | Keep it in portrait for the app to be usable.
| Libby | 4.3.1 | 11 | ✅
| LINE | 12.0.1 | 11 | ✅
| Line Rangers | 7.6.3 | 11 | ✅
| LinkedIn | 4.1.632 | 11 | ✅
| Logcat Reader | 1.7.2 | 13 | ✅ | 
| LNReader | 1.1.18 | 13, 12 | ✅ || Partial keyboard navigation is available (example: arrows key up and down - scrolls) when reading a light novel.
| LSPosed | 1.8.6 | 13, 11 | ✅
| Magisk | 25.2 | 13, 11 | ✅ || Magisk developer confirmed able to gain root access - [link to his tweet](https://twitter.com/topjohnwu/status/1451282578514735131)
| ManCityApp | 2.1.11 | 11 | 🆖 || Might require GMS
| MangaYomi | 0.2.2 | 13 | ✅ | Doesn't support keyboard (media) controls on the media player | Manga reader supports keyboard navigation. Tested with the x86_64 release.
| Manzur's Study Circle (MSC) | 1.0.2 | 11 | ✅
| Material Files | 1.5.2 | 12, 11 | ✅
| Maya (Paymaya) | 2.85.1 | 13 | ❌ | App crashes immediately upon launching the app 
| McDonald's | 2.76.0 | 13 | ❌ | Device verification fails on the first welcome screen and displays "Your device did not pass our security check. Please check that you run a Google trusted OS version, that the device is not rooted, and that you have no harmful apps installed.
| Meta Quest (Oculus) | 181.1.0.81.114 | 12 | ⚠️ | Can't log in with a Meta account, but you can install the Facebook or Instagram app and enable "Logging in with accounts" in the Meta Accounts Center, and use the in-app login. Doesn't detect Quest 2 nearby, due to no Bluetooth support.
| microG Settings | 0.3.1.4.240913 | 13 | ✅ | 
| Microsoft Authenticator | 6.2112.8213 | 11 | ✅ || Some features might require GMS
| Microsoft Azure | 3.9.2.2021.09.30-19.35.50 | 11 | ✅
| Microsoft Bing - Search & earn | 23.5.401109307 | 12 | ✅
| Microsoft Edge | 120.0.2210.157 | 13,11 | ❌ | Always stuck in Microsoft Edge First Run Experience and a few seconds later, crashes out
| Microsoft Edge Canary | 103.0.1264.1 | 11 | ❌ || Fails to load websites
| Microsoft Launcher | 6.230703.0.1122680 | 13, 11 | ✅ | Can't set wallpaper
| Microsoft PowerApps | 3.21124.20 | 11 | ✅
| Microsoft Swiftkey Keyboard | 8.10.12.4 | 12, 11 | ✅ | Works on WSA 2203 (Android 11), but on-screen is completely broken in WSA 2204(Dev) (Android 12.1)
| Microsoft Teams | 1416/1.0.0 | 12 | ✅
| Mic Test | 5.2 | 12 | ✅ || lauresprojects.com.mictest
| Mihon (Beta) | 0.16.5-r6916 | 13 | ✅ | Notifications like "Large updates harm sources..." cut off. "Updating Library" progress bar doesn't show, until you clear the Mihon notification. Pressing any key on the keyboard during the Onboarding Guide (the thing when you start Mihon for the first time) will crash the app. | Some of the notifications will be missing due to the Windows Action Center limit of 20. When setting up the tracker, make sure to set the default browser (like Firefox) to sign in. `Copy to Clipboard` in the reader works and you can paste it to any windows app (like Paint).
| Mihon (Stable) | 0.16.5 | 13 | ✅ |Notifications like "Large updates harm sources..." cut off. "Updating Library" progress bar doesn't show, until you clear the Mihon notification. Pressing any key on the keyboard during the Onboarding Guide (the thing when you start Mihon for the first time) will crash the app. | Some of the notifications will be missing due to the Windows Action Center limit of 20. When setting up the tracker, make sure to set the default browser (like Firefox) to sign in.
| MiX | 6.57.0-Beta_B21070510 | 11 | ✅
| Mobile JKN | 3.7.1 | 11 | ✅ || Some features might require GMS
| MOLA | 2.1.3 | 11 | ❌ | App crashes
| Monogolf | 3.4.10 | 13 | ✅ | 
| Monument Browser | 1.0.333 | 12 | ✅
| Moodle | 3.9.5 | 11 | ✅ 
| MPV | 2023-11-30-release | 13, 12 | ✅ | Picture in Picture doesn't work | Keyboard navigation supported in the media player
| MT File Manager | 2.10.0 | 11 | ✅
| Musically (TikTok) | 7.8.0 | 11 | ✅
| Muslim Pro | 1.2.3 | 11 | 🆖 | Requires GMS
| MX Player | 1.40.9 | 11 | ✅
| MX Player Pro | 1.39.13 | 11 | ⚠️ | App crashes, but videos can be played from external sources
| myPLDT Smart | 2.0.1 | 13 | ✅ | Requires GMS only when logging in using Google account. You can try logging in with e-mail instead. | Sideloaded installation
| MyPostNord (Norway) | 3.12 | 12 | ✅ 
| My Verizon | 16.4.2 | 11 | ✅ || The page might be displayed sideways for a short amount of time when the app is launched. The app automatically reverts to the correct orientation in a second.
| NClientV2 (Release)| 3.0.5 | 13 | ✅ | Keyboard navigation is unsupported when reading. | You can try enabling `Disguise app in drawer` but it doesn't work in the Windows start menu, but works with an installed launcher like Lawnchair or Rootless Pixel Launcher.
| Neko | 2.17.1 | 13, 12, 11 | ✅
| Nekogram X | 8.1.2-1-rc01 | 11 | ✅ || Use NoGcm variant
| Netflix (Aurora Store) | 8.4.0 | 11 | ❌ | "Device not supported" error
| Nettfart Mobile | 3.6.8 | 12 | ✅ | The app must be given network permissions in App Settings
| Network IP Scanner | 3.2 | 11 | ⚠️ | Only scans WSA's own VirtWifi network
| NewPipe | 0.22.1 | 11 | ✅
| NextDNS | 1.2 | 12 | ✅ || VPN workaround is needed after installation to allow the app to create VPN connections.
| NFL | 57.0.7 | 11 | ⚠️ | Videos/streams do not play or load. If embedded in an article, they only play without sound.
| Nintendo Switch Online | 2.2.0 | 12 | ✅ | Only displays in portrait 
| Nova Launcher | 7.0.49 (7049) | 11 | ⚠️ | UI is messy, but app drawer is fine
| Nova Launcher Beta | 8.0.2 | 12 | ⚠️ | UI is messy, but app drawer is fine
| Nu Carnival | 1.0.2-erolabs | 11 | ❌ | App stuck on a black screen
| Octopath Traveler: Champions of the Continent (CotC) | 1.5.0 (753410) | 12 | ❌ | OpenGL ES 3.1 (or higher) is unsupported | Security policy violation: 32  (Most likely due to OpenGL issue)
| Office | 16.0.14527.20162 | 11 | ✅ || Might require microG
| Office Lens | 16.0.14527.20178 | 11 | ❌ | Might require GMS, cannot sign in
| Okay? | 4.08 | 11 | ✅
| One Store | 7.6.0 | 11 | ✅
| Open Camera (F-droid) | 1.52 | 13 | ❌ | Crashes upon launching the app
| Opera Browser Beta | 65.1.3381.61349 (x86_64) | 11 | ✅ || Change app layout to Tablet Mode for a better experience
| Opera GX : Gaming Browser | 1.3.6 | 11 | ✅
| Opera Mini Beta | 61.0.2254.59921 | 11 | 🆖 | Requires GMS
| Opera Touch Browser | 2.9.6 | 11 | ⚠️ | My Flow feature requires GMS | GMS warnings might appear but these can be safely ignored
| Oppo App Store (China) | 8.6.4 Beta 1 | 11 | ❌ | App freezes on blank screen
| Oppo Game Center (China) | 9.7.0_14b2c0c_210521 | 11 | ✅
| Oreo: Twist, Lick, Dunk | 1.5.6 | 11 | ✅ | Minor graphical glitches
| OsmAnd~ | 3.9.10 | 11 | ✅
| Oss (Norway) | 2.9.2 | 12 | ❌ | Crashes on startup. The error log shows `java.lang.UnsatisfiedLinkError: couldn't find DSO to load: libhermes.so`
| Oto Music | 3.0.2 | 11 | ✅ || Requires app restart to refresh list
| OTT Navigator | 1.6.7.7 | ❌ | Crashes on video playback
| OurGroceries | 4.0.10 | 11 | ✅ | Premium keys require Google Play Store
| Outlook | 4.2138.0 | 11 | ⚠️ | Cannot activate device administrator with Outlook, which prevents activation.
| Package Manager | v7.0 | 13,12 | ✅ || Recommeded with use of Shizuku for multi-app installation
| PalawanPay | 1.0.4634210 | 13 | ❌ | Starting in this version, Google Play will alert you with "This app won't work for your device" and if you sideloaded an older version of the app, the app prompts you to update but when you press "Update app", it takes you to the Google Play listing, it only lets you uninstall it, or open the app.
| Phigros || 11 | ✅
| Philips Hue | 4.29.0 | 12 | ✅
| Photomath | 8.22.0 | 13 | ✅ || Installed via `adb` command
| Pixel People | 4.7 | 11 | ✅ | Changing window size breaks the game. Runs at low FPS but is still playable.
| Playstation App | 21.11.2 | 11 | ⚠️ | Runs very slow and takes some time to connect to voice chat, beside that it works  
| Plex | 8.26.2.29389 | 11 | ✅
| Plex Dash | 1.1.1 | 11 | ❌ | App crashes after splash screen
| Plexamp | 3.8.2 | 11 | ⚠️ | Layout and app orientation issues
| Pocket | 7.56.0.0 | 11 | ⚠️ | Unable to log in with a Firefox account, instant (push) syncing is unavailable
| Pokémon Home | 3.1.2 | 13 | ✅/🆖 | | Depending where the plan subscribed, it may requires GMS support if subscribed via Google Play
| Polar Flow | 6.12.0 | 12 | ✅ | Not able to sync via Bluetooth since WSA doesn't support it. | Syncing via web and interaction is otherwise fine.
| PornHub || 11 | ✅
| Posten (Norway) | 5.16.4 | 12 | ❌ | If installed through the APKPure app, it crashes after the splash screen. If trying to install a locally downloaded XAPK over ADB that simply had its file extension changed to `.apk`, the error message `Failure [INSTALL_PARSE_FAILED_UNEXPECTED_EXCEPTION: Failed to parse /data/app/vmdl1025447652.tmp/base.apk: AndroidManifest.xml]` shows up.
| PostNord | 8.22.2 | 12 | ⚠️ | On the "Verify mobile number" page, keyboard key presses are not recognised, making it impossible to verify phone numbers.
| PowerPoint | 16.0.14527.20162 | 11 | ✅ | Might require GMS / MicroG
| P R O T O | 1.27.0 | 13 | ⚠️ | Zoom in circuit simulation will be reset when resizing window
| Prep Ladder | 2.0.79-p | 11 | ⚠️ | Video pane opens but no audio or video and time keeps on going
| Pydroid | 5.00_x86_64 | 11 | ✅
| Q-Dance | 8.0.7 | 11 | ❌ | App crashes
| QooApp | 8.3.35 | 13, 11 | ✅ | QooApp Servant may not work due to WSA's windowed nature
| QR & Barcode Scanner (F-droid) | 1.10 | 13 | ⚠️ | Errors out with a `Unable to access camera` even using a built-in laptop camera | You can still generate QR codes for URLs and other stuff
| QR Scanner (F-droid) | 4.5.8 | 13 | ✅ | Does not work with a virtual camera | It can scan and generate QR codes
| QPython 3L | 3.0.0 | 11 | ✅
| QQ | 8.9.28 | 13, 12 | ❌ | App crashes
| QuickNovel | 3.1.4 | 13 | ✅
| Reddit || 11 | ✅
| Relay | 10.0.378 | 11 | ✅
| Remini - AI Photo Enhancer || 11 | ⚠️ | Oops! Something went wrong Your image didn't save. Please try again.
| Remote Desktop (Microsoft) | 10.0.12.1148 | 11 | ✅
| ReVanced Manager | 1.20.1 | 13 | ✅ | 
| Rider | 1.59 | 11 | ✅
| Robinhood - Food & Booking | 2.2.2 | 12 | ⚠️ | App having trouble loading content. Maps & Location picker don't work (Requires GMS). | You can log in only on one device at the same time. Previous device will log out upon signing in on new device.
| Rootless Launcher | 3.9.1 | 11 | ❌ | App crashes
| Rootless Pixel Launcher | 3.9.1 | 13 | ✅ | Can't change wallpaper with a message: `Disabled by your admin`.
| Ruler (F-Droid) | 1.1 | 12 | ❌ | While the app is correctly installed, the ruler lengths are wildly off-course no matter how much in-app calibration is done. | The app also refuses to recognise values above circa 100mm for the 70mm calibration line.
| Saikou β (Beta) | 1.2.1.0 | 13, 12 | ✅ || Some keyboard functionality is somewhat limited but usable (both media playback and manga reading)
| SAI (Split APKs Installer) (Play Store) | 4.5 | 12 | ✅ || Used rootless method only, not yet tested for rooted WSA
| SAI (Split APKs Installer) (F-Droid) | 4.5 | 12 | ✅ || Used rootless method only, not yet tested for rooted WSA
| SATRIA | 1.0.0 | 11 | ❌ | Needs fingerprint reader support
| SD Maid (pro) | 5.2.2 | 11 | ⚠️ | Unable to grant external storage privileges, can be skipped
| Settings | 13, API 33 | 13 | ⚠️ | Setting screen lock to "Swipe", makes it impossible to use any apps without re-installing the entire Subsystem, since no method is provided on the lock screen to swipe or otherwise unlock. Adding a Google account in the Account menu doesn't work (the settings app will quit if you just clicked back when adding a new Google account). "Backup" and "SOS Alarm" send the phone back to the main Settings menu. | Included by default in Subsystem. Accessed by creating a Windows shortcut with this path: `%LOCALAPPDATA%\Microsoft\WindowsApps\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\WsaClient.exe /launch wsa://com.android.settings`
| Shazam | 13.19.0-230223 | 13, 12 | ✅ | Shazam on pop-up doesn't work | Requires microphone for song identification
| Shein | 9.9.4 | 13 | ✅ || Keep it in portrait to be usable
| ShemarooMe | 1.0.16 (106) | 11 | ✅
| Shizuku (Play Store) | 13.5.4.r1049.0r53409 | 13, 12, 11 | ✅ | Can't toggle wireless debugging in WSA 2207.40000.8.0 (android 12), use ADB on PC to use connect instead (even with dev options and USB debugging is on). | The service also works with root (Tested with Magisk)
| Shopee (PH) | 3.35.31 | 13, 11 | ⚠️ | Any login attempt, even if Magisk DenyList is enabled for Shopee PH, would result in a ``Login Failed (F13) error: Oops, your account has been restricted due to unusual activities. Please make sure you comply with Shopee policies.`` Google login requires GMS installed (use Email or Facebook login as alternatives). Banner information is stretched horizontally 
| Shosetsu | 2.4.4 | 13, 12 | ✅ | Keyboard navigation is unsupported when reading light novel.
| Showtime | 3.1.1 | 11 | ❌ | App crashes when you try to login. Button clicks don't work
| SIM Toolkit (Google) | 12, API 32 | 12 | ❌ | Does not launch even with a shortcut.
| Simple Gallery | 5.3.9 | 11 | ❌ | App crashes when you try to view a photo
| Sky Map | 1.10.0 - RC3 | 11 | 🆖 | Complains about missing accelerometer controls, requires GMS
| Skype | 8.91.0.406 | 12 | ✅
| SkySafari | 6.8.6.15 | 11 | 🆖 | Failed license check on startup, appears to require GMS
| Slack | 21.11.20.0-B | 11 | ✅
| Smart GigaLife | 3.4.2 | 13 | ⚠️  | Tested on WSA with GMS installed. Suppose Magisk DenyList is not enabled for the app, in that case, it will display a warning: **We noticed that your device OS has been reconfigured** and warns the user that their GigaLife account may be at risk. Enabling DenyList for this would bypass this behavior. The app works fine and all navigation options can be navigated.
| Smart Launcher | 5.5 Build 052 | 11 | ✅
| Smart Life | 3.32.5 | 11 | ❌ | The app is producing constant flashes between light and dark mode, and the UI element of agreement pop-up is moving on screen so it can't be accepted
| Smash Hit | 1.4.3 | 13 | ✅ |
| Snapchat || 11 | ⚠️ | Camera view is flipped | GMS warnings might appear but these can be safely ignored
| Solid Explorer File Manager | 2.8.28b | 12 | ✅
| Sonic Mania Plus - NETFLIX | 5.0.1 | 13 | ✅ | Sometimes an NGP Error will happen
| Sonic Prime Dash | 1.9.0 | 13 | ✅ | |White bars as the border|
| Sonic The Hedgehog 2 Classic | 1.10.2 | 13 | ✅ |
| SoundHound | 10.1.2 | 12 | ✅ |  | Ensure in Windows' audio settings that the microphone has a high enough sound level 
| Speedtest by Ookla | 4.8.0 (177906) | 12 | ✅ | VPN workaround is needed after installation to allow the app to create VPN connections.
| Spotify | 8.7.30.1221 | 12, 11 | ✅ | 
| Spotify Lite | 1.9.0.2883 | 11 | ✅
| Squircle IDE | v2022.1.2 | 12, 11 | ✅
| Steam | 2.3.13 | 11 | ✅
| Steam Chat | 1.0 | 11 | ✅
| Steam Link | 1.1.81 | 11 | ❌ | App crashes
| Stocard | 10.12.1 | 12 | ✅ || To log in to an earlier Stocard account that is set to use Google login, it needs to be transitioned from a Google-based account to an E-mail-based account, which has to be done on a phone.
| SwiFTP FTP Server (Free) (F-Droid) | 3.1 - 30100 | 13, 12, 11 | ✅ | A network connection is required for the FTP service to initialize. Does not work with `Local network access` turned on in WSA Settings
| SwiFTP Server | 1.24 | 11 | ✅
| Symbolab | 9.3.0 | 11 | ✅ || Keyboard not working, in-app keyboard is available though
| Sync for Reddit Pro | 20.0.3 | 11 | ✅
| Tachiyomi (Preview) | 0.15.3-6421 | 13, 12, 11 | ✅ | Notifications like "Large updates harm sources..." cut off. Sometimes, "Updating Library" progress bar doesn't show, requires to clear the Tachiyomi notification. | Some of the notifications will be missing due to the Windows Action Center limit of 20.
| Tachiyomi (Stable) | 0.15.3 | 13, 12, 11 | ✅ | Notifications like "Large updates harm sources..." cut off. Sometimes, "Updating Library" progress bar doesn't show, requires to clear the Tachiyomi notification. | Hovering the mouse pointer, highlights the input element. Some of the notifications will be missing due to the Windows Action Center limit of 20.
| TachiyomiAZ | 8.8.1-AZ | 13, 12, 11 | ✅
| TachiyomiJ2K/TachiJ2K | 1.7.4 | 13, 12, 11 | ✅ | Parsing links (from a browser) causes to open the Tachiyomi extension window or app picker dialog instead of opening TachiJ2K itself when you have multiple Tachiyomi forks are installed.
| TachiyomiSY | 1.10.5 | 13, 12, 11 | ✅
| Tap Tap | 3.1.1 | 12, 11 | ✅ | Sometimes freeze if you brute force the app, fixed by restarting the app
| TeamViewer | 15.22.136 | 11 | ✅
| Telegram | 8.1.2 | 11 | ✅
| Televizo | 1.9.0.1 | 11 | ❌ | Crashes on video playback
| Terminal Emulator for Android | 1.0.70-rebuild | 12 | ✅ | A warning shows up about the app being designed for older Android versions, but can be dismissed
| Termux (F-droid) | 0.118.1 | 13, 12, 11 |✅
| Tesla | 4.6.1 | 11 | ⚠️ | Vehicle graphics and maps do not load, cannot enable phone key. | Internet-based vehicle controls, charge stats, services are functional.
| The Globe and Mail | 6.2.0 (100) | 11 | ✅
| TIDAL | 2.49.0 | 11 | ✅
| TikTok (China) | 18.1.0 | 11 | ⚠️ | App crashes on first startup and you might face hiccups logging in
| TikTok (Global) | 25.0.3 | 12, 11 | ✅
| TikTok (TV Version) | 1.6.0 | 11 | ❌ | App crashes
| TikTok Lite | 21.7.1 | 11 | ❌ | App crashes
| Tivimate | 4.4.0 | 11 | ✅ | Compatibility Options -> Force App to be non-resizeable ; Disable smooth resize ; Keyboard Compatibility ; ForceFullScreen [F11] Note: Version 4.5. And above force crashes, the latest working version remains 4.4.0
| TP-Link Tapo | 2.4.25 | 11 | ✅
| Trello | 2021.14.1.16332-production | 11 | ⚠️ | Login needs web browser installed in WSA, using Windows' default browser will not work
| Trust: Crypto & Bitcoin Wallet | 6.57.1 | 12 | ✅ || For login, you have to go to Android settings => System => Date & Time and toggle the "Set Time Automatically" option. you can access it by this command .\adb.exe shell "am start -n com.android.settings/.Settings"
| Tune In Pro | 28.7 (267721) | 11 | ✅
| Twitter | 9.16.1-release.00 | 11 | ✅ | Optionally requires GMS
| Twitter Lite | 3.1.1 | 12 | ✅ ||
| UC Browser | 13.0.0.1288 (x86) | 11 | ✅ || Avoid updating the app
| Uptodown App Store | 4.35 | 11 | ⚠️ | Keeps "analyzing device" on app details page, thus it's unable to download APKs.
| Vanced Manager | 2.6.2 (Crimson) | 11 | ✅
| Vanced MicroG | 0.2.22.212658 | 11 | ⚠️ | microG Google sign-in method does not work, hence use Huawei sign-in method to sign in to Google account
| Via Browser | 4.3.1 | 11 | ✅
| Viaplay | 5.48 | 12 | ✅ || Episode playback of at least Nella the Princess Knight works correctly, as does the phone-app-exclusive download functionality.
| Vidio | 5.64.5-f0aa483a3d | 11 | 🆖 || Might require GMS for login
| Vipps | 2.142.0 | 12 | ❌ | Shows an error message about requiring "Google Services", even if both Google Play Services and Google Services Framework APKs are installed
| Vivaldi Browser | 4.3.2439.61 | 11 | ✅
| VK | 6.58 | 11 | ✅
| VLC | 3.5.3 | 12, 11 | ✅ || Keyboard supported in media player
| VNeID | 2.1.0 | 13 | ❌ | According to Google Play Store, the app is incompatible. Indeed, after attempting to sideload the APK, it shows a blank screen on launch and constant notifications saying "Your device has been compromised"
| Voice Recorder | 55.1 | 12 | ✅ || com.media.bestrecorder.audiorecorder
| VSCO | 264 | 11 | ⚠️ | Cannot sign in
| Warden | 1.0.3.release | 11 | ⚠️ | App screen flashes otherwise functionality-wise its normal
| Wattpad | 10.44.0 | 13 |  ✅  | *The Wattpad version tested in this WSA install (Magisk with GMS) is a modded one (no ads).* App works, including the theming and responsive design based on the window size. Online sign in works as well (tested using Facebook SSO), along with offline reading support. 
| Wealthsimple Trade | 2.27.1 (2195) | 11 | ✅
| WeChat | 8.0.32 | 13, 12 | ✅
| WhatsApp | 2.21.20.20 | 11 | ⚠️ | WhatsApp cloud chat backups will not work, app was tested with microG installed
| Windscribe | 3.74.1243 | 13 | ✅ || VPN workaround is needed after installation to allow the app to create VPN connections.
| Windy|42.2.3 | 13 | ✅ || The satellite features of this app work, alongside with location features, although you have to grant the app access to it.
| Word | 16.0.14430.20246 | 11 | ✅ || Might require microG services.
| Wulkanowy (F-Droid) | 1.4.3 | 11 | ✅
| Wulkanowy (Play Store) | 1.4.3 | 11 | 🆖
| Wyze | 2.30.0 | 11 | ✅
| Xbox Game Pass (Beta) | 2212.51 | 12 | ✅ || Everything works in this app, tested Cloud Gaming on Windows 11 build 25236 and WSA 2209.400. connected my Xbox Series X controller to PC and the app worked perfectly with it.
| Xbox Game Pass | 2211.42 | 12 | ✅ || Everything works in this app, tested Cloud Gaming on Windows 11 build 25236 and WSA 2209.400. connected my Xbox Series X controller to PC and the app worked perfectly with it.
| Xbox Family Settings | 20221104 | 12 | ✅
| Xbox Beta | 2211.2.7 | 12 | ✅
| Xbox | 2211.1.4 | 12 | ✅
| XBrowser | 3.7.7 | 11 | ✅
| xManager | 3.3 | 11 | ✅
| X-plore File Manager | 4.27.10 | 11 | ✅
| Yahoo! Fantasy Sports | 10.31.0 | 11 | ❌ | App crashes on launch
| Yandex.Maps | 10.6.0 | 11 | ⚠️ | Map doesn't work
| Ymusic | 3.7.2 | 11 | ✅
| Yodayo (Play Store)| 1.4.2 | 13 | ✅ | Requires GMS only when logging in using Google account. You can try logging in with e-mail instead. | 
| Yodayo (APK) | 1.19.0 | 13 | ✅ | Requires GMS only when logging in using Google account. You can try logging in with e-mail instead. | 
| Yokai | 1.8.4.3 | 13 | ✅
| YouTube (Google)| 16.40.35 | 11 | 🆖 | Requires GMS
| YouTube Music (Google) | 5.07.50 | 11 | 🆖 | Requires GMS
| YouTube Music Vanced | 43.9.50 | 11 | ✅
| YouTube Music ReVanced | 6.19.51 | 13 | ✅ || Used the x86-64 version as base
| Youtube ReVanced | 19.16.39 | 11, 13 | ⚠️ | Picture-in-picture doesn't work & Can't join channel membership
| ZArchiver | 0.9.5.8 (9596) | 11 | ✅
| Zenly (w/o GMS) | 4.55.2 | 11 | ⚠️ | App crashes after login, but background location works
| Zoom | 5.8.3.2634 | 11 | ⚠️ | Camera severely glitched, share screen doesn't work due to WSA's windowed nature.
| Æ | 2.0.7 | 12 | ✅ | Adding debit cards requires Vipps, an app that is shown above in this list as not working. | 
| 哔哩哔哩 (Bilibili) || 11 | ✅
| 酷安 (CoolApk) | 11.4.3 | 11 | ⚠️ | Unable to sign in using third-party apps
| 创建快捷方式 (Create Shortcut) | 1.17 | 11 | ✅ || Can be used to access any app
| মুনাজাতে মাকবূল ও মাসনূন দু'আ - Munajate Makbul | 1.0 | 11 | ✅
| 九黎 | 1.3.5.01 | 11 | ❌ | App crashes
| 米游社 (miHoYo Chinese Community) | 2.14.1 | 11 | ⚠️ | The app might lag when inserting a photo into a new post
| СберБанк (SberBank) | 12.9.0 | 11 | ✅
| Тинькофф (Tinkoff Bank) | 5.20.0 | 11 | ✅
| (腾讯会议国际版) VooV | 2.12.5.504 | 11 | ✅
| 微博 (Weibo) | 11.10.1 | 11 | ⚠️ | Cannot sign in using password, shows limit reached for verification codes
| 微博国际版 (Weibo International) | 3.9.8 | 11 | ⚠️ | Cannot sign in
| 微博极速版 (Weibo Fast) | 10.9.2 (4620) | 11 | ⚠️ | Cannot sign in
| 文件管理器+ | 2.7.1 | 11 | ✅
| 超星学习通 | 4.6.1 | 11 | ✅
| 超星学习通 | 5.0.3 | 11 | ❌ | Crashes on startup

### Games

| Game | Latest tested version | Android versions | Support level | Known Issues | Notes |
|-------------|-----------------------|------------------|---------------|--------------|-------|
| 2 3 4 Player Games | 3.8.8 | 12 | ✅ || Touchscreen is recommended for the Team vs. Team matches or some of the driving games
| 8 ball pool | 5.5.6 | 11 | ✅ |
| A Dance of Fire and Ice | 1.15.5 | 11 | ✅ || Keyboard supported
| AFK Arena | 1.72.01 | 11 | ⚠️ | Can't login using Google account
| AirTycoon Online 3 | 1.3.0 | 13 | ⚠️ | You need touchscreen for making the flight routes (using a tablet with spacedesk works just fine and is easy to set up)
| Alan Walker-The Aviation Game | 3.0.6 | 11 | ✅ || Touchscreen and cursor works; keyboard doesn't work
| Alien: Blackout | 2.0 | 11 | ⚠️ | Terrible in-game experience, includes poor performance and low FPS
| Alto's Adventure | 1.8.15 | 13, 11 | ✅
| Alto's Odyssey | 1.0.10 | 11 | ✅
| Among Us | 2022.7.12 | 12, 11 | ✅ | Keyboard may be unresponsive. | Xbox controller works.
| Angry Birds Epic | 3.0.27463.4821 | 11 | ⚠️ | Terrible in-game experience, bad performance and low FPS
| Animal Crossing: Pocket Camp | 5.0.2 | 12 | ❌ | error 802-1-01a-069-008 ||
| Arcaea | 3.8.8 | 11 | ⚠️ | Keyboard doesn't work on login/register form
| Archero | 4.8.2 | 12 | ✅ | Requires GMS and Play Games to load your cloud progress
| Arknights | 18.9.81 | 13 | ✅ | Stable FPS throughout the game using NVIDIA GeForce GTX 1650, AMD GPU untested.
| Arknights (明日方舟; Simplified Chinese) | 1.6.01 | 11 | ✅
| Arknights (CN Server) | 1.9.21 | 12 | ✅
| Asphalt 8 | 7.6.0i| 12, 13 | ✅ | Keyboard supported in latest version (2311.40000.5.0) but requires GMS for game progress syncing thru Google Account. Account progress syncing works using a WSA install with GMS and a Google account.
| Asphalt 9 || 11 | ⚠️ | Keyboard unsupported
| Avakin Life || 13 | ⚠️ | Low FPS with iGPUs
| Azur Lane | 6.1.2 | 12, 11 | ⚠️ | Sometimes stuck on downloading resources, can be fixed by restarting the app. Overall gameplay, got stable FPS using NVIDIA GeForce GTX 1050 Ti Mobile
| Bad Piggies HD | 2.4.3141 | 11 | ✅
| BanG Dream! Girls Band Party! | 4.5.0 | 11 | 🆖 | Requires GMS
| Battle Cats Quest | 1.0.4 | 11 | ✅
| Beat the Boss 4 | 1.7.7 | 13 | ✅
| Blue Archive (GB) | 1.53.225706 | 13 | 🆖 | Tested with GMS / Google login, stable framerate on High settings using NVIDIA GeForce GTX 1650.
| Blue Archive (ブルーアーカイブ; JP) | 1.35.231115 | 13 | ✅ | Installing the HEVC video extension (9NMZLZ57R3T7 or 9N4WGH0Z6VHQ) will work properly. If not installed, it will be stuck in black screen.
| Blue Archive (Global) | 1.60.260228 | 13 | ❌ | The app crashes with no context loaded in few seconds | Installed via `adb` command
| Blue Archive (KR) | 1.39.146794 | 12, 11| ❌ | HEVC codec support required
| Blue Archive (KR, Onestore distributed) | 1.50.203922 | 13 | ✅ | Does not work with Nvidia graphics
| Brawl Stars | 38.159 | 11,13 | ❌ | Game crashes
| C.A.T.S (Crash Arena Turbo Stars) | 2.40.2 | 11 | ✅ | GMS warnings might appear but these can be safely ignored
| Candy Crush Saga | 1.213.2.1 (12132011) | 11 | ✅
| CarX Highway Racing | 1.17.1 | 11 | ⚠️ | Terrible in-game experience, includes poor performance and low FPS
| Clash Mini | 1.1142.10 | 11 | ❌ | App crashes
| Clash of Clans | 15.292.12 | 13 | ❌ | App crashes
| Clash Royale | 3.6.1 | 11 | ❌ | App crashes
| Clouds & Sheep 2 | 1.4.6 | 11 | ✅ | Optionally uses GMS
| Command and Conquer: Rivals | 1.8.1 | 12, 11 | ✅ || It will pop up "Won't run without GPlay services" when starts, but works fine except GPlay login. You may use link email instead.
| Crazy Taxi Classic | 4.7 | 12 | ❌ | An error message on startup says "Download failed because the resources could not be found." | OBB installation has not yet been tested.
| Cricket (Play Games) | 2023.08.46243 | 13 | 🆖 || Requires GMS
| Death Palette (Matsuro) | 4.3.0 | 11 | ✅ | 
| Deus Ex GO | 2.1.111374 | 11 | ⚠️ | Terrible in-game experience, includes poor performance and low FPS
| Destiny Child | 2.8.6 | 11 | ⚠️ | Poor performance during battles
| Dwarf Balls | 3.5.2 | 11 | 🆖 | Requires GMS for Google Play login.
| Endless Frontier - Idle RPG | 3.5.3 | 12 | ❌ | OpenGL ES 3.1 is unsupported
| Epic Seven | 1.0.406 | 11 | ⚠️ | Low FPS, unable to sign in with Google
| Extreme Car Driving Simulator | 6.74.0 | 13, 12, 11 | ✅ | Keyboard & controller supported
| F1 Mobile Racing | 5.1.11 | 13 - 7 | ❌ | No 3D rendering with any of the GPUs selected. Just shows a purple screen in game.
| Fancade | 1.7.6 | 11 | ❌ | App crashes
| Fate/Grand Order (US) FGO | 2.34.0 | 12, 11 | 🆖 || Require Google Play Services, skippable if you have Google Play Service (APK) installed
| Fire Emblem Heroes | 6.7.0 | 12, 11 | 🆖 | Requires GMS. If GMS is installed, it cannot be played due to SafetyNet error.
| Flappy Bird | 1.3 | 13 | ⚠️ | Crashes sometimes after 20 points if there's no internet for Google Play Games to be loaded on game startup, which indicates that this game might require GMS | Sideloaded
| Fortnite | 14.10.0 | 11 | ❌ | Crashes at login screen
| Fortnite Installer | 4.1.4 | 11 | ❌ | "Device not supported" error
| Fractal Space | 2.640 | 13-5 | ✅ || No keyboard support. Works fine on controller
| Fractal Space HD | 2.640 | 13-5 | ❌ || Crash on startup, borked
| Fruit Ninja | 3.3.4 | 11 | ✅ | Version check error | Otherwise, other app functionality is fine
| Game Dev Story | 2.47 | 11 | ❌ | App can start but with infinite "loading" screen
| Garage: Bad Dream Adventure | 1.0.191 | 11 | ⚠️ | Stuck after start of Chapter 1
| Geometry Dash | 2.11 | 11 | ✅ | If you use high refresh rate monitor, there is a small period where the game speeds up before the level plays for the first time and the audio will get desynced. You can simply pause and resume or die once to fix it since it won't happen on second attempt.
| Girls' Frontline (EN) | 2.0900_375 | 12, 11 | ⚠️ || Sometimes freeze while downloading resources, fixed by restarting the app
| Golf Rival | 2.54.241 (88) | 11 | 🆖 | Requires GMS | Produces warnings about GMS. Issues include not being able to pan.
| Grand Theft Auto: San Andreas || 11 | ✅
| Guardian Tales | 2.53.1 | 12, 11 | 🆖 | Requires GMS
| Hatsune Miku: Colorful Stage! | 2.3.8 | 13 | ✅ | Game performs well with "lite" setting, frame drop in 3d  
| Hay Day | 1.55.93 (1706) | 1 | ❌ | App crashes on startup (Worked on 1.54.71 and earlier)
| Hill Climb Racing | 1.53.0 (501) | 11 | ✅
| Hitman Sniper | 1.7.193827 | 11 | ⚠️ | Terrible in-game experience, includes poor performance and low FPS
| Honkai Impact 3rd | 7.3.0 | 11, 13 | ⚠️ | Graphics quality is fine, the frame rate does drop down quite a bit during combat, the anti-aliasing isn't as smooth for Kiana and Mei models even at "Max" graphics quality - [as shown in this gameplay video](https://youtu.be/6e-RQ2b2hoM). Combat works but a black screen appears during cutscenes, but cutscene audio still plays in the background. Dialog scenes still appear normal (It is recommended to download all resources for optimal gameplay). Cannot move the character using WASD controls but touch controls for movement/combat skills still work. | Tested under WSA with Google Play, under NVIDIA RTX 4060 Laptop GPU (Vulkan driver is D3D12, but not enabled). It's recommended to change the graphic settings after installing the game for optimal performance.
| Hop Mania (Play Games) | 2023.08.46243 | 13 | 🆖 || Requires GMS, keyboard supported
| Hungry Shark Evolution || 11 | ✅
| iDOLM@STER Million Live! Theater Days | 4.0.401 | 11 | ⚠️ | Anything 3D with a moving background is broken, but everything 2D works perfectly | ARMv7 version is unusably slow, get ARM64
| Jet Car Stunts 2 | 1.0.13 | 11 | ❌ | Loads up but orientation and menus are broken
| Jetpack Joyride | 1.52.1 (58461800) | 11 | ⚠️ | Google Play Games sync doesn't work, otherwise the game functionality is fine
| KINGDOM HEARTS Uχ Dark Road | 4.4.0 (Offline) | 11 | ✅ | GMS warnings might appear but these can be safely ignored
| King of Thieves | 2.57.1 | ✅
| Konosuba:FD | 1.12.1 | 11 | 🆖 | Requires GMS
| Last Day On Earth: Survival || 11 | 🆖 | Might require GMS
| League of Legends: Wild Rift || 11 | ✅
| LIMBO Demo | 1.20 | 11 | ✅
| Love & Deepspace | 2.02 | 13 | ❌ | Asides from requiring GMS, the app crashes with this error: `java.lang.UnsatisfiedLinkError: dlopen failed: library "libanort.so" not found` (upon checking `adb logcat`) | The app is only built for ARM64. Tested on x86_64 platform, rooted with Magisk and sideloaded installation 
| Love Live! All Stars | 3.6.0 | 12 | ⚠️ | Requires GMS, Hovers around 20-30 FPS with stuttering and slowdown on taps, requires root access and disabling SELinux. | Tested on a Ryzen 5 5600X and Nvidia RTX 3060 Ti
| Magic Tiles 3 | 8.086.201 | 11 | ✅
| MapleStory M | 1.9300.3921 | 13 | ✅ |
| Mario Kart Tour | 2.10.0 | 11 | ❌ | Fails to connect to servers after Nintendo login
| MementoMori: AFKRPG | 2.4.0 | 13 | ✅ | Rarely the game will show an error regarding connectivity issue, just restart the game and it'll work fine most of the time. If you experience black background in the battle scene, try restarting the game. | Might require GMS. Tested on i7-12700H and Laptop RTX 3060, and WSA with GMS installed.
| Minecraft (Aurora Store) | 1.17.40.06 | 11 | ❌ | Unable to verify game owner
| Minecraft (China Edition) || 11 | ✅
| Minecraft (Play Store) | 1.20.40.22 | 13, 11 | ⚠️ | Mouse and keyboard issue: The avatar doesn't look at the cursor in the main and game menus, as it should be on PC (and mouse and keyboard connected to Android device). While in the game, it does not recognize the mouse and instead the touchscreen controls will be used, but the keyboard works. Once entered into any text field (e.g. entering command in chat) and exited, the avatar now looks at the cursor again in the game and main menus; but back in the game, the camera no longer moves, and the letters, numbers and the spacebar on the keyboard no longer works, until you restart the app. Otherwise, it works with no issues.
| Minesweeper (Play Games) | 2023.08.46243 | 13 | ⚠️ | Barely playable: The game has portrait orientation but is rotated to the left, so mouse clicks don't correspond to what's displayed. Full screen makes this issue worse by cropping a portrait area on the left of what it was before full screen. | Requires GMS
| Mobile Legends | 1.6.66.7281 | 11 | ✅
| Monument Valley | 2.7.17 | 11 | ✅
| Monument Valley 2 | 2.0.3 | 11 | ✅
| Mortal Kombat X (APKPure) | 5.9.0 | 11 | ❌ | Stuck on initialization screen, message shows up saying "Download failed to start"
| Muse Dash | 3.3.0 | 11 - 6 | ❌ | Stuck on a black screen, nothing loads.
| My Little Pony World | 2022.2.0 aarch64 | 12 | ⚠️ | An authentication error warning about not being signed in with Google shows up on boot, but can be clicked past. The game is heavily graphically demanding on an x64 PC, averaging 15 FPS with an Nvidia 1050 Ti.
| My Talking Angela 2 (Play Store) | 2.2.4.21687 (ARM64_v8a) | 13 | ⚠️ | Does not resize into window, even when the "Resize" button (on the bottom right) is clicked on. Bug in Angela's tub (go to Bathroom → Tub): While grabbing the soap to massage Angela, the shower head briefly appears, then disappears in 1 second. | 
| NieR Re[in]carnation | 2.17.0 | 13, 12, 11 | 🆖 | Requires GMS to get past loading screen. If GMS is installed, terrible in-game experience, including poor performance and low FPS. | Tested on a Ryzen 9 5900X and Nvidia RTX 3080
| New Star Soccer | 4.27 | 13, 12, 11 | ✅ | Keyboard not supported
| osu!lazer | 2023.403.1 | 13 - 5 | ⚠️ | Runs with terrible performance, high latency, generally unplayable
| PAC-MAN (Play Games) | 2023.08.46243 | 13 | 🆖 || Requires GMS, keyboard supported
| PC Creator 2 - Computer Tycoon | 4.1.5 | 13 | ❌ | Mouse does not work with the tutorial, so it cannot be completed ||
| Penguin Isle | 1.59.1 | 13 - 5 | ✅ | Great performance, but UI size breaks with weird resolutions.
| Plants vs Zombies 2 | 10.9.1 | 13, 11 | ✅ | Cloud save using Google Play Games works if GMS is available
| Pojav Launcher | dahlia-209 | 12 | ✅ | Performance was great with an i7-10700K and an RTX 3060 Ti, but will probably be worse on lower hardware.
| Pokémon GO || 12, 11 | ❌ | This device, OS, or software is not compatible
| Pokémon Masters EX | 2.19.0 | 11 | ❌ | 10102 An error has occured.
| Pokémon Unite | 1.2.1.2 | 11 | ⚠️ | Battle experience is terrible
| Pou | 1.4.84 | 11 | ✅
| Prince of Persia: The Shadow and the Flame | 2.0.2 | 13, 12, 11 | ✅
| Princess Connect! Re: Dive (Korean) | 5.6.1 | 12 | ❌ | Only touch effect works after displaying the publisher logo
| Princess Connect! Re: Dive (Japanese) | 6.7.0 | 12 | ❌ | Only touch effect works after displaying the publisher logo
| Princess Connect! Re: Dive (Simplified Chinese) | 4.9.6 | 12 | ❌ | Only touch effect works after displaying "loading..."
| Princess Connect! Re: Dive (Traditional Chinese) | 2.9.0 | 11 | ⚠️ | Battle experience is terrible, cannot sync with Google Play Games
| Princess Connect! Re: Dive (Global) | 4.4.1 | 12 | ❌ | Only touch effect works after displaying the publisher logo
| Ragnarok M: Eternal Love EU | 1.0.70 | 11 | ✅
| Rayman Adventures | 3.9.95 ARMv7 | 12 | ✅ | Gameplay speed is tied to framerate, and even an Nvidia 1050 Ti occasionally gets slowdowns in the ARM version. | The game works well without major problems. The x86_64 version was discontinued after 3.9.0 and is no longer able to download game assets on first launch. Xbox Series controller works both with Bluetooth and USB, but only during levels.
| Rayman Classic | 1.0.1 | 11 | ✅
| Real Racing 3 | 10.1.0 | 12, 11 | ✅ | Only controller is supported. Map keyboard controls to a controller via [Key2Joy](https://github.com/luttje/Key2Joy), use [this](https://github.com/ios7jbpro/WSAKey2Joy/blob/main/RR3.k2j.json) pre-made config. [Demo](https://youtu.be/Bw4iAUDl2cQ).
| RFS - Real Flight Simulator | 1.6.1 | 12.1 | ⚠️ | Does not work with keyboard | Works only by connecting a controller or on PCs with touch
| Roblox | 2.499.381 | 11 | ⚠️ | Graphical anomalies | GMS warnings might appear but these can be safely ignored
| Rocket League Sideswipe | 1.0 (356721) | 11 | ❌ | OpenGL ES 3.1 is unsupported
| Sdorica | 4.5.3 | 13 | ✅ |
| Shadow Fight 2 | 2.16.0 | 11 | ⚠️ | Optionally uses GMS, doesn't support keyboard control makes fighting harder | GMS warnings might appear but these can be safely ignored, Cloud save requires GMS
| Shadow Fight 3 | 1.25.7 | 11 | ✅ | Optionally uses GMS, Cloud save using Facebook not working | Keyboard control is supported (uses the keys W, A, D, X for analog input), GMS warnings might appear but these can be safely ignored, Cloud save requires GMS
| Sky: Children of the Light | 0.15.1 | 11 | ❌ | OpenGL ES 3.1, Vulkan 1.0.3 and Vulkan level 0 missing
| Smash Hit | 1.4.3 | 11 | ✅
| Snake (Play Games) | 2023.08.46243 | 13 | ⚠️ | Full screen must be entered to correct orientation. On the other hand, sprites and assets might not be fully loaded if there's no internet connection. This might lead to anomalies such as invisible food, missing head | Requires GMS, keyboard supported
| Solitaire (Play Games) | 2023.08.46243 | 13 | 🆖 || Requires GMS, keyboard supported
| Standoff 2 | 0.16.6 | 11 | ⚠️ | Battle experience is terrible, includes micro-stutters
| Stardew Valley | 1.4.5.151 | 11 | ✅
| State of Survival | 1.13.40 | 11 | ✅
| Stickman Hook | 7.2.8 | 11 | ❌ | Game fails to initialize
| Strawberry Shortcake Dress Up Dreams | 1.4 | 12 | ❌ | An error message on startup says "Download Failed - An unexpected error occurred. (Error Code: 15)". The error log indicates that it relies on Google Services Framework. | 
| Subway Surfers | 2.24.2 | 11 | ✅ | Doesn't support keyboard control
| Suzy Cube | 1.0.12 | 12 | ❌ | Shows a black screen after the developer logo screen. The error log shows `Unity: NullReferenceException: A null value was found where an object instance was required.`
| Sword Art Online: Integral Factor| 1.9.2 | 11 | ✅ | Keyboard unsupported
| Sword Art Online: Memory Defrag | 3.0.2 | 11 | ✅ | Keyboard unsupported
| Sword Art Online: Unleash Blading | 3.2.0 | 11 | ⚠️ | Can't detect device
| Teamfight Tactics | 12.5.4259171 | 11 | ⚠️ | Crashes often before getting in game but after getting in, not many issues. Can get laggy at times but somewhat playable.
| Terraria | 1.4.3.2.2 | 11 | ✅ || Keyboard supported
| The Battle Cats | 11.2.1 | 11 | ✅
| The Battle of Polytopia | 2.0.59.5719 | 11 | ❌ | Validation error
| The King Of Fighters Allstar | 1.9.3 | 11 | ✅ | Blank screen/app crash on first boot, works on second boot upwards
| This War of Mine | 1.0 | 11 | ❌ | Infinite loop at start-up screen
| Traffic Racer | 3.5 | 13, 12, 11 | ✅ || Keyboard supported
| Toca Kitchen 2 | 2.2-play | 13 | ⚠️ | You can't access the game settings (or any swipe action) with a keyboard and mouse even with trackpad gestures | Recommended to use a touchscreen but it is also possible to play the game with just only the mouse.
| True Skate | 1.5.39 | 11 | ✅ | Minor graphical glitches
| Uma Musume: Pretty Derby (ウマ娘 プリティーダービー; JP) | 1.16.0 | 11 | ⚠️ | Doesn't work with Nvidia GeForce GTX 1660. Works with Microsoft Basic Render Driver with graphical issues. | Some features may require GMS.
| Uma Musume: Pretty Derby (ウマ娘 プリティーダービー; JP) | 1.20.0 | 12 | ❌ | Only touch effect works after displaying the developer logo
| Uma Musume: Pretty Derby (Korean) | 1.0.1 | 12 | ❌ | Only touch effect works after displaying the developer logo
| Uma Musume: Pretty Derby (賽馬娘Pretty Derby; TW/HK/MO) | 1.26.8 | 13 | ❌ | Only touch effect works after displaying the developer logo
| War Robots | 7.7.7 (134783) | 11 | ✅ | GMS warnings might appear but these can be safely ignored
| Warfare Incorporated | 1.63 | 11 | ✅ | The selection box does not work.
| Where is my Water? || 11 | ⚠️ | Many images are replaced with white rectangles
| Where is my Water? 2 || 11 | ⚠️ | Most images are replaced with white rectangles, Vignette overlay is full white and covered the whole playing area. The ground is not textured correctly.
| Where is my Water? Featuring XYY || 11 | ⚠️ | Bells are invisible
| Whirlybird (Play Games) | 2023.08.46243 | 13 | ❌ | The game cannot be controlled at all after pressing "START" | Requires GMS
| Wordament | 3.9.10260 | 11 | ✅
| Дурак Онлайн (Durak Online) | 1.9.2 | 11 | 🆖 | Requires GMS
| 白夜極光 (Alchemy Stars) | 1.2.2 | 11 | ⚠️ | Poor in-game performance
| 公主连结R (Princess Connect! Re: Dive (Simplified Chinese) | 3.4.10 | 11 | ✅
| 神魔之塔 (Tower of Saviors) | 2022.600 | 12 | ✅ | Gameplay and graphics are excellent, but the game will crash at random when downloading game data. | The first time you open it, it will have difficulty downloading game data because it will crash randomly; simply be patient and keep restarting.
| 云·原神 (Genshin Impact (Cloud app)) || 11 | ✅
| 原神（Genshin Impact）| 2.2.0 | 11 | ⚠️ | Working but heavy graphical glitches - [video](https://www.bilibili.com/video/BV1zT4y1o73D?)
| 崩坏学园2 (Honkai Gakuen 2) | 8.5 | 11 | ✅ || Game has inbox keyboard controller for WASD
| 東方LostWord (Touhou: Lost Word) | 1.16.0 | 11 | ❌
| 战双帕弥什 (Punishing: Gray Raven) || 11 | ✅ || Keyboard is supported
| プロジェクトセカイ カラフルステージ！ feat. 初音ミク (Project Sekai Colorful Stage JP) | 3.3.1.Luna | 13, 12, 11 | ⚠️ | Works well, sometimes FPS spikes when a lot of notes appear | Requires an account with progress on it to be able to skip the tutorial(on start screen click the 3 lines on the top right for account settings), if not, the game crashes or freezes on a blackscreen. Multi-Touch Display required. Starting a LIVE takes a while on slower machines.
| 世界計畫 繽紛舞台! feat. 初音未來 (Project Sekai Colorful Stage TW) | 2.3.1.10995 | 13, 12 | ❌ | App hangs when loading LIVE or crashes. Performance issues such as FPS spikes, freezing, etc. Broken textures and animations.
| Subtransit Drive | 1.0.7.2 | 11 | ❌ | Crashes at startup because Vulkan or OpenGL ES 3.1 is required