/// This class represents a session info object.
///
/// When running on native platforms, this session info contains a session token and secret.
/// When running on the web, this session info contains a session cookie.
class SessionInfo {
  /// The default constructor.
  SessionInfo.fromJson(Map<String, dynamic> json)
      : cookieName = json['cookieName'] as String?,
        cookieValue = json['cookieValue'] as String?,
        expiresIn = json['expires_in'] as int?,
        sessionSecret = json['sessionSecret'] as String?,
        sessionToken = json['sessionToken'] as String?;

  /// The name of the session cookie.
  ///
  /// This is null when not running on the web.
  final String? cookieName;

  /// The value of the session cookie.
  ///
  /// This is null when not running on the web.
  final String? cookieValue;

  /// The expiration time of the session, in seconds.
  ///
  /// This is null when running on the web.
  final int? expiresIn;

  /// The session secret.
  ///
  /// This is null when running on the web.
  final String? sessionSecret;

  /// The session token.
  ///
  /// This is null when running on the web.
  final String? sessionToken;

  /// Convert this object into a JSON object.
  ///
  /// The session cookie is not serialized when calling this method.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'sessionToken': sessionToken,
      'sessionSecret': sessionSecret,
      'expires_in': expiresIn,
    };
  }
}
