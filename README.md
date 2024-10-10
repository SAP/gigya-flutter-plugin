# Flutter plug-in for SAP Customer Data Cloud
[![REUSE status](https://api.reuse.software/badge/github.com/SAP/gigya-flutter-plugin)](https://api.reuse.software/info/github.com/SAP/gigya-flutter-plugin)


A [Flutter](https://flutter.dev) plugin for interfacing Gigya's native SDKs into a Flutter application using [Dart](https://dart.dev).

## Description
A flutter plugin that provides an interface for the Gigya API.

## Requirements
Android SDK support requires SDK 14 and above.
Requires iOS version 13+.

## Download and Installation
Add the Flutter plugin to your **pubspec.yaml** project configuration file.

## Setup & Gigya core integration

### Android setup

[Configure](https://sap.github.io/gigya-android-sdk/sdk-core/#153023-cdp-package-configuration) the basic elements needed for integrating the Android SDK.

If you need a custom scheme (**Optional**):
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

**Important**:
Make sure you have [configured](https://sap.github.io/gigya-swift-sdk/GigyaSwift/#integrating-using-swift-package-manager) your *info.plist* file accordingly.

## Sending a simple request

Sending a request is available using the Flutter plugin's **send** method.
```
GigyaSdk.instance.send('REQUEST-ENDPOINT', {PARAMETER-MAP}).then((result) {
      debugPrint(json.encode(result));
    }).catchError((error) {
      debugPrint(error.errorDetails);
    });
```
Example implementation is demonstrated in the *send_request.dart* class of the example application in the Github code repository for this project.

## Business APIs

The Flutter plugin provides an interface to these core SDK business APIs:

- login
- register
- getAccount
- getAccount
- isLoggedIn
- logOut
- addConnection
- removeConnection

Implement them using the same request structure as shown above in the **Sending a simple request** section.

The example application Github code repository for this project includes the various implementations.

## Social login

Use the **socialLogin** interface in order to perform social login using supported providers.

The Flutter plugin supports the same providers supported by the Core Gigya SDK.

Supported social login providers:

- Google
- Facebook
- Line
- WeChat
- Apple
- Amazon
- LinkedIn
- Yahoo
- Kakao

## Embedded social providers

#### Android v7 upgrade
Plugin version 1.2.0+ will depend on Android SDK core v7.
Please view the changes required to be made to yours application the Android code documentation for updating to external providers usage.

Specific social providers (currently Facebook and Google) require additional setup. This due to the their requirement for specific (embedded) SDKs.
```
Note: Examples for both Facebook & Google are implemented in the example application in the Github code repository for this project.
```

### Facebook

Follow the core SDK documentation and instructions for configuring the Facebook login:

- [Android documentation](https://sap.github.io/gigya-android-sdk/sdk-core/#facebook)
- [iOS documentation](https://sap.github.io/gigya-android-sdk/sdk-core/#facebook)

iOS: In addition, add the following to your Runner's **AppDelegate.swift** file:
```swift
Gigya.sharedInstance(UserHost.self).registerSocialProvider(of: .facebook, wrapper: FacebookWrapper())
```

### Google

Follow the core SDK documentation and instructions for setting Google login.

- [Android documentation](https://sap.github.io/gigya-android-sdk/sdk-core/#google)
- [iOS documentation](https://sap.github.io/gigya-swift-sdk/GigyaSwift/#google)

**iOS**: In addition, add the following to your Runner's **AppDelegate.swift** file:
```swift
Gigya.sharedInstance(UserHost.self).registerSocialProvider(of: .google, wrapper: GoogleWrapper())
```

### LINE

In order to provider support for LINE provider, please follow the core SDK documentation.

- [Android documentation](https://sap.github.io/gigya-android-sdk/sdk-core/#line)
- [iOS documentation](https://sap.github.io/gigya-swift-sdk/GigyaSwift/#line)

### WeChat

In order to provider support for WeChat provider, please follow the core SDK documentation.

- [Android documentation](https://sap.github.io/gigya-android-sdk/sdk-core/#wechat)
- [iOS documentation](https://sap.github.io/gigya-swift-sdk/GigyaSwift/#wechat)


## Using screen-sets

The plugin supports the use of Web screen-sets using the following:
```
GigyaSdk.instance.showScreenSet("Default-RegistrationLogin", (event, map) {
          debugPrint('Screen set event received: $event');
          debugPrint('Screen set event data received: $map');
});
```
An optional {parameters} map is available in the GigyaSdk.instance.showScreenSet interface, enabling you to add parameters in the function interface.

As with the core SDKs, the Flutter plugin provides a streaming channel that will stream the Screen-Sets event name and event data map. The payload will contain:

- event - actual event name.
- map - event data map.

## Biometric support

The plugin provides Android/iOS biometric support for these flows.

```
An end user logs in.
An end user decides to use biometric authentication.
This requires the end user to verify their fingerprint.
The app is locked or deleted from memory.
The end user needs to unlock the app to restore his session.
In this case, the end user needs to verify his fingerprint.
The end user decides not to use biometric authentication.
```
The biometric fingerprint feature is a security cipher that is placed on top of an existing session of your app, so invoking biometric operations requires a valid session.

Please make sure you are using native implementations:

## iOS
1. The device has a passcode.
2. The device has TouchID/FaceID.

**FaceID
To use FaceID in a compatible device, you must include the following key in your Info.plist file:

**NSFaceIDUsageDescription = (String) "Your own message "**.
If you also want to set a custom text in the Touch ID prompt, you can include the following key:

**GigyaTouchIDMessage = (String) "Your custom message" (Default = "Please authenticate to continue").**

## Android

1. The device has a fingerprint sensor.
2. At least 1 fingerprint is already registered on the device.
3. Appropriate permissions are already requested in the library manifest: android.permission.USE _FINGERPRINT android.permission. USE _BIOMETRIC.

**Declaring the prompt display**
Android’s biometric authentication uses a prompt display. You can customize the text displayed by declaring your own ***BiometricPromptInfo*** object.

In your application class (after launching the SDK), you can add the following:
```dart
await widget.sdk.biometricService.optIn(
  parameters: <String, String>{
    'title': 'SampleTitle',
    'subtitle': 'SampleSubtitle',
    'description': 'SampleDescription',
  },
);

```

If no prompt info is specified, the prompt window uses default English texts:
```
<string name="bio_prompt_default_title">Biometric verification</string>
<string name="bio_prompt_default_subtitle">Confirm fingerprint to continue</string>
<string name="bio_prompt_default_description">""</string>
```

**Note:**
The biometric service parameter map is only relevant for Android applications.


## Mobile SSO

The Flutter plugin supports the native SDK's "Single Sign On feature".

Documentation:

- [Android](https://sap.github.io/gigya-android-sdk/sdk-core/#sso-single-sign-on)
- [iOS](https://sap.github.io/gigya-swift-sdk/GigyaSwift/#sso-single-sign-on)

```
Note: Implement the necessary steps described for each platform before initiating the SSO request.
```
To initiate the SSO request flow, run the following snippet.
```
 GigyaSdk.instance.sso().then((result) {
 // Handle result here.
 setState(() { });
 }).catchError((error) {
// Handle error here.
 });
```

**Note:**
When using mobile SSO (single sign-on using the central login page), logging out using the SDK's logout method will only log the user out of the current API key used.
The user will not be logged out of the other group sites.

## Session Exchange Between Mobile & WebView

Applications (mobile/web) within the same site group are now able to share a session from the mobile application to a web page running the JS SDK.

Follow these steps to allow session exchange:

1. Use the “getAuthCode” interface. This call will provide you with the required code that the web page will require for the exchange.
```dart
final String? result = await widget.sdk.getAuthCode();
```

2. Add these URL parameters to your hosted page/website URL using the provided code:
   *** https://page-url?authCode=code&gig_actions=sso.login ***

3. Make sure that the WebView element you are using to open the URL has JavaScript enabled.

4. Once the page is loaded, the JS SDK will exchange the token provided for a valid session.


## FIDO/WebAuthn Authentication
FIDO is a passwordless authentication method that allows password-only logins to be replaced with secure and fast login experiences across websites and apps.

Our SDK provides an interface to register a passkey, login, and revoke passkeys created using FIDO/Passkeys, backed by our WebAuthn service.

Please follow the platform implementation guides:

- [Swift](https://sap.github.io/gigya-swift-sdk/GigyaSwift/#fidowebauthn-authentication)
- [Android](https://sap.github.io/gigya-android-sdk/sdk-core/#fidowebauthn-authentication)

Additional setup for Android:
To support FIDO operations in your application, it is required that the *MainActivity* class of the application
extends the *FlutterFragmentActivity* class and not *FlutterActivity* class.

**Usage example**
Login with FIDO/WebAuthn passkey:
```
_loginWithPasskey() async {
    try {
      GigyaSdk.instance.webAuthn.webAuthnLogin().then((result) {
        setState(() {});
      });
    } catch (error) {
      if (error is GigyaResponse) {
        showAlert("FidoError", error.errorDetails);
      }
    }
  }
```
Register a new FIDO/WebAuthn passkey:
```
_registerPasskey() async {
    try {
      var result = await GigyaSdk.instance.webAuthn.webAuthnRegister();
      debugPrint(jsonEncode(result));
      showAlert("FIDO success", "passkey registered");
    } catch (error) {
      if (error is GigyaResponse) {
        showAlert("FIDO error", error.errorDetails);
      }
    }

  }
```
Revoke an existing FIDO/WebAuthn passkey:
```
 _revokePasskey() async {
    try {
      var result = await GigyaSdk.instance.webAuthn.webAuthnRevoke();
      debugPrint(jsonEncode(result));
      showAlert("FIDO success", "passkey revoked");
    } catch (error) {
      if (error is GigyaResponse) {
        showAlert("FIDO", error.errorDetails);
      }
    }
  }
```

## Login using phone number (OTP)
Users can now authenticate using a valid phone number.
```
Note: An SMS provider configuration setup is required for the partner.
```
**Usage example**

1. Begin the phone authentication flow by providing the phone number:
```
GigyaSdk.instance.otp.login(phone).then((resolver) {
      // Code is sent. A resolver object is available for code verification
    }).catchError((error) {
      // Handle error here.
    });
```
2. Verify the SMS code using the "resolver" object obtained in the previous step.
```
resolver.verify(code).then((res) {
    // Parse account information.
    final Account account = Account.fromJson(res);
    }).catchError((error) {
    // Handle error here.
    });
```

Please read about [Additional information & limitations](https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/4137e1be70b21014bbc5a10ce4041860.html?q=accounts.otp.sendCode) on OTP with the Flutter plugin.

## Resolving interruptions

Much like the our core SDKs, resolving interruptions is available using the Flutter plugin.

We currently support the following interruptions:
* pendingRegistration using the *PendingRegistrationResolver* class.
* pendingVerification using the *PendingVerificationResolver* class.
* conflictingAccounts using the *LinkAccountResolver* class.

For example, to resolve **conflictingAccounts** interruptions, use the following code:
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
Once you reference your resolver object obtained in your interruption code, create your application UI to determine if a site or social linking is
required (for details see the example application in this Github project repository) and use the required "resolve" method.

Example of resolving link to site when trying to link a new social account to a site account:
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
