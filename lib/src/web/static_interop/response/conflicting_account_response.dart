import 'package:js/js.dart';

import '../models/conflicting_account.dart';
import 'response.dart';

/// The static interop class for the Gigya Conflicting Account API response.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/4134c49270b21014bbc5a10ce4041860.html
@JS()
@anonymous
@staticInterop
class ConflictingAccountResponse extends Response {
  /// Construct a [ConflictingAccountResponse] object.
  external factory ConflictingAccountResponse({
    int? apiVersion,
    String callId,
    JsConflictingAccount? conflictingAccount,
    int errorCode,
    String? errorDetails,
    String? errorMessage,
  });
}

/// This extension defines the static interop definition
/// for the [ConflictingAccountResponse] class.
extension ConflictingAccountResponseExtension on ConflictingAccountResponse {
  /// Get the conflicting account that is included in the response.
  external JsConflictingAccount? get conflictingAccount;
}
