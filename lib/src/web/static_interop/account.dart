import 'package:js/js.dart';

import 'parameters.dart';

/// The static interop class for the `gigya.accounts` JavaScript object.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/4130da0f70b21014bbc5a10ce4041860.html
@JS()
@staticInterop
class Accounts {}

/// This extension defines the static interop definition
/// for the [Accounts] class.
extension AccountsExtension on Accounts {
  /// Log in using the given parameters.
  external void Function(LoginParameters parameters) login;

  /// Log out of the current session.
  external void Function(GigyaMethodParameters parameters) logout;

  /// Get the session namespace within the accounts namespace.
  external Session get session;
}

/// This class represents the session namespace in the [Accounts] class.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/7fc882712f2e4011982171ea612466ca.html
@JS()
@staticInterop
class Session {}

/// This extension defines the static interop definition
/// for the [Session] class.
extension SessionExtension on Session {
  /// Verify the current session.
  external void Function(GigyaMethodParameters parameters) verify;
}
