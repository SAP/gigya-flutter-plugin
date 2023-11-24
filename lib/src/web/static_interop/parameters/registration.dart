import 'dart:js_interop';

import '../models/profile.dart';
import '../response/login_response.dart';
import '../response/registration_response.dart';

/// The extension type for the parameters for the `Accounts.finalizeRegistration` method.
@JS()
@anonymous
@staticInterop
extension type FinalizeRegistrationParameters._(JSObject _) implements JSObject {
  /// Create a new [FinalizeRegistrationParameters] instance.
  /// 
  /// The [callback] function receives a [LoginResponse] as argument
  /// and has [JSVoid] as return type.
  external factory FinalizeRegistrationParameters({
    JSFunction callback,
    bool allowAccountsLinking,
    String? include,
    String regToken,
  });
}

/// The extension type for the parameters for the `Accounts.initRegistration` method.
@JS()
@anonymous
@staticInterop
extension type InitRegistrationParameters._(JSObject _) implements JSObject {
  /// Create a new [InitRegistrationParameters] instance.
  /// 
  /// The [callback] function receives a [InitRegistrationResponse] as argument
  /// and has [JSVoid] as return type.
  external factory InitRegistrationParameters({
    JSFunction callback,
    bool? isLite,
  });
}

/// The extension type for the parameters for the `Accounts.registration` method.
@JS()
@anonymous
@staticInterop
extension type RegistrationParameters._(JSObject _) implements JSObject {
  /// Create a new [RegistrationParameters] instance.
  /// 
  /// The [callback] function receives a [LoginResponse] as argument
  /// and has [JSVoid] as return type.
  external factory RegistrationParameters({
    JSFunction callback,
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
