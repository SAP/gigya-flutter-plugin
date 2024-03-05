import 'dart:js_interop';

/// The extension type for the `Like` object.
@JS()
extension type Like._(JSObject _) implements JSObject {
  /// The category of the like.
  external String? get category;

  /// The identifier of the like.
  external String? get id;

  /// The name of the like.
  external String? get name;

  /// The timestamp, in UTC, on which the like was created.
  external String? get time;

  /// Convert this like to a [Map].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'id': id,
      'name': name,
      'time': time,
    };
  }
}
