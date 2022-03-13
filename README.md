# bloctemplate

New BLoC template 


1. localization
   1.1 add following string to ios/runner/info.plist. Every string is a supported language.
       <key>CFBundleLocalizations</key>
       <array>
       <string>en</string>
       <string>nl</string>
       </array>
   
2.
3.0 google maps
    3.1 Get an API key at https://cloud.google.com/maps-platform/.
        Enable Google Map SDK for each platform.
        Go to https://console.cloud.google.com/.
        Choose the project that you want to enable Google Maps on.
        Select the navigation menu and then select "Google Maps".
        Select "APIs" under the Google Maps menu.
        To enable Google Maps for Android, select "Maps SDK for Android" in the "Additional APIs" section, then select "ENABLE".
        To enable Google Maps for iOS, select "Maps SDK for iOS" in the "Additional APIs" section, then select "ENABLE".
        Make sure the APIs you enabled are under the "Enabled APIs" section.
        For more details, see https://developers.google.com/maps/get-started.


