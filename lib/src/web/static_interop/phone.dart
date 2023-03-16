import 'package:js/js.dart';

/// The static interop class for the `Phone` object.
@JS()
@anonymous
class Phone {
  /// Construct a new [Phone] instance.
  external factory Phone({String? number, String? type});

  /// The value of the phone number.
  external String? get number;

  /// The type of phone number.
  external String? get type;
}