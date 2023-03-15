import 'package:js/js.dart';

import 'account.dart';

/// Get the `gigya` JavaScript object.
@JS('window.gigya')
external GigyaWebSdk get gigyaWebSdk;

/// The static interop class for the `gigya` JavaScript object.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/417f6b5e70b21014bbc5a10ce4041860.html
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
