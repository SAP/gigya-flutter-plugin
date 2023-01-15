# Social login

Use the `GigyaSdk.socialLogin()` interface in order to perform social login using the supported providers.
The Flutter plugin supports the same providers that are supported by the Gigya SDK:

Google, Facebook, Line, WeChat, Apple, Amazon, Linkedin, Yahoo

## Embedded social providers

Specific social providers (Facebook, Google) require additional setup. This due to the their
requirement for specific (embedded) SDKs.

An example for Facebook & Google is implemented in the example application.

### Facebook

Add [flutter_facebook_login](https://pub.dev/packages/flutter_facebook_login) to your pubspec.yaml.

Follow the core SDK documentation and instructions for setting up login with Facebook.
[Android documentation](https://sap.github.io/gigya-android-sdk/sdk-core/#facebook)
[iOS documentation](https://sap.github.io/gigya-swift-sdk/sdk-core/#facebook)

#### iOS

Register the wrapper in your *AppDelegate.swift* file:

```swift
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    SwiftGigyaFlutterPlugin.register(accountSchema: GigyaAccount.self)

    // Register social providers here. 
    Gigya.sharedInstance(GigyaAccount.self).registerSocialProvider(of: .facebook, wrapper: FacebookWrapper())

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

### Google

Add [google_sign_in](https://pub.dev/packages/google_sign_in) to your pubspec.yaml.

Follow the core SDK documentation and instructions for setting up login with Google.
[Android documentation](https://sap.github.io/gigya-android-sdk/sdk-core/#google)
[iOS documentation](https://sap.github.io/gigya-swift-sdk/GigyaSwift/#google)

#### iOS

Register the wrapper in your *AppDelegate.swift* file:

```swift
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    SwiftGigyaFlutterPlugin.register(accountSchema: GigyaAccount.self)

    // Register social providers here. 
    Gigya.sharedInstance(GigyaAccount.self).registerSocialProvider(of: .google, wrapper: GoogleWrapper())

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

### LINE

Follow the core SDK documentation and instructions for setting up login with LINE.
[Android documentation](https://sap.github.io/gigya-android-sdk/sdk-core/#line)
[iOS documentation](https://sap.github.io/gigya-swift-sdk/GigyaSwift/#line)

### WeChat

Follow the core SDK documentation and instructions for setting up login with WeChat.
[Android documentation](https://sap.github.io/gigya-android-sdk/sdk-core/#wechat)
[iOS documentation](https://sap.github.io/gigya-swift-sdk/GigyaSwift/#wechat)

