import 'dart:js_interop';

/// The extension type for the `Phone` object.
@JS()
@anonymous
@staticInterop
extension type Phone._(JSObject _) implements JSObject {
  /// Construct a new [Phone] instance.
  external factory Phone({
    String? number,
    String? type,
  });

  /// Create a new [Phone] instance from the given [map].
  factory Phone.fromMap(Map<String, dynamic> map) {
    return Phone(
      number: map['number'] as String?,
      type: map['type'] as String?,
    );
  }  
  
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
