import 'dart:js_interop';

/// The extension type for the login id of a user.
@JS()
@anonymous
@staticInterop
extension type AccountLoginId(JSObject _) {
  @JS('emails')
  external JSArray get _emails;

  @JS('unverifiedEmails')
  external JSArray get _unverifiedEmails;

  /// The list of verified email addresses of the user.
  List<String> get emails => _emails.toDart.cast<String>();

  /// The list of unverified email addresses of the user.
  List<String> get unverifiedEmails => _unverifiedEmails.toDart.cast<String>();

  /// The username of the user.
  external String? get username;

  /// Convert this object into a map.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'emails': emails,
      'unverifiedEmails': unverifiedEmails,
      'username': username,
    };
  }
}
