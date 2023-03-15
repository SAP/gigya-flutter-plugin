import 'package:js/js.dart';

import 'response.dart';

/// This class represents the parameters object for the various Gigya Web SDK methods.
@JS()
@anonymous
class GigyaMethodParameters {
  /// Create a [GigyaMethodParameters] instance using the given [callback] and [context].
  external factory GigyaMethodParameters({void Function(Response response) callback, Object? context});
}
