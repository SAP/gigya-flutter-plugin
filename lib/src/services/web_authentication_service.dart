/// This interface defines a Web Authentication service.
abstract class WebAuthenticationService {
  /// The default, const constructor. Used by subclasses.
  const WebAuthenticationService();

  /// Perform a login using web authentication.
  Future<Map<String, dynamic>> login() {
    throw UnimplementedError('login() is not implemented.');
  }

  /// Perform a registration using web authentication.
  Future<Map<String, dynamic>> register() {
    throw UnimplementedError('register() is not implemented.');
  }

  /// Revoke the web authentication for the current user.
  Future<Map<String, dynamic>> revoke() {
    throw UnimplementedError('revoke() is not implemented.');
  }
}
