import 'dart:js_interop';

import '../response/conflicting_account_response.dart';

/// This extension type represents the parameters for the `Accounts.getConflictingAccount` method.
@JS()
@anonymous
@staticInterop
extension type ConflictingAccountParameters._(JSObject _) implements JSObject {
  /// Create a [ConflictingAccountParameters] instance using the given [callback] and [regToken].
  /// 
  /// The [callback] receives a [ConflictingAccountResponse] as argument,
  /// and has [JSVoid] as return type.
  external factory ConflictingAccountParameters({
    JSFunction callback,
    String regToken,
  });
}
