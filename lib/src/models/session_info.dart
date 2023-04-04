/// This class represents a session info object.
class SessionInfo {
  /// The default constructor.
  SessionInfo.fromJson(Map<String, dynamic> json)
      : expiresIn = json['expires_in'] as int,
        sessionSecret = json['sessionSecret'] as String,
        sessionToken = json['sessionToken'] as String;

  /// The expiration time of the session, in seconds.
  final int expiresIn;

  /// The session secret.
  final String sessionSecret;

  /// The session token.
  final String sessionToken;

  /// Convert this object into a JSON object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'sessionToken': sessionToken,
      'sessionSecret': sessionSecret,
      'expires_in': expiresIn,
    };
  }
}
