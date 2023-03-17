import 'package:js/js.dart';

/// The static interop class for the session info object.
@JS()
@anonymous
@staticInterop
class SessionInfo {
  /// Construct a new [SessionInfo] instance.
  external factory SessionInfo({
    String? cookieName,
    String? cookieValue,
  });
}

/// This extension defines the static interop definition
/// for the [SessionInfo] class.
extension SessionInfoExtension on SessionInfo {
  /// The name of the session cookie.
  external String? get cookieName;

  /// The value of the session cookie.
  external String get cookieValue;
}
