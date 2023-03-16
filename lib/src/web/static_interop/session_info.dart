import 'package:js/js.dart';

/// The static interop class for the session info object.
@JS()
@anonymous
class SessionInfo {
  /// Construct a new [SessionInfo] instance.
  external factory SessionInfo({
    String? cookieName,
    String? cookieValue,
  });

  /// The name of the session cookie.
  external String? get cookieName;

  /// The value of the session cookie.
  external String get cookieValue;
}
