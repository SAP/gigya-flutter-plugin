import 'dart:js_interop';

import '../models/conflicting_account.dart';
import 'response.dart';

/// The extension type for the Gigya Conflicting Account API response.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/4134c49270b21014bbc5a10ce4041860.html
@JS()
@anonymous
@staticInterop
extension type ConflictingAccountResponse(Response baseResponse) {
  /// Get the conflicting account that is included in the response.
  external WebConflictingAccount? get conflictingAccount;
}
