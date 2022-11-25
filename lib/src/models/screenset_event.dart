/// This class represents a screenset event.
class ScreensetEvent {
  /// The default constructor.
  const ScreensetEvent(this.type, this.data);

  /// The data contained in the event.
  final Object? data;

  /// The type of the event.
  final String type;

  /// Whether the screen set was canceled or closed.
  bool get isCanceled => type == 'onCanceled' || type == 'onHide';
}
