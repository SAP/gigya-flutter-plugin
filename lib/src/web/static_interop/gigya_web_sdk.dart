import 'package:js/js.dart';

import 'account.dart';

/// Get the `gigya` JavaScript object.
@JS('window.gigya')
external GigyaWebSdk get gigyaWebSdk;

/// The static interop class for the `gigya` JavaScript object.
@JS()
@staticInterop
class GigyaWebSdk {}

/// This extension defines the static interop definition
/// for the [GigyaWebSdk] class.
extension GigyaWebSdkExtension on GigyaWebSdk {
  /// Get the accounts namespace in the Gigya Web SDK.
  external Accounts get accounts;

  // TODO: socialize & sso namespace
}
