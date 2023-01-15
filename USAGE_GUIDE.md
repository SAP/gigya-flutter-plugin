# Usage Guide

This guide explains how to use several key concepts of the Gigya SDK integration.

## Sending a simple request

To send a simple request, use the `GigyaSdk.send()` method.

Example:

```dart
final GigyaSdk sdk = const GigyaSdk();

final Map<String, dynamic> parameters = {}; 

try {
  final Map<String, dynamic> result = await sdk.send('REQUEST-ENDPOINT', parameters: parameters);

  print(result);
} catch(error) {
  print(error);
}
```

## Core Business APIs

The plugin provides an interface for the following core SDK business API's:

- login
- register
- getAccount
- getSession
- isLoggedIn
- logOut
- addConnection
- removeConnection

Each of these API's largely follow the same structure as the `GigyaSdk.send()` API,
with minor behavioral differences between accepted arguments & return types.

## Screen-Sets API

The plugin supports displaying a web Screen-Set using the `GigyaSdk.showScreenSet()` API.
This API returns a `Stream<ScreensetEvent>`. The events in this stream contain a `type` and a `data` field.

Example:

```dart
import 'dart:async';

final GigyaSdk sdk = const GigyaSdk();

final Map<String, dynamic> parameters = {};

final String name = 'Default-RegistrationLogin';

StreamSubscription<ScreensetEvent>? subscription;

subscription = await sdk.showScreenSet(name, parameters: parameters).listen((event) {
  print(event.type);
  print(event.data);

  // Cancel the subscription if the screen set was cancelled.
  if(event.type == ScreenSetEventType.cancel) {
    subscription?.cancel();
    subscription = null;
  }
});
```

## Mobile SSO

The plugin supports the native SDK's "Single Sign On feature".

Documentation:

[Android](https://sap.github.io/gigya-android-sdk/sdk-core/#sso-single-sign-on)

[iOS](https://sap.github.io/gigya-swift-sdk/GigyaSwift/#sso-single-sign-on)

Please make sure to implement the necessary steps described for each platform.

Example:

```dart
final GigyaSdk sdk = const GigyaSdk();

void singleSignOn() async {
  try {
    final result = await sdk.sso();

    // See use_build_context_synchronously lint.
    if(!mounted) {
      return;
    }

    // Handle result here.
    setState(() {});
  } catch(error) {
    // Handle error here.
  }
}
```

## FIDO/WebAuthn Authentication

FIDO is a passwordless authentication method that allows password-only logins to be replaced with secure and fast login experiences across websites and apps.
Our SDK provides an interface to register a passkey, login, and revoke passkeys created using FIDO/Passkeys, backed by our WebAuthn service.

Please follow the platform implementation guides:
[Swift](https://sap.github.io/gigya-swift-sdk/GigyaSwift/#fidowebauthn-authentication)
[Android](https://sap.github.io/gigya-android-sdk/sdk-core/#fidowebauthn-authentication)

Additional setup for Android:
To support FIDO operations in your application, it is required that the *MainActivity* class of the application
extends the *FlutterFragmentActivity* class and not *FlutterActivity*.

### Logging in using a FIDO/WebAuthn passkey

```dart
final GigyaSdk sdk = const GigyaSdk();

void loginWithPasskey() async {
  try {
    final result = await sdk.webAuthenticationService.login();

    // See use_build_context_synchronously lint.
    if(!mounted) {
      return;
    }

    // Handle FIDO response.
    setState(() {});
  } catch (error) {
    if(error is GigyaError) {
      // Handle FIDO error.
      print(error.errorDetails);
    }
  }
}
```

### Register using a FIDO/WebAuthn passkey

```dart
final GigyaSdk sdk = const GigyaSdk();

void registerPasskey() async {
  try {
    final result = await sdk.webAuthenticationService.register();

    // See use_build_context_synchronously lint.
    if(!mounted) {
      return;
    }

    // Handle FIDO success.
    setState(() {});    
  } catch(error) {
    if(error is GigyaError) {
      // Handle FIDO error.
      print(error.errorDetails);
    }
  }
}
```

### Revoke an existing FIDO / WebAuthn passkey

```dart
final GigyaSdk sdk = const GigyaSdk();

void revokePasskey() async {
  try {
    final result = await sdk.webAuthenticationService.revoke();

    // See use_build_context_synchronously lint.
    if(!mounted) {
      return;
    }

    // Handle FIDO success.
    setState(() {});
  } catch(error) {
    if(error is GigyaError) {
      // Handle FIDO error.
      print(error.errorDetails);
    }
  }
}
```

### Login using a One-Time-Password that is received by a phone number

Users can now authenticate using a valid phone number.
**Note: An SMS provider configuration setup is required for the partner**

#### Usage example

Begin the phone number authentication flow by requesting a phone number from the user.

1) Request a phone number from the user, for example by using a `TextEditingController` in a form.
2) Start the One-Time-Password flow using the Gigya SDK:

```dart
final GigyaSdk sdk = const GigyaSdk();

void loginUsingOtp(String phoneNumber) async {
  try {
    final PendingOtpVerification pendingVerification = await sdk.otpService.login(phoneNumber);

    // Cache the `pendingVerification` object for step 4.
  } catch (error) {
    if(error is GigyaError) {
      // Handle OTP error.
      print(error.errorDetails);
    }
  }
}
```

3) Request the One-Time-Password code from the user, for example by using a `TextEditingController` in a form.
4) Verify the entered code using the `pendingVerification` from step 2.

```dart
void verifyOtpCode(PendingOtpVerification pendingVerification, String code) async {
  try {
    final result = await pendingVerification.verify(code);

    final Account account = Account.fromJson(result);

    // Do something with the account object.
  } catch (error) {
    if(error is GigyaError) {
      // Handle OTP error.
      print(error.errorDetails);
    }
  }
}
```

[Additional information & limitations](https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/4137e1be70b21014bbc5a10ce4041860.html?q=accounts.otp.sendCode)

## Resolving interruptions

Much like the our core SDKs, resolving interruptions is available using the plugin.

The following interruptions are currently supported:
* pendingRegistration using the `PendingRegistrationResolver` class.
* pendingVerification using the `PendingVerificationResolver` class.
* conflictingAccounts using the `LinkAccountResolver` class.

To retrieve an `InterruptionResolver`, use the `InterruptionResolverFactory` provided by the Gigya SDK.

The following sample illustrates how to handle a **conflicting accounts** interruption:

```dart
final GigyaSdk sdk = const GigyaSdk();

void loginWithConflictingAccounts(String loginId, String password) async {
  try {
    final result = await sdk.login(loginId: loginId, password: password);

    final account = Account.fromJson(result);

    // Successfully logged in.
  } catch(error) {
    if(error is GigyaError) {
      final InterruptionResolver? resolver = sdk.interruptionResolverFactory.fromErrorCode(error);

      if(resolver is LinkAccountResolver) {
        // Determine what kind of conflict it was using some user interface or other method.
        final Map<String, dynamic> resolutionArguments = determineResolutionArguments();

        final SocialProvider? socialProvider = resolutionArguments['socialProvider'] as SocialProvider?;

        if(socialProvider != null) {
          resolveLinkToSocialConflict(resolver, socialProvider);
        } else {
          final String loginId = resolutionArguments['loginId'] as String;
          final String password = resolutionArguments['password'] as String;

          resolveLinkToSiteConflict(resolver, loginId, password);
        }

        return;
      }

      // Handle other types of conflicts.
    }

    // Handle other errors.
  }
}

void resolveLinkToSiteConflict(LinkAccountResolver resolver, String loginId, String password) async {
  try {
    final result = await resolver.linkToSite(loginId: loginId, password: password);

    final Account account = Account.fromJson(result);
    // Account successfully linked.    
  } catch(error) {
    // Handle error
  }
}

void resolveLinkToSocialConflict(LinkAccountResolver resolver, SocialProvider socialProvider) async {
  try {
    final result = await resolver.linkToSocial(socialProvider);

    final Account account = Account.fromJson(result);
    // Account successfully linked.
  } catch(error) {
    // Handle error
  }
}
```
