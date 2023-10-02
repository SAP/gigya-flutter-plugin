import 'dart:js_interop';

import './session.dart';
import 'parameters/basic.dart';
import 'parameters/conflicting_account.dart';
import 'parameters/login.dart';
import 'parameters/registration.dart';
import 'parameters/reset_password.dart';
import 'response/reset_password_response.dart';

/// The extension type for the `gigya.accounts` JavaScript object.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/4130da0f70b21014bbc5a10ce4041860.html
@JS()
@staticInterop
extension type Accounts(JSObject _) {
  /// Finalize a pending registration.
  /// 
  /// This function receives a [FinalizeRegistrationParameters] instance as argument,
  /// and has [JSVoid] as return type.
  external JSFunction finalizeRegistration;

  /// Get the conflicting accounts of the user.
  /// 
  /// This function receives a [ConflictingAccountParameters] instance as argument,
  /// and has [JSVoid] as return type.
  external JSFunction getConflictingAccount;

  /// Start a registration.
  /// 
  /// This function receives an [InitRegistrationParameters] instance as argument,
  /// and has [JSVoid] as return type.
  external JSFunction initRegistration;  
  
  /// Log the user in.
  /// 
  /// This function receives a [LoginParameters] instance as argument,
  /// and has [JSVoid] as return type.
  external JSFunction login;

  /// Log out of the current session.
  /// 
  /// This function receives a [BasicParameters] instance as argument,
  /// and has [JSVoid] as return type.
  external JSFunction logout;

  /// Register a new user using the given parameters.
  /// 
  /// This function receives a [RegistrationParameters] instance as argument,
  /// and has [JSVoid] as return type.
  external JSFunction register;

  /// Reset the user's password.
  /// 
  /// This function receives a [ResetPasswordParameters] instance as argument,
  /// and has [ResetPasswordResponse] as return type.
  external JSFunction resetPassword;

  /// Get the `gigya.accounts.session` namespace.
  external Session get session;
}
