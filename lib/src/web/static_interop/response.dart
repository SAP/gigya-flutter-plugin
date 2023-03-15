import 'package:js/js.dart';

/// The static interop class for the Gigya `Response` class.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/416d55f070b21014bbc5a10ce4041860.html
@JS()
@anonymous
class Response {
  /// Construct a [Response] object.
  external factory Response({String callId, Object? context, int errorCode, String errorMessage});

  /// The unique identifier of the transaction.
  external String get callId;

  /// The context that was passed to the method that responded with this [Response].
  external Object? get context;

  /// The response error code.
  ///
  /// A value of zero indicates success.
  /// Any other number indicates a failure.
  ///
  /// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/416d41b170b21014bbc5a10ce4041860.html
  external int get errorCode;

  /// The error message for the given [errorCode].
  external String get errorMessage;
}
