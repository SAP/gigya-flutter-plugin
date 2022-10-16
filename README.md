# Flutter plug-in for SAP Customer Data Cloud
[![REUSE status](https://api.reuse.software/badge/github.com/SAP/gigya-flutter-plugin)](https://api.reuse.software/info/github.com/SAP/gigya-flutter-plugin)


A [Flutter](https://flutter.dev) plugin for interfacing Gigya's native SDKs into a Flutter application using [Dart](https://dart.dev).

## Description
Flutter plugin that provides an interface for the Gigya API.

## Developers Preview Status
The plugin allows you to use the core elements & business API flows available within the SAP Customer Data Cloud mobile SDKs.
This plugin is currently in an early developers preview stage.

## Requirements
Android SDK support requires SDK 14 and above.

## Download and Installation
Add the plugin in your **pubspec.yaml** fie.

## Setup & Gigya core integration

### Android setup

Important:
Make sure you have [configured](https://developers.gigya.com/display/GD/Android+SDK+v4#AndroidSDKv4-ViaJSONconfigurationfile:)
the basic steps needed for integrating the Android SDK

If you need custom scheme(**Optional**):
```
class MyApplication : FlutterApplication() {

    override fun onCreate() {
        super.onCreate()
        GigyaFlutterPlugin.init(this, GigyaAccount::class.java)
    }
}
```

### iOS setup

Navigate to **\<your project root\>/ios/Runner/AppDelegate.swift** and add the following:

```swift
import gigya_flutter_plugin
import Gigya

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

Important:
Make sure you have [configured](https://developers.gigya.com/display/GD/Swift+SDK#SwiftSDK-ImplicitInitialization) your *info.plist* file accordinglty.

## Sending a simple request

Sending a request is available using the plugin **send** method.
```
GigyaSdk.instance.send('REQUEST-ENDPOINT', {PARAMETER-MAP}).then((result) {
      debugPrint(json.encode(result));
    }).catchError((error) {
      debugPrint(error.errorDetails);
    });
```
Example implementation is demonstrated in the *send_request.dart* class of the provided example application.

## Business APIs

The plugin provides an interface to these core SDK business APIs:
**login, register, getAccount, getAccount, isLoggedIn ,logOut, addConnection, removeConnection**
Implement them using the same request structure as shown above. 
Example application includes the various implementations.

## Social login

Use the "socialLogin" interface in order to perform social login using supported providers.
The Flutter plugin supports the same *providers supported by the Core Gigya SDK.

Supported social login providers:
google, facebook, line, wechat, apple, amazon, linkedin, yahoo.

## Embedded social providers

Specific social providers (Facebook, Google) require additional setup. This due to the their
requirement for specific (embedded) SDKs.
```
Example for both Facebook & Google are implemented in the example application.
```

### Facebook

Follow the core SDK documentation and instructions for setting Facebook login.
[Android documentation](https://sap.github.io/gigya-android-sdk/sdk-core/#facebook)
[iOS documentation](https://sap.github.io/gigya-android-sdk/sdk-core/#facebook)

iOS: In addition add the following to your Runner's *AppDelegate.swift* file:
```swift
Gigya.sharedInstance(UserHost.self).registerSocialProvider(of: .facebook, wrapper: FacebookWrapper())
```

```
Instead of adding the provider's sdk using gradle/cocoapods you are able to add
the [flutter_facebook_login] plugin to your **pubspec.yaml** dependencies.
```

### Google

Follow the core SDK documentation and instructions for setting Google login.
[Android documentation](https://sap.github.io/gigya-android-sdk/sdk-core/#google)
[iOS documentation](https://sap.github.io/gigya-swift-sdk/GigyaSwift/#google)

iOS: In addition add the following to your Runner's *AppDelegate.swift* file:
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

## Mobile SSO

The plugin supports the native SDK's "Single Sign On feature".

Documentation:

[Andorid](https://sap.github.io/gigya-android-sdk/sdk-core/#sso-single-sign-on)

[iOS](https://sap.github.io/gigya-swift-sdk/GigyaSwift/#sso-single-sign-on)

Please make sure to implement the nessesary steps described for each platform.

To initiate the flow run the following snippet.
```
 GigyaSdk.instance.sso().then((result) {
 // Handle result here.
 setState(() { });
 }).catchError((error) {
// Handle error here.
 });
```

## Resolving interruptions

Much like the our core SDKs, resolving interruptions is available using the plugin.

Current supporting interruptions:
* pendingRegistration using the *PendingRegistrationResolver* class.
* pendingVerification using the *PendingVerificationResolver* class.
* conflictingAccounts using the *LinkAccountResolver* class.

Example for resolving **conflictingAccounts** interruptions:
```
GigyaSdk.instance.login(loginId, password).then((result) {
      debugPrint(json.encode(result));
      final response = Account.fromJson(result);
      // Successfully logged in
    }).catchError((error) {
      // Interruption may have occurred.
      if (error.getInterruption() == Interruption.conflictingAccounts) {
        // Reference the correct resolver
        LinkAccountResolver resolver = GigyaSdk.instance.resolverFactory.getResolver(error);
      } else {
        setState(() {
          _inProgress = false;
          _requestResult = 'Register error\n\n${error.errorDetails}';
        });
      }
    });
```
Once you reference your resolver, create your relevant UI to determine if a site or social linking is
required (see example app for details) and use the relevant "resolve" method.

Example of resolving link to site when trying to link a new social account to a site account.
```
final String password = _linkPasswordController.text.trim();
resolver.linkToSite(loginId, password).then((res) {
     final Account account = Account.fromJson(res);
     // Account successfully linked.
});
```

## Known Issues
None

## How to obtain support
* [Via Github issues](https://github.com/SAP/gigya-flutter-plugin/issues)
* [Via SAP standard support](https://help.sap.com/viewer/8b8d6fffe113457094a17701f63e3d6a/GIGYA/en-US/4167e8a470b21014bbc5a10ce4041860.html)

## Contributing
Via pull request to this repository.
Please read CONTRIBUTING file for guidelines.

## To-Do (upcoming changes)
None

## Licensing
Please see our [LICENSE](https://github.com/SAP/gigya-flutter-plugin/blob/main/LICENSES/Apache-2.0.txt) for copyright and license information.

