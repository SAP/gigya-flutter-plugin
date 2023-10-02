import 'dart:js_interop';

import '../models/emails.dart';
import 'response.dart';

/// The extension type for the Gigya Reset Password API response.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/c21d4e0445b84a779af1ad4868902c21.html#response-data
@JS()
@anonymous
@staticInterop
extension type ResetPasswordResponse(Response baseResponse) {
  /// The email addresses belonging to the user.
  external Emails? get emails;

  /// The token that should be used for the password reset in the password reset email.
  ///
  /// This is null if `ResetPasswordParameters.sendEmail` was `false`.
  external String? get passwordResetToken;

  /// The time of the response, in ISO 8601 format,
  /// i.e. 2021-02-06T22:05:47.706Z.
  external String? get time;

  /// The secret question for the password reset.
  ///
  /// This is null if there is no security verification failure.
  external String? get secretQuestion;

  /// The UID of the user whose password was changed.
  ///
  /// This is null if the password was not changed yet.
  external String? get UID; // ignore: non_constant_identifier_names

  /// Convert this response to a [Map].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'emails': emails?.toMap(),
      'passwordResetToken': passwordResetToken,
      'time': time,
      'secretQuestion': secretQuestion,
      'UID': UID,
    };
  }  
}
