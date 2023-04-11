import 'package:js/js.dart';

import '../models/profile.dart';
import '../response/login_response.dart';
import '../response/registration_response.dart';

/// This class represents the parameters for the `Accounts.initRegistration` method.
@JS()
@anonymous
@staticInterop
class InitRegistrationParameters {
  /// Create a new [InitRegistrationParameters] instance.
  external factory InitRegistrationParameters({
    void Function(InitRegistrationResponse response) callback,
    bool isLite,
  });
}

/// This class represents the parameters for the `Accounts.registration` method.
@JS()
@anonymous
@staticInterop
class RegistrationParameters {
  /// Create a new [RegistrationParameters] instance.
  external factory RegistrationParameters({
    void Function(LoginResponse response) callback,
    String? captchaToken,
    String email,
    bool finalizeRegistration,
    String? include,
    String? lang,
    String password,
    Profile? profile,
    String? regSource,
    String regToken,
    String? secretQuestion,
    String? secretAnswer,
    int? sessionExpiration,
    String? siteUID,
  });
}
