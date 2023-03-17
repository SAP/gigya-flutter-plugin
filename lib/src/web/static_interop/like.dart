import 'package:js/js.dart';

/// The static interop class for the `Like` object.
@JS()
@anonymous
@staticInterop
class Like {
  /// Create a new [Like] instance.
  external factory Like({
    String? category,
    String? id,
    String? name,
    String? time,
  });
}

/// This extension defines the static interop definition
/// for the [Like] class.
extension LikeExtension on Like {
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
