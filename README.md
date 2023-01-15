# SAP Customer Data Cloud Plugin

[![pub package](https://img.shields.io/pub/v/gigya_flutter_plugin)](https://pub.dev/packages/gigya_flutter_plugin)
[![REUSE status](https://api.reuse.software/badge/github.com/SAP/gigya-flutter-plugin)](https://api.reuse.software/info/github.com/SAP/gigya-flutter-plugin)

A Flutter plugin for iOS and Android that integrates the Gigya native SDK's into your Flutter application.

| Android | iOS      | Web               | MacOS             | Windows           | Linux             |
|---------|----------|-------------------|-------------------|-------------------|-------------------|
| SDK 14+ | iOS 13+  | Not yet available | Not yet available | Not yet available | Not yet available |

## Features

- Login / Registration using credentials
- Login using a One-Time-Password
- Login using a Social Provider (Google, Facebook, etc.)
- Login / Registration using [FIDO](https://fidoalliance.org/)
- Single-Sign-On
- Query / Update account information
- Query / Update session information
- Adding or removing social connections
- Showing a Screen Set
- Sending custom requests using the `Send Request API`

## Installation

First, add `gigya_flutter_plugin` as a [dependency in your pubspec.yaml file](https://flutter.dev/using-packages/).

### iOS

On iOS the plugin is not automatically registered with Flutter's plugin registry,
and requires manual registration.

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

    GeneratedPluginRegistrant.register(with: self)

    // Register the Gigya Flutter Plugin after all other plugins have been registered.
    SwiftGigyaFlutterPlugin.register(accountSchema: GigyaAccount.self)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

## Initializing the SDK

### Implicit initialization

_You can skip this section if you use explicit initialization_

By default the Gigya SDK will use a configuration file defined on the native side
to initialize itself when first requested.

#### Android

Add a file called `gigyaSdkConfiguration.json` to your Android app's asset folder.

This file should contain the following keys:

```json
{
  "apiKey":"YOUR-API-KEY-HERE",
  "apiDomain": "YOUR-API-DOMAIN-HERE",
  "accountCacheTime": 1,
  "sessionVerificationInterval": 60
}
```

See also: https://sap.github.io/gigya-android-sdk/sdk-core/#implicit-initialization

#### iOS

Add the following keys to your iOS app's Info.plist file:

```xml
	<key>GigyaApiKey</key>
	<string>YOUR-API-KEY-HERE</string>
	<key>GigyaApiDomain</key>
	<string>YOUR-API-DOMAIN-HERE</string>
```

See also: https://sap.github.io/gigya-swift-sdk/GigyaSwift/#implicit-initialization

### Explicit initialization

If you want to use explicit initialization of the Gigya SDK,
call the `GigyaSdk.initSdk()` method when required.

Example:

```dart
import 'package:flutter/widgets.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const GigyaSdk sdk = GigyaSdk();

  Map<String, dynamic> initializationResult = {};

  try {
    initializationResult = await sdk.initSdk(
      apiDomain: 'your_domain',
      apiKey: 'your_api_key',
    );
  } catch(error) {
    print('Failed to initialize the Gigya SDK.');
    print(error);
  }

  runApp(MyApp(sdk: sdk, initializationResult: initializationResult));
}
```

### Using a Custom Scheme

For most cases the default `GigyaAccount` scheme (provided by the Gigya SDK) should be sufficient.

This section explains how to set up a custom scheme if the `GigyaAccount` scheme is not sufficient.

#### Android

To set up the Gigya SDK with a different scheme, subclass the [GigyaAccount](https://github.com/SAP/gigya-android-sdk/blob/main/sdk-core/src/main/java/com/gigya/android/sdk/account/models/GigyaAccount.java) class and pass your implementation to the Gigya SDK.

```kotlin
import com.gigya.android.sdk.account.models.GigyaAccount

class MyAccountScheme : GigyaAccount {
  // ...
}
```

```kotlin
import com.sap.gigya_flutter_plugin.GigyaFlutterPlugin

class MyApplication : FlutterApplication() {
  override fun onCreate() {
    super.onCreate()
    GigyaFlutterPlugin.init(this, MyAccountScheme::class.java)
  }
}
```

#### iOS

To set up the Gigya SDK with a different scheme,
implement the [GigyaAccountProtocol](https://github.com/SAP/gigya-swift-sdk/blob/main/GigyaSwift/Models/User/GigyaAccount.swift) protocol and pass your implementation to the Gigya SDK when registering the plugin in your `AppDelegate`.

```swift
import Foundation
import Gigya

struct MyAccount: GigyaAccountProtocol {
  // ...
}
```

```swift
import gigya_flutter_plugin
import Gigya

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    GeneratedPluginRegistrant.register(with: self)

    // Register the Gigya Flutter Plugin after all other plugins have been registered.
    SwiftGigyaFlutterPlugin.register(accountSchema: MyAccount.self)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

## Usage

For an example on how to use the plugin, see the [example app](https://github.com/SAP/gigya-flutter-plugin/blob/main/example/).
An in depth guide for specific API's is also provided [here](https://github.com/SAP/gigya-flutter-plugin/blob/main/USAGE_GUIDE.md).

## Setting up a Social Provider

To use the `GigyaSdk.socialLogin()` API with a specific provider,
that provider needs to be configured accordingly.

To get started with setting up a social provider, view the guide [here](https://github.com/SAP/gigya-flutter-plugin/blob/main/SOCIAL_PROVIDERS.md).

## Known Issues
None

## How to obtain support
* [Via Github issues](https://github.com/SAP/gigya-flutter-plugin/issues)
* [Via SAP standard support](https://help.sap.com/viewer/8b8d6fffe113457094a17701f63e3d6a/GIGYA/en-US/4167e8a470b21014bbc5a10ce4041860.html)

## Contributing
Via pull requests to this repository.
To get started, view the [contribution guide](https://github.com/SAP/gigya-flutter-plugin/blob/main/CONTRIBUTING.md).

## To-Do (upcoming changes)
- Web support has not yet been implemented

## Licensing
Please see our [LICENSE](https://github.com/SAP/gigya-flutter-plugin/blob/main/LICENSES/Apache-2.0.txt) for copyright and license information.