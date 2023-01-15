# 0.3.0

Developer preview 0.3.0 - Federated Plugin Rework

* Raise minimum Flutter version to 3.3.0 and minimum Dart version to 2.18.0.
* Sort changelog according to semantic versioning.
* Remove duplicate Apache license. To view the license, see the `LICENSE` file.
* Add `publish_to: none` to example app pubspec
* Add analysis_options.yaml lint config
* Update the internal method & event channel names to use reverse domain notation & a suffix for the type of channel

Android:
* Update Gradle to 7.4
* Update Kotlin version to 1.7.21
* Update Android Gradle Plugin to 7.3.1
* Bump Android compile SDK version to 33
* Specify Java version in compile options
* Remove unused getPlatformVersion() method call
* Fix deprecation for `PackageManager.getPackageInfo()` on API 33 and higher.
* The `onHide` screen set event now includes the `reason` in its event data, rather than in an extra field.

iOS:
* Raise the minimum iOS version to 13.0
* Rename the `GigyaMethods` enum to `GigyaSdkMethods` and move it to a different file

**Breaking Changes**

* The package no longer imports `dart:io` directly.
* The publication date of a publication is now a `DateTime?` instead of a `String?`.
* The issue date of a patent is now a `DateTime?` instead of a `String?`.
* Latitude and longitude of coordinates is now required.
* company size of the Work model class is now `int?` instead of `double?`.
* end and start date of the Work model class are now `DateTime?` instead of `String?`.
* updatedAt of the OidcData model class has been changed to a `DateTime?` instead of `String?`.
* zoneinfo of the OidcData model class has been renamed to `zoneInfo`.
* The `showScreenSet()` method now returns a `Stream<ScreenSetEvent>`.
* The `expiresIn` field in `SessionInfo` is now an `int` instead of a `double`.
* The `photoURL`, `profileURL` and `thumbnailURL` of the `Profile` class have been renamed to `photoUrl`, `profileUrl` and `thumbnailUrl`.
* The `favorites` field of the `Profile` class have been changed from `List<Favorites>` to `List<Favorite>`.
* The `interestedIn` field has been removed fromn the `Profile` class. Use the `interests` field instead.
* The `followersCounts` field in the `Profile` class has been renamed to `followers` and its type has been changed to `int?`.
* The `followingCount` field in the `Profile` class has been renamed to `following` and its type has been changed to `int?`.
* The `lastLogin`, `lastUpdated` and `oldestDataUpdated` fields from the `Account` class have been removed. Use the timestamp fields instead.
* The `GigyaResponse` class has been refactored to `GigyaError`, which now implements `Exception`. The function `getErrorDetails()` has been removed.
* The `timeoutError()` function has been refactored to a class which implements `Exception`.
* `ResolverFactory` has been renamed to `InterruptionResolverFactory` and it now has a single method to create a resolver from an error code.
* Refactor `getTimeout(Methods method)` to a getter on the `Methods` enum.
* The methods in the `WebAuthnService` no longer have the `webAuthn` prefix.
* The `PendingOtpVerification` now uses a `String` for the code field in the `verify()` method. The unused response field has been removed as well.
* The platform interface has been cleaned up, and it now uses `required` parameters where possible.
* The `WebAuthnService` has been renamed to `WebAuthenticationService` and now uses an interface to abstract away the method channel.
* The `InterruptionResolver` and `OtpService` now use an interface to abstract away the method channel.

# 0.2.1

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

Developer Preview 0.1.0
Flutter 2 and Null-safety

* Android [initialization](https://github.com/SAP/gigya-flutter-plugin#android-setup) update (custom schema) 
* Migrated to Flutter 2 and Null-safety.
* Added Forgot password feature (including example application implementation).
* Added Google sign-in integration to the example application.

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
Inital release.

* Business APIs.
* Social login (View documentation for supported providers).
* Web Screen-Sets.
* Interruption handling.