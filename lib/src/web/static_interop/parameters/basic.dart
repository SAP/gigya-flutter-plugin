import 'package:js/js.dart';

import '../response/response.dart';

/// This class represents the parameters for functions within the Gigya Web SDK,
/// that accept a `callback` function, which in turn receives a [Response] as argument.
@JS()
@anonymous
@staticInterop
class BasicParameters {
  /// Create a [BasicParameters] instance using the given [callback].
  external factory BasicParameters({void Function(Response response) callback});
}
