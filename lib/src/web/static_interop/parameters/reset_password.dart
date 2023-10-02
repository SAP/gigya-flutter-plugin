import 'dart:js_interop';

/// This extension type represents the parameters for the `Accounts.resetPassword` method.
@JS()
@anonymous
@staticInterop
extension type ResetPasswordParameters._(JSObject _) implements JSObject {
  /// Create a new [ResetPasswordParameters] instance.
  external factory ResetPasswordParameters({
    String? email,
    bool? ignoreInterruptions,
    String? lang,
    String? loginID,
    String? newPassword,
    String? passwordResetToken,
    String? secretAnswer,
    String? securityFields,
    // TODO: this parameter is not documented in the list at
    // https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/c21d4e0445b84a779af1ad4868902c21.html#parameters
    bool? sendEmail,
  });
}
