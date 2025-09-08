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

  Future<Map<String, dynamic>> passkeyLogin() {
    throw UnimplementedError('passkeyLogin() is not implemented.');
  }

  Future<Map<String, dynamic>> passkeyRegister() {
    throw UnimplementedError('passkeyRegister() is not implemented.');
  }

  Future<Map<String, dynamic>> passkeyRevoke(String id) {
    throw UnimplementedError('passkeyRevoke() is not implemented.');
  }

  Future<Map<String, dynamic>> passkeyGetCredentials() {
    throw UnimplementedError('passkeyGetCredentials() is not implemented.');
  }
}
