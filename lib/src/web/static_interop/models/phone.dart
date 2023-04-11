import 'package:js/js.dart';

/// The static interop class for the `Phone` object.
@JS()
@anonymous
@staticInterop
class Phone {}

/// This extension defines the static interop definition
/// for the [Phone] class.
extension PhoneExtension on Phone {
  /// The value of the phone number.
  external String? get number;

  /// The type of phone number.
  external String? get type;

  /// Convert this phone into a [Map].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': number,
      'type': type,
    };
  }
}
