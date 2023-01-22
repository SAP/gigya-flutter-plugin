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
