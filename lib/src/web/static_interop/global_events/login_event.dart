import 'dart:js_interop';

import '../models/profile.dart';

/// The extension type for the global login event emitted by the Gigya SDK.
///
/// See: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/41532ab870b21014bbc5a10ce4041860.html#onlogin-event-data
@JS()
@anonymous
@staticInterop
extension type LoginEvent(JSObject _) {
  /// The type of login, which is either 'standard' or 'reAuth'.
  external String get loginMode;

  /// The name of the provider that the user used in order to login.
  external String get provider;

  /// The GMT time of the response in UNIX time format.
  /// This timestamp should be used for login verification.
  external String get signatureTimestamp;

  /// A [Profile] object with updated information for the current user.
  external Profile get user;

  /// The User ID that should be used for login verification.
  external String get UID; // ignore: non_constant_identifier_names

  /// The signature that should be used for login verification.
  external String get UIDSignature; // ignore: non_constant_identifier_names

  /// Convert this object to a map.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'loginMode': loginMode,
      'provider': provider,
      'signatureTimestamp': signatureTimestamp,
      'user': user.toMap(),
      'UID': UID,
      'UIDSignature': UIDSignature,
    };
  }
}