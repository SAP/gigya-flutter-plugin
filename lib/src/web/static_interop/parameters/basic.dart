import 'dart:js_interop';

import '../response/response.dart';

/// This extension type represents the parameters for functions within the Gigya Web SDK,
/// that accept a `callback` function, which in turn receives a [Response] as argument.
@JS()
@anonymous
@staticInterop
extension type BasicParameters._(JSObject _) {
  /// Create a [BasicParameters] instance using the given [callback].
  /// 
  /// The [callback] function will receive a [Response] as argument.
  external factory BasicParameters({JSFunction callback});
}
