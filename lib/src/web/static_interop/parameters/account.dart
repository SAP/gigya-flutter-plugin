import 'dart:js_interop';

import '../models/profile.dart';
import '../response/response.dart';

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

/// This extension type represents the parameters for the `Accounts.getAccountInfo` method.
@JS()
@anonymous
@staticInterop
extension type GetAccountParameters._(JSObject _) implements JSObject {
  /// Create a [GetAccountParameters] instance.
  /// 
  /// The [callback] receives an [AccountInfoResponse] as argument,
  /// and has [JSVoid] as return type.
  external factory GetAccountParameters({
    JSFunction callback,
    String? extraProfileFields,
    String? include,
  });
}

/// This extension type represents the parameters for the `Accounts.setAccountInfo` method.
@JS()
@anonymous
@staticInterop
extension type SetAccountParameters._(JSObject _) implements JSObject {
  // TODO: add preferences and subscriptions object once the static interop definition is ready

  /// Create a [SetAccountParameters] instance.
  external factory SetAccountParameters({
    String? addLoginEmails,
    String? conflictHandling,
    String? newPassword,
    String? password,
    Profile? profile,
    String? removeLoginEmails,
    bool? requirePasswordChange,
    String? secretAnswer,
    String? secretQuestion,
    String? username,
  });
}
