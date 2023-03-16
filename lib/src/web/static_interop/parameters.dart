import 'package:js/js.dart';

import 'response.dart';

/// This class represents the parameters object for the various Gigya Web SDK methods
/// that use a callback function which provides a [Response], along with a `context` object.
@JS()
@anonymous
class GigyaMethodParameters {
  /// Create a [GigyaMethodParameters] instance using the given [callback] and [context].
  external factory GigyaMethodParameters({void Function(Response response) callback, Object? context});
}

/// This class represents the parameters for the `accounts.login()` method.
@JS()
@anonymous
class LoginParameters {
  /// Create a new [LoginParameters] instance.
  external factory LoginParameters({String loginID, String password, void Function(Response response) callback});
}
