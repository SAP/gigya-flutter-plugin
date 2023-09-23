import 'dart:js_interop';

/// The extension type for the `Conflicting Account` object.
@JS()
@anonymous
@staticInterop
extension type ConflictingAccount(JSObject _) {
  /// The username or email address
  /// of the user that has a conflicting account.
  external String? get loginID;

  @JS('loginProviders')
  external JSArray? get _loginProviders;

  /// The login providers for the [loginID] that has a conflicting account.
  List<String>? get loginProviders => _loginProviders?.toDart.cast<String>();
}
