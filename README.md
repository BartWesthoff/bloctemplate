# bloctemplate

New BLoC template 

1.0 search for // GOOGLE_SERVICES_VERSION
 1.1  check: https://developers.google.com/android/guides/google-services-plugin for latest version
2.0 search for // FIREBASE_BOM_VERSION
    2.1 heck: https://firebase.google.com/support/release-notes/android for latest version
3.0 search for // APP_LANGUAGE
    3.1 KTX is for kotlin and wihtout KTX is for java


4.0 fcm
    4.1 past '<intent-filter>
<action android:name="FLUTTER_NOTIFICATION_CLICK" />
<category android:name="android.intent.category.DEFAULT" />
</intent-filter>' into [YOUR_PROJECT]/android/app/src/main/AndroidManifest.xml if it's not there
    4.2 full tutorial https://medium.com/comerge/implementing-push-notifications-in-flutter-apps-aef98451e8f1



5.0 localization
   5.1 add following string to ios/runner/info.plist. Every string is a supported language.
       <key>CFBundleLocalizations</key>
       <array>
       <string>en</string>
       <string>nl</string>
       </array>

6.0 google maps
    6.1 Get an API key at https://cloud.google.com/maps-platform/.
        Enable Google Map SDK for each platform.
        Go to https://console.cloud.google.com/.
        Choose the project that you want to enable Google Maps on.
        Select the navigation menu and then select "Google Maps".
        Select "APIs" under the Google Maps menu.
        To enable Google Maps for Android, select "Maps SDK for Android" in the "Additional APIs" section, then select "ENABLE".
        To enable Google Maps for iOS, select "Maps SDK for iOS" in the "Additional APIs" section, then select "ENABLE".
        Make sure the APIs you enabled are under the "Enabled APIs" section.
        For more details, see https://developers.google.com/maps/get-started.


