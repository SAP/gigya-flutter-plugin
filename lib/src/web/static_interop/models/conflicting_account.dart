import 'dart:js_interop';

/// The extension type for the `Conflicting Account` object.
///
/// The name of this extension type is `WebConflictingAccount`,
/// to prevent collisions with the existing `ConflictingAccount` class.
@JS()
extension type WebConflictingAccount._(JSObject _) {
  /// The username or email address
  /// of the user that has a conflicting account.
  external String? get loginID;

  @JS('loginProviders')
  external JSArray<JSString>? get _loginProviders;

  /// The login providers for the [loginID] that has a conflicting account.
  List<String>? get loginProviders => _loginProviders?.toDart.cast<String>();
}
