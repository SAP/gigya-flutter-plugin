import 'package:js/js.dart';

// Export the response classes,
// since importing one does not include the extension getters,
// which are defined here.
export 'conflicting_account_response.dart';
export 'login_response.dart';

/// The static interop class for the Gigya `Response` class.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/416d55f070b21014bbc5a10ce4041860.html
@JS()
@anonymous
@staticInterop
class Response {}

/// This extension defines the static interop definition
/// for the [Response] class.
extension ResponseExtension on Response {
  /// The version of the Gigya API that was used.
  external int? get apiVersion;

  /// The unique identifier of the transaction.
  external String get callId;

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
