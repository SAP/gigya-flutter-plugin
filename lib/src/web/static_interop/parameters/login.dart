import 'package:js/js.dart';

import '../response/login_response.dart';

/// This class represents the parameters for the `Accounts.login` method.
@JS()
@anonymous
@staticInterop
class LoginParameters {
  /// Create a new [LoginParameters] instance.
  external factory LoginParameters({
    void Function(LoginResponse response) callback,
    String? captchaToken,
    String? include,
    String loginID,
    String? loginMode,
    String password,
    String? redirectURL,
    String? regToken,
    int? sessionExpiration,
  });
}
