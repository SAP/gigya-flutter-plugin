import 'enums/screen_set_event_type.dart';

/// This class represents a screenset event.
class ScreensetEvent {
  /// The default constructor.
  factory ScreensetEvent(String type, Map<String, Object?> data) {
    final ScreenSetEventType? resolvedType = _typesMap[type];

    if (resolvedType == null) {
      throw ArgumentError.value(type, 'type');
    }

    return ScreensetEvent._(resolvedType, data);
  }

  /// Construct a new [ScreensetEvent] from the given, loosely-typed [map].
  ///
  /// The map is expected to have an `event` key, denoting the name of the event.
  /// The map can have a `data` key, which is a [Map] that contains any data for the event.
  factory ScreensetEvent.fromMap(Map<Object?, Object?> map) {
    final Map<Object?, Object?>? data = map['data'] as Map<Object?, Object?>?;

    return ScreensetEvent(
      map['event'] as String,
      data?.cast<String, Object?>() ?? const <String, Object?>{},
    );
  }

  /// The private constructor.
  const ScreensetEvent._(this.type, this.data);

  /// The internal map of [ScreenSetEventType]s mapped to their names.
  static final Map<String, ScreenSetEventType> _typesMap =
      ScreenSetEventType.values.asNameMap();

  /// The data of the event.
  final Map<String, Object?> data;

  /// The type of the event.
  final ScreenSetEventType type;
}
