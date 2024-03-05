import 'dart:js_interop';

/// The extension type for the `Phone` object.
@JS()
extension type Phone._(JSObject _) implements JSObject {
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
