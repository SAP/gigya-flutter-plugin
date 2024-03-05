import 'dart:js_interop';

import 'parameters/basic.dart';

/// This extension type represents the session namespace.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/7fc882712f2e4011982171ea612466ca.html
@JS()
extension type Session._(JSObject _) {
  /// Verify the current session.
  ///
  /// This function receives a [BasicParameters] instance as argument,
  /// and has [JSVoid] as return type.
  external JSFunction verify;
}
