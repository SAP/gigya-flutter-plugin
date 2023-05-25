import 'package:js/js.dart';

/// This class represents the parameters for the `Accounts.resetPassword` method.
@JS()
@anonymous
@staticInterop
class ResetPasswordParameters {
  /// Create a new [ResetPasswordParameters] instance.
  external factory ResetPasswordParameters({
    String? email,
    bool ignoreInterruptions,
    String? lang,
    String? loginID,
    String? newPassword,
    String? passwordResetToken,
    String? secretAnswer,
    String? securityFields,
  });
}
