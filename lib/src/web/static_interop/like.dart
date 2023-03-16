import 'package:js/js.dart';

/// The static interop class for the `Like` object.
@JS()
@anonymous
class Like {
  /// Create a new [Like] instance.
  external factory Like({
    String? category,
    String? id,
    String? name,
    String? time,
  });

  /// The category of the like.
  external String? get category;

  /// The identifier of the like.
  external String? get id;

  /// The name of the like.
  external String? get name;

  /// The timestamp, in UTC, on which the like was created.
  external String? get time;

  /// Convert the given [like] to a [Map].
  ///
  /// Since the [Like] class is an anonymous JavaScript type,
  /// this has to be a static method instead of an instance method.
  static Map<String, dynamic> toMap(Like like) {
    return <String, dynamic>{
      'category': like.category,
      'id': like.id,
      'name': like.name,
      'time': like.time,
    };
  }
}
