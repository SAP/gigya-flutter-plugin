import 'package:js/js.dart';

import '../response/conflicting_account_response.dart';

/// This class represents the parameters for the `Accounts.getConflictingAccount` method.
@JS()
@anonymous
@staticInterop
class ConflictingAccountParameters {
  /// Create a [ConflictingAccountParameters] instance using the given [callback] and [regToken].
  external factory ConflictingAccountParameters({
    void Function(ConflictingAccountResponse response) callback,
    String regToken,
  });
}
