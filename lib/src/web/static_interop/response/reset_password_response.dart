import 'dart:js_interop';

import 'response.dart';

// TODO: fix the extension type
// - String? time
// - Emails? emails
// - String? UID -> fix the JS annotation

/// The static interop class for the Gigya Reset Password API response.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/c21d4e0445b84a779af1ad4868902c21.html#response-data
@JS()
@anonymous
@staticInterop
class ResetPasswordResponse extends Response {}

/// This extension defines the static interop definition
/// for the [ResetPasswordResponse] class.
extension ResetPasswordResponseExtension on ResetPasswordResponse {
  @JS('emails')
  external Object? get _emails;

  /// The email addresses belonging to the user.
  Map<String, dynamic> get emails {
    if (_emails.isUndefinedOrNull) {
      return const <String, dynamic>{};
    }

    return (dartify(_emails) as Map<Object?, Object?>).cast<String, dynamic>();
  }

  /// The token that should be used for the password reset in the password reset email.
  ///
  /// This is null if the email is sent by the Gigya SDK.
  external String? get passwordResetToken;

  /// The secret question for the password reset.
  ///
  /// This is null if there is no security verification failure.
  external String? get secretQuestion;

  /// The UID of the user whose password was changed.
  ///
  /// This is null if the password was not changed yet.
  @JS('UID')
  external String? get uid;
}
