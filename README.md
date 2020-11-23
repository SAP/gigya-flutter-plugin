# SAP CDC Gigya Flutter Plugin

A [Flutter](https://flutter.dev) plugin for interfacing Gigya's native SDKs into a Flutter application using [Dart](https://dart.dev).

## Description
Flutter plugin that provides an interface for the Gigya API.

## Developers Preview Status
The plugin allows you to use the core elements & business API's flows available within the mobile SDKs.
Session encryption & management is handled in each platform. This plugin is currently in an early **developers preview** stage.

## Setup & Gigya core integration

### Android setup

Please add the following to your native implementation.

```kotlin
class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        // Copy this code to you Android app.
        //
        // Reference the plugin and register your SDK initialization parameters.
        val plugin: GigyaFlutterPlugin= flutterEngine.plugins.get(GigyaFlutterPlugin::class.java) as GigyaFlutterPlugin
        plugin.registerWith(application, GigyaAccount::class.java)
    }
}
```

```
Important:
Make sure you have [configured](https://developers.gigya.com/display/GD/Android+SDK+v4#AndroidSDKv4-ViaJSONconfigurationfile:)
 the basic steps needed for integrating the Android SDK
```

### iOS setup

Navigate to **\<your project root\>/ios/Runner/AppDelegate.swift** and add the following:

```swift
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // Copy this code to you Android app.
    //
    GeneratedPluginRegistrant.register(with: self)
    SwiftGigyaFlutterPlugin.register(accountSchema: UserHost.self)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

```
Important:
Make sure you have [configured](https://developers.gigya.com/display/GD/Swift+SDK#SwiftSDK-ImplicitInitialization) your *info.plist* file accordinglty.
```

### Sending a simple request

Sending a request is available using the plugin **send** method.
```
GigyaSdk.instance.send('REQUEST-ENDPOINT', {PARAMETER-MAP}).then((result) {
      debugPrint(json.encode(result));
    }).catchError((error) {
      debugPrint(error.errorDetails);
    });
```
Example implementation is demostrated in the *send_request.dart* class of the provided example applicaiton.

### Business APIs

The plugin provides API to varius business APIs which iclude:
**login, register, getAccount, setAccount, isLoggedIn, logOut etc.**
Implement them using the same request structure as shown above. 
Example application includes the varius implementations.

### Social login


### Using screen-sets



## Known Issues
None

## How to obtain support
Via SAP standard support.
https://developers.gigya.com/display/GD/Opening+A+Support+Incident

## Contributing
Via pull request to this repository.

## To-Do (upcoming changes)
None
