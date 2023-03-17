import 'package:js/js.dart';

import '../response/login_response.dart';

/// This class represents the parameters for the `Accounts.login` method.
@JS()
@anonymous
@staticInterop
class LoginParameters {
  /// Create a new [LoginParameters] instance.
  external factory LoginParameters({
    String loginID,
    String password,
    void Function(LoginResponse response) callback,
  });
}
