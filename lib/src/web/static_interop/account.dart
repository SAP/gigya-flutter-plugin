import 'dart:js_interop';

import './session.dart';
import 'parameters/add_event_handlers_parameters.dart';
import 'parameters/basic.dart';
import 'parameters/conflicting_account.dart';
import 'parameters/login.dart';

/// The extension type for the `gigya.accounts` JavaScript object.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/4130da0f70b21014bbc5a10ce4041860.html
@JS()
@staticInterop
extension type Accounts(JSObject _) {
  /// Register event handlers for the global events that are emitted by the Gigya SDK.
  /// 
  /// This function receives an [AddEventHandlersParameters] instance as argument,
  /// and has [JSVoid] as return type.
  external JSFunction addEventHandlers;

  /// Get the conflicting accounts of the user.
  /// 
  /// This function receives a [ConflictingAccountParameters] instance as argument,
  /// and has [JSVoid] as return type.
  external JSFunction getConflictingAccount;

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

  /// Get the `gigya.accounts.session` namespace.
  external Session get session;
}
