import 'package:js/js.dart';

import '../models/validation_error.dart';
import 'response.dart';

/// The static interop class for the Gigya Set Account API response.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/4139777d70b21014bbc5a10ce4041860.html?locale=en-US#response-object-data-members
@JS()
@anonymous
@staticInterop
class SetAccountResponse extends Response {}

/// This extension defines the static interop definition
/// for the [SetAccountResponse] class.
extension SetAccountResponseExtension on SetAccountResponse {
  @JS('validationErrors')
  external List<dynamic> get _validationErrors;

  /// The validation errors for the set account payload.
  List<ValidationError> get validationErrors => _validationErrors.cast<ValidationError>();
}
