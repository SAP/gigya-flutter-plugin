import 'dart:js_interop';

/// The extension type for the `Phone` object.
@JS()
@anonymous
@staticInterop
extension type Phone(JSObject _) {
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
