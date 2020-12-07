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

## Sending a simple request

Sending a request is available using the plugin **send** method.
```
GigyaSdk.instance.send('REQUEST-ENDPOINT', {PARAMETER-MAP}).then((result) {
      debugPrint(json.encode(result));
    }).catchError((error) {
      debugPrint(error.errorDetails);
    });
```
Example implementation is demostrated in the *send_request.dart* class of the provided example applicaiton.

## Business APIs

The plugin provides API to varius business APIs which iclude:
**login, register, getAccount, getAccount, isLoggedIn ,logOut, addConnection, removeConnection**
Implement them using the same request structure as shown above. 
Example application includes the varius implementations.

## Social login

Use the "socialLogin" interface in order to perform social login using supported providers.
The Flutter plugin supports the same *providers supported by the Core Gigya SDK.

Supported social login providers:
google, facebook, line, wechat, apple, amazon, linkedin, yahoo.

## Embeded socail providers

Specific social providers (Facebook, Google) require addional setup. This due to the their
requirement for specific (embedded) SDKs.
```
Example for both Facebook & Google are implemented in the example application.
```

### Facebook

Follow the core SDK documentation and instructions for setting Facbook login.
[Android documentation](https://sap.github.io/gigya-android-sdk/sdk-core/#facebook)
[iOS documentation](https://sap.github.io/gigya-android-sdk/sdk-core/#facebook)

iOS: In additon add the following to your Runner's *AppDelegate.swift* file:
```swift
Gigya.sharedInstance(UserHost.self).registerSocialProvider(of: .facebook, wrapper: FacebookWrapper())
```

```
Instead of adding the provider's sdk using gradle/cocoapods you are able to add
the [flutter_facebook_login] plugin to your **pubspec.yaml** dependencies.
```

### Google

Follow the core SDK documentation and instructions for setting Facbook login.
[Android documentation](https://sap.github.io/gigya-android-sdk/sdk-core/#google)
[iOS documentation](https://sap.github.io/gigya-swift-sdk/GigyaSwift/#google)

iOS: In additon add the following to your Runner's *AppDelegate.swift* file:
```swift
Gigya.sharedInstance(UserHost.self).registerSocialProvider(of: .google, wrapper: GoogleWrapper())
```

```
Instead of adding the provider's sdk using gradle/cocoapods you are able to add
the [google_sign_in] plugin to your **pubspec.yaml** dependencies.
```

### LINE

In order to provider support for LINE provider, please follow the core SDK documentation.
[Android documentation](https://sap.github.io/gigya-android-sdk/sdk-core/#line)
[iOS documentation](https://sap.github.io/gigya-swift-sdk/GigyaSwift/#line)

### WeChat

In order to provider support for WeChat provider, please follow the core SDK documentation.
[Android documentation](https://sap.github.io/gigya-android-sdk/sdk-core/#wechat)
[iOS documentation](https://sap.github.io/gigya-swift-sdk/GigyaSwift/#wechat)


## Using screen-sets

The plugin supports the use of Web screen-sets using the following:
```
GigyaSdk.instance.showScreenSet("Default-RegistrationLogin", (event, map) {
          debugPrint('Screen set event received: $event');
          debugPrint('Screen set event data received: $map');
});
```
Optional {parameters} map is available.

As in the core SDKs the plugin provides a streaming channel that will stream the
Screen-Sets events (event, map).

event - actual event name.
map - event data map.

## Known Issues
None

## How to obtain support
* Via Github issues
* [Via SAP standard support](https://developers.gigya.com/display/GD/Opening+A+Support+Incident)

## Contributing
Via pull request to this repository.

## To-Do (upcoming changes)
None
