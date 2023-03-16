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

  /// Convert the given [phone] to a [Map].
  ///
  /// Since the [Phone] class is an anonymous JavaScript type,
  /// this has to be a static method instead of an instance method.
  static Map<String, dynamic> toMap(Phone phone) {
    return <String, dynamic>{
      'number': phone.number,
      'type': phone.type,
    };
  }
}
