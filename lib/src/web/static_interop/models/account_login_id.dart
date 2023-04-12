import 'package:js/js.dart';

/// The static interop class for the login id of a user.
@JS()
@anonymous
@staticInterop
class AccountLoginId {}

/// This extension defines the static interop definition
/// for the [AccountLoginId] class.
extension AccountLoginIdExtension on AccountLoginId {
  @JS('emails')
  external List<dynamic> get _emails;

  @JS('unverifiedEmails')
  external List<dynamic> get _unverifiedEmails;

  /// The list of verified email addresses of the user.
  List<String> get emails => _emails.cast<String>();

  /// The username of the user.
  external String get username;

  /// The list of unverified email addresses of the user.
  List<String> get unverifiedEmails => _unverifiedEmails.cast<String>();

  /// Convert this object into a map.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'emails': emails,
      'username': username,
      'unverifiedEmails': unverifiedEmails,
    };
  }
}
