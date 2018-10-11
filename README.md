# flutter_superpay

A new flutter plugin project.


## Features


## Install

Add this to your package's pubspec.yaml file:
```
dependencies:
flutter_superpay: "^0.0.1"
```

## Getting Started

* Android

* Add following permissions to your AndroidManifest.xml
```
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

```

* ios

* Add a URL scheme in info.plist

```
<key>CFBundleURLTypes</key>
<array>
<dict>
<key>CFBundleURLName</key>
<string>superpay</string>
<key>CFBundleTypeRole</key>
<string>Editor</string>
<key>CFBundleURLSchemes</key>
<array>
<string>YOUR APP SCHEME NAME</string>
</array>
</dict>
</array>
```

Make sure you have a CFBundleURLName=superpay in CFBundleURLTypes.


* In AppDelegate.m, do header import

```
#import "FlutterSuperpayPlugin.h"
```

and add following code

```
// ios 8.x or older
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
return [FlutterSuperpayPlugin handleOpenURL:url sourceApplication:sourceApplication withCompletion:nil];
}

// ios 9.0+
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options {
return [FlutterSuperpayPlugin handleOpenURL:url withCompletion:nil];
}

```

## How to use
```
import 'package:flutter_superpay/flutter_superpay.dart';
```

```
var result = await FlutterSuperpay.pay("you pay info from server", "pay channel");
```

## More
[This link](https://github.com/supaytech)
