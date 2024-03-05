import 'dart:js_interop';

export 'conflicting_account_response.dart';
export 'login_response.dart';

/// The extension type for the Gigya `Response` class.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/416d55f070b21014bbc5a10ce4041860.html
@JS()
extension type Response._(JSObject _) {
  /// The version of the Gigya API that was used.
  external int? get apiVersion;

  /// The unique identifier of the transaction.
  external String get callId;

  /// Get the error details.
  ///
  /// This getter can be redefined (not overridden) by extension types,
  /// that have [Response] as representation type,
  /// to include additional details.
  Map<String, Object?> get details {
    return <String, Object?>{
      'errorDetails': errorDetails,
    };
  }

  /// The response error code.
  ///
  /// A value of zero indicates success.
  /// Any other number indicates a failure.
  ///
  /// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/416d41b170b21014bbc5a10ce4041860.html
  external int get errorCode;

  /// The additional details of the encountered error.
  external String? get errorDetails;

  /// The error message for the given [errorCode].
  external String? get errorMessage;
}
