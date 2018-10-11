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
* Add list file registration related classes to your AndroidManifest.xml
```
<activity-alias                                                                
    android:name="your application packageName.wxapi.WXPayEntryActivity"           
    android:exported="true"                                                    
    android:targetActivity="com.recheng.superpay.pay.wechatpay.WeChatResult" />
    
 <activity                                                                   
    android:name="com.alipay.sdk.app.H5PayActivity"                         
    android:configChanges="orientation|keyboardHidden|navigation|screenSize"
    android:exported="false"                                                
    android:screenOrientation="behind"                                      
    android:windowSoftInputMode="adjustResize|stateHidden" >                
</activity>                                                                 
<activity                                                                   
    android:name="com.alipay.sdk.app.H5AuthActivity"                        
    android:configChanges="orientation|keyboardHidden|navigation"           
    android:exported="false"                                                
    android:screenOrientation="behind"                                      
    android:windowSoftInputMode="adjustResize|stateHidden" >                
</activity>        

```
#### callBack Code errCode

- General part
```
  0; //success                                                        
  1; // network error                                   
  2; // cancel                                                   
  3; // SDK internal error                                                                                    
```
- WeChat part    
```
 -1; //Possible causes: signature error, unregistered APPID, project setting APPID incorrect, registered APPID and setting mismatch, other exceptions, etc.
 -5; //nonsupport                                                  
 -6; //WeChat not installed                                          
 -7; //No WeChat appId set     
``` 
- AliPay part   
```
 8000; //paying                                         
 4000;// Transaction failure                                             
 5000;// Repeat request                                             
 6002; //Network error                                                 
 6004; //Payment result unknown                                              
 6005; //Other errors                                                 
```           

```
#suPay Obfuscation filtering
-dontwarn com.recheng.**
-keep class com.recheng.**{*;}

#aliPay Obfuscation filtering
-dontwarn com.alipay.**
-keep class com.alipay.** {*;}

#weChat Obfuscation filtering
-dontwarn  com.tencent.**
-keep class com.tencent.** {*;}

##gson Obfuscation filtering
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes EnclosingMethod
-keep class sun.misc.Unsafe { *; }
-keep class com.google.gson.stream.** { *; }

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
