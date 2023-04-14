import 'dart:js_interop';

import 'parameters/social_connection.dart';

/// The extension type for the `gigya.socialize` JavaScript object.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/4173357f70b21014bbc5a10ce4041860.html
@JS()
@staticInterop
extension type Socialize(JSObject _) {
  /// Add a new social connection.
  /// 
  /// This function receives a [AddSocialConnectionParameters] argument,
  /// and has [JSVoid] as return type.
  external JSFunction addConnection;

  // TODO: remove connection  
}
