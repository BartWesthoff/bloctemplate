import json
import subprocess
import webbrowser




command="keytool -list -v -alias androiddebugkey -keystore %USERPROFILE%/.android/debug.keystore"
print("type 'android'")
def run_win_cmd(cmd):
    result = []
    process = subprocess.Popen(cmd,
                               shell=True,
                               stdout=subprocess.PIPE,
                               stderr=subprocess.PIPE)
    for line in process.stdout:
        result.append(line)
    errcode = process.returncode
    for i, line in enumerate(result):
        # print(i, line)
        line = line.decode('utf-8')
        if 'SHA256:' in line or 'SHA1:' in line:
            print(line.strip())
    if errcode is not None:
        raise Exception('cmd %s failed, see above for details', cmd)

run_win_cmd(command)
google_services_version = ""
with open('android/app/build.gradle', 'w+') as build:
    with open('settings.json', 'r') as f:
        settings = json.load(f)
    google_services_version = settings['google-services']
    firebase_version = settings['firebase-bom']
    appname = settings['packagename'].lower()
    is_java = settings['language'] == 'java'

    value = """def localProperties = new Properties()
def localPropertiesFile = rootProject.file('local.properties')
if (localPropertiesFile.exists()) {
    localPropertiesFile.withReader('UTF-8') { reader ->
        localProperties.load(reader)
    }
}

def flutterRoot = localProperties.getProperty('flutter.sdk')
if (flutterRoot == null) {
    throw new GradleException("Flutter SDK not found. Define location with flutter.sdk in the local.properties file.")
}

def flutterVersionCode = localProperties.getProperty('flutter.versionCode')
if (flutterVersionCode == null) {
    flutterVersionCode = '1'
}

def flutterVersionName = localProperties.getProperty('flutter.versionName')
if (flutterVersionName == null) {
    flutterVersionName = '1.0'
}

apply plugin: 'com.android.application'
apply plugin: 'kotlin-android'
apply plugin: 'com.google.gms.google-services'
apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"

android {
    compileSdkVersion 31

    sourceSets {
        main.java.srcDirs += 'src/main/kotlin'
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId """ + f'"{appname}"' + """
        minSdkVersion 23
        targetSdkVersion 31
        multiDexEnabled true
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig signingConfigs.debug
        }
    }
}

flutter {
    source '../..'
}

dependencies {
    implementation "androidx.multidex:multidex:2.0.1"
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
    implementation platform(""" + f"'com.google.firebase:firebase-bom:{firebase_version}'" + """)
    implementation 'com.google.firebase:firebase-analytics-ktx'
    implementation 'com.google.firebase:firebase-firestore-ktx'
    implementation 'com.google.firebase:firebase-auth-ktx'
    implementation 'com.google.firebase:firebase-dynamic-links'   
}

    """

    if is_java:
        value = value.replace('-ktx', '')
    # print(value)
    build.write(value)
    # print(settings)
with open('android/build.gradle', 'w+') as f:
    value = """buildscript {
    ext.kotlin_version = '1.4.32'
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:4.1.0'
        classpath 'com.google.gms:google-services:""" + f"{google_services_version}" + """'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:1.5.10"
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.buildDir = '../build'
subprojects {
    project.buildDir = "${rootProject.buildDir}/${project.name}"
    project.evaluationDependsOn(':app')
}

task clean(type: Delete) {
    delete rootProject.buildDir
}
    
    
    """
    f.write(value)







webbrowser.open('https://console.firebase.google.com/u/0/')  # Go to example.com


