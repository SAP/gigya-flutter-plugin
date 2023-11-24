import 'dart:js_interop';

/// The extension type for the `Like` object.
@JS()
@anonymous
@staticInterop
extension type Like._(JSObject _) implements JSObject {
  /// Create a new [Like] instance.
  external factory Like({
    String? category,
    String? id,
    String? name,
    String? time,
  });

  /// Create a new [Like] instance from the given [map].
  factory Like.fromMap(Map<String, dynamic> map) {
    return Like(
      category: map['category'] as String?,
      id: map['id'] as String?,
      name: map['name'] as String?,
      time: map['time'] as String?,
    );
  }

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
