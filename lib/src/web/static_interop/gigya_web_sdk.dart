import 'dart:js_interop';

import 'package:web/web.dart' as web;

import 'account.dart';
import 'window.dart';

/// The static interop extension type for the `gigya` JavaScript object.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/417f6b5e70b21014bbc5a10ce4041860.html
@JS()
@staticInterop
extension type GigyaWebSdk(JSObject _) implements JSObject {
  /// Get the Gigya Web SDK instance from the window.
  static GigyaWebSdk get instance => GigyaWindow(web.window).gigya;

  /// Get the accounts namespace in the Gigya Web SDK.
  external Accounts get accounts;

  /// Whether the Gigya Web SDK is ready.
  external bool get isReady;
}
