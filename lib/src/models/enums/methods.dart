/// This enum defines the different methods for the Gigya SDK.
enum Methods {
  /// The method that adds a connection to a user account.
  addConnection('addConnection'),

  /// The method that triggers the screen set for the `Forgot Password` flow.
  forgotPassword('forgotPassword'),

  /// The method that gets a user account.
  getAccount('getAccount'),

  /// The method that fetches the conflicting accounts of a user.
  getConflictingAccounts('getConflictingAccounts'),

  /// The method that retrieves a session.
  getSession('getSession'),

  /// The method that initializes the Gigya SDK.
  initSdk('initSdk'),

  /// The method that checks if a user is logged in.
  isLoggedIn('isLoggedIn'),

  /// The method that links a social account to a site account.
  linkToSite('linkToSite'),

  /// The method that links a site account to a social account.
  linkToSocial('linkToSocial'),

  /// The method that logs a user in using his credentials.
  loginWithCredentials('loginWithCredentials'),

  /// The method that logs a user out.
  logOut('logOut'),

  /// The method that registers a user with a given set of credentials.
  registerWithCredentials('registerWithCredentials'),

  /// The method that removes a connection from a user account.
  removeConnection('removeConnection'),

  /// The method that resolves an account conflict.
  resolveSetAccount('resolveSetAccount'),

  /// The generic send request method.
  sendRequest('sendRequest'),

  /// The method that sets a user account.
  setAccount('setAccount'),

  /// The method that updates a session.
  setSession('setSession'),

  /// The method that triggers the display of a screen set.
  showScreenSet('showScreenSet'),

  /// The method that logs a user in using a social provider.
  socialLogin('socialLogin'),

  /// The method that starts Single-Sign-On.
  sso('sso');

  /// The default constructor.
  const Methods(this.methodName);

  /// The name of the method.
  final String methodName;

  /// Get the timeout for this specific method.
  Duration get timeout {
    switch (this) {
      case Methods.socialLogin:
      case Methods.addConnection:
        return const Duration(minutes: 5);
      default:
        return const Duration(minutes: 1);
    }
  }
}

/// This enum defines the different OTP methods used by the OTP service.
enum OtpMethods {
  /// The method that starts the OTP login flow.
  login('otpLogin'),

  /// The method that updates the current OTP login details.
  update('otpUpdate'),

  /// The method that verifies the login token returned by [login].
  verify('otpVerify');

  /// The default constructor.
  const OtpMethods(this.methodName);

  /// The name of the method.
  final String methodName;
}

/// This enum defines the different web authentication methods
/// used by the web authentication service.
enum WebAuthnMethods {
  /// The login-using-web-authentication method.
  login('webAuthnLogin'),

  /// The register-using-web-authentication method.
  register('webAuthnRegister'),

  /// The method that revokes the web authentication of a user.
  revoke('webAuthnRevoke');

  /// The default constructor.
  const WebAuthnMethods(this.methodName);

  /// The name of the method.
  final String methodName;
}
