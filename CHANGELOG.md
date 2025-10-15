# 1.0.12
1.0.12
* Fix: Android SDK Wrapper nullable "reason" in screen-set onHide callback.

# 1.0.11
1.0.11

* Updated Android core SDK to 7.2.0 - https://github.com/SAP/gigya-android-sdk/releases/tag/core-v7.2.0
* Updated Swift core SDK to 1.7.6 - https://github.com/SAP/gigya-swift-sdk/releases/tag/1.7.6
* Added support for Android passkeys usage with Credentials Manager (iOS acts as a passthrough)

# 1.0.10
1.0.10

* Android Gradle update (deprecated imperative apply plugin method).
* Android dependencies source update(Maven Central).
* iOS updated core SDK to 1.7.5.


# 1.0.9
1.0.9

* Fixed iOS missing callback assignment `loginWithCredentials` flow.

# 1.0.8
1.0.8

* Updated Android core 7.1.3 - https://github.com/SAP/gigya-android-sdk/releases/tag/core-v7.1.3
* Updated Swift Core 1.7.1 - https://github.com/SAP/gigya-swift-sdk/releases/tag/core%2Fv1.7.1
* Fixed interruption flows causing channel result error.

# 1.0.7
1.0.7

* Updated Android core 7.1.0 - https://github.com/SAP/gigya-android-sdk/releases/tag/core-v7.1.0
* Updated Swift Core 1.7.0 - https://github.com/SAP/gigya-swift-sdk/releases/tag/core%2Fv1.7.0
* Please read each platform requirement changes for supporting social sign in.

# 1.0.6
1.0.6

* Added "getAuthCode" interface used to obtain a session exchange code with WebSDK.

# 1.0.5
1.0.5

* Updated Podspec file to apply minimum SDK 1.0.6 (privacy manifest support).
* Updated Android core gradle implementation.

# 1.0.4
1.0.4

* Removed timeout for SSO channel call.
* Fixed Android "rp_context" parameters not passing correctly to native platform.

# 1.0.3
1.0.3

* Update Android core SDK.
* Added support for biometric session lock.

# 1.0.2
1.0.2

* Updated plugin to support Android core version 7+
* Conformed to Android v7 external social providers implementation.
* Added support for Kakao social providers.
* Added missing support for cname in Android (due to Android core v7).
* Added option to hide screenset programmatically via "dismissScreenSet" interface.
* Fixed nullable "apiVersion" bug on Android wrapper.
* Introduced Android proguard file.

# 1.0.1
1.0.1

* Fixed session not retaining after SdkInit.
* Fix GigyaError with null values.
* Fix ClassCastException with setSession() - Android.

# 1.0.0
1.0.0 - Federated Plugin Rework

* Raised the minimum Flutter version to 3.3.0 and minimum Dart version to 2.18.0.
* Removed the duplicate Apache license. To view the license, see the ‘LICENSE’ file.
* Added ‘publish_to: none’ to the example app pubspec.
* Added the analysis_options.yaml lint config.
* Updated the internal method & event channel names to use reverse domain notation and a suffix for the type of channel.
* Fixed the ‘logout()’ method so that it no longer fails if the user is not logged in.

Android:
* Updated Gradle to 7.4
* Updated the Kotlin version to 1.7.21
* Updated the Android Gradle Plugin to 7.3.1
* Bumped the Android compile SDK version to 33
* Specified the Java version in the compile options
* Removed the unused ‘getPlatformVersion()’ method call
* Removed the usage of the deprecated ‘PackageManager.getPackageInfo()’ on API 33 and higher
* The ‘onHide’ screen set event now includes the ‘reason’ in its event data, rather than in a separate field.

iOS:
* Raised the minimum iOS version to 13.0
* Renamed the ‘GigyaMethods’ enum to ‘GigyaSdkMethods’

**Breaking Changes**
* The package no longer imports ‘dart:io’ directly.
* The publication date of a publication is now a ‘DateTime?’ instead of a ‘String?’.
* The issue date of a patent is now a ‘DateTime?’ instead of a ‘String?’.
* Latitude and longitude of coordinates is now required in the location schema object.
* Company size of the ‘Work’ model class is now ‘int?’ instead of ‘double?’.
* Start and End date of the ‘Work’ model class are now ‘DateTime?’ instead of ‘String?’.
* ‘updatedAt’ of the ‘OidcData’ model class has been changed to a ‘DateTime?’ instead of a ‘String?’.
* ‘zoneinfo’ of the ‘OidcData’ model class has been renamed to ‘zoneInfo’.
* The ‘initSdk()’ method now returns a ‘Future<void>’, instead of a ‘Future<Map<String, dynamic>>’ with a ‘{success: true}’ value.
* The ‘showScreenSet()’ method now returns a ‘Stream<ScreenSetEvent>’.
* The ‘expiresIn’ field in ‘SessionInfo’ is now an ‘int’ instead of a ‘double’.
* The ‘photoURL’, ‘profileURL’ and ‘thumbnailURL’ model properties of the ‘Profile’ class have been renamed to ‘photoUrl’, ‘profileUrl’ and ‘thumbnailUrl’.
* The ‘favorites’ field of the ‘Profile’ class has been changed from ‘List<Favorites>‘ to ‘List<Favorite>‘.
* The ‘interestedIn’ field in the ‘Profile’ class has been replaced with the ‘interests’ field.
* The ‘followersCounts’ field in the ‘Profile’ class has been renamed to ‘followers’, and its type has been changed to ‘int?’.
* The ‘followingCount’ field in the ‘Profile’ class has been renamed to ‘following’ and its type has been changed to ‘int?’.
* The ‘lastLogin’, ‘lastUpdated’ and ‘oldestDataUpdated’ fields from the ‘Account’ class have been removed. Use the timestamp fields instead.
* The ‘GigyaResponse’ class has been refactored to ‘GigyaError’, which now implements the ‘Exception’ class. The function ‘getErrorDetails()’ has been removed.
* The ‘timeoutError()’ function has been refactored to a new ‘GigyaTimeoutError’ class that implements ‘Exception’.
* ‘ResolverFactory’ has been renamed to ‘InterruptionResolverFactory’, and it now has a single method to create a resolver from an error code.
* Refactored the ‘getTimeout(Methods method)’ to a getter method on the ‘Methods’ enum.
* The methods in the ‘WebAuthnService’ class no longer have the ‘webAuthn’ prefix.
* The ‘PendingOtpVerification’ class now uses a ‘String’ for the ‘code’ field in the ‘verify()’ method. The unused ‘response’ field has been removed as well.
* The platform interface has been cleaned up, and it now uses ‘required’ parameters when needed.
* The ‘WebAuthnService’ has been renamed to ‘WebAuthenticationService’, and now uses an interface to abstract away the method channel.
* The ‘InterruptionResolver’ and ‘OtpService’ classes now use an interface to abstract away the method channel.

# 0.2.2

Developer Preview 0.2.2

Updated Android Core SDK v6.2.1.
Updated Swift Core SDK v1.5.1.

# 0.2.1

Developer Preview 0.2.1

* Added support for phone number authentication (OTP).

# 0.2.0

Developer Preview 0.2.0

* Updated Android Core SDK v6.1.0 containing various security updates.
* Bug fix - Fixed account schema parsing.
* Added getSession method.
* Added support for FIDO authentication.

# 0.1.7

Developer Preview 0.1.7

* Updated Android Core SDK v5.2.0 containing various security updates.

# 0.1.6

Developer Preview 0.1.6

* Bug fix - Android setSession. Wrong SessionInfo propagation.

# 0.1.5
Developer Preview 0.1.5

* Added mobile SSO support using CLP.

# 0.1.4
Developer Preview 0.1.4

* Updated Android Core SDK v5.1.6
* Added setSession interface.
* Android [initialization](https://github.com/SAP/gigya-flutter-plugin#android-setup) update (custom schema)
* Migrated to Flutter 2 and Null-safety.
* Added Forgot password feature (including example application implementation).
* Added Google sign-in integration to the example application.

# 0.1.3
Developer Preview 0.1.3

* iOS: Fixed crash in forgotPassword.
* iOS: Fixed bug in link account.

# 0.1.2
Developer Preview 0.1.2

* Updated Android Core SDK v5.1.4
* Forgot password bug fix.
* Added manual initSDK interface.

# 0.1.1
Android core SDK update.

* Updated Android Core SDK v5.1.3

# 0.1.0

# 0.0.6
Account Model Patch

* Fix to main account model (sessionInfo type).

# 0.0.5
Core SDKS update

* Updated Android SDK 5.1.1 (security).

# 0.0.4
Core SDKS updates

* Updated Swift SDK 1.2.0.
* Updated Android SDK 5.1.0.

# 0.0.3
Platform alignments

* Fixed Android error not mapped correctly.
* Added dynamic "mapped" field to base GigyaResponse.

# 0.0.2
Example & documentation.

* Example application updates.
* Documentation updates.

# 0.0.1
Initial release.

* Business APIs.
* Social login (View documentation for supported providers).
* Web Screen-Sets.
* Interruption handling.
