/// This interface defines a One-Time-Password service.
abstract class OtpService {
  /// The default, const constructor. Used by subclasses.
  const OtpService();

  /// Login using the given [phone] number.
  ///
  /// To complete the login flow, call [PendingOtpVerification.verify]
  /// with the code that was sent to the user.
  ///
  /// Returns a [PendingOtpVerification].
  Future<PendingOtpVerification> login(
    String phone, {
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) {
    throw UnimplementedError('login() is not implemented.');
  }

  /// Update the login information using the given [phone] number.
  Future<Map<String, dynamic>> update(
    String phone, {
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) {
    throw UnimplementedError('update() is not implemented.');
  }
}

/// This class represents a pending One-Time-Password verification,
/// which can be used to finish a One-Time-Password login.
class PendingOtpVerification {
  /// Verify the given [code] and finish the current user login.
  Future<Map<String, dynamic>> verify(String code) {
    throw UnimplementedError('verify() is not implemented.');
  }
}
