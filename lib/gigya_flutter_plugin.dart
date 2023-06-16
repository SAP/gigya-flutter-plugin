import 'src/models/enums/social_provider.dart';
import 'src/models/screenset_event.dart';
import 'src/platform_interface/gigya_flutter_plugin_platform_interface.dart';
import 'src/services/interruption_resolver/interruption_resolver.dart';
import 'src/services/otp_service/otp_service.dart';
import 'src/services/web_authentication_service/web_authentication_service.dart';

export 'src/models/account.dart';
export 'src/models/address.dart';
export 'src/models/certification.dart';
export 'src/models/conflicting_accounts.dart';
export 'src/models/education.dart';
export 'src/models/emails.dart';
export 'src/models/enums/screen_set_event_type.dart';
export 'src/models/enums/social_provider.dart';
export 'src/models/favorite.dart';
export 'src/models/gigya_error.dart';
export 'src/models/like.dart';
export 'src/models/location.dart';
export 'src/models/oidc_data.dart';
export 'src/models/patent.dart';
export 'src/models/phone.dart';
export 'src/models/profile.dart';
export 'src/models/publication.dart';
export 'src/models/screenset_event.dart';
export 'src/models/session_info.dart';
export 'src/models/skill.dart';
export 'src/models/work.dart';
export 'src/services/interruption_resolver/interruption_resolver.dart';
export 'src/services/otp_service/otp_service.dart';
export 'src/services/web_authentication_service/web_authentication_service.dart';

/// This class represents the Gigya SDK plugin.
class GigyaSdk {
  /// The default constructor.
  const GigyaSdk();

  /// Get the interruption resolver factory provided by the Gigya SDK.
  InterruptionResolverFactory get interruptionResolverFactory {
    return GigyaFlutterPluginPlatform.instance.interruptionResolverFactory;
  }

  /// Get the One-Time-Password service provided by the Gigya SDK.
  OtpService get otpService {
    return GigyaFlutterPluginPlatform.instance.otpService;
  }

  /// Get the web authentication service provided by the Gigya SDK.
  WebAuthenticationService get webAuthenticationService {
    return GigyaFlutterPluginPlatform.instance.webAuthenticationService;
  }

  /// Add a social connection to an existing account.
  Future<Map<String, dynamic>> addConnection(SocialProvider provider) {
    return GigyaFlutterPluginPlatform.instance.addConnection(provider);
  }

  /// Start the forgot password flow for the given [loginId].
  Future<Map<String, dynamic>> forgotPassword(String loginId) {
    return GigyaFlutterPluginPlatform.instance.forgotPassword(loginId);
  }

  /// Get a user account.
  ///
  /// If [invalidate] is true, the existing account is invalidated,
  /// regardless if it was cached.
  /// Account caching is *currently* handled on the native side.
  ///
  /// Throws an error if the user is not logged in.
  Future<Map<String, dynamic>> getAccount({
    bool invalidate = false,
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) {
    return GigyaFlutterPluginPlatform.instance.getAccount(
      invalidate: invalidate,
      parameters: parameters,
    );
  }

  /// Get the current session.
  Future<Map<String, dynamic>> getSession() {
    return GigyaFlutterPluginPlatform.instance.getSession();
  }

  /// Initialize the Gigya SDK with the given [apiKey], [apiDomain] and [cname].
  ///
  /// If [forceLogout] is true, the user will be logged out.
  Future<void> initSdk({
    required String apiDomain,
    required String apiKey,
    String? cname,
    bool forceLogout = false,
  }) {
    return GigyaFlutterPluginPlatform.instance.initSdk(
      apiDomain: apiDomain,
      apiKey: apiKey,
      cname: cname,
      forceLogout: forceLogout,
    );
  }

  /// Check whether the user is logged in.
  Future<bool> isLoggedIn() => GigyaFlutterPluginPlatform.instance.isLoggedIn();

  /// Link a social account to an existing site account.
  Future<Map<String, dynamic>> linkToSite({
    required String loginId,
    required String password,
  }) {
    return GigyaFlutterPluginPlatform.instance.linkToSite(
      loginId: loginId,
      password: password,
    );
  }

  /// Login using the given [loginId] and [password] combination.
  ///
  /// Any additional parameters can be provided using the [parameters] map.
  Future<Map<String, dynamic>> login({
    required String loginId,
    required String password,
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) {
    return GigyaFlutterPluginPlatform.instance.login(
      loginId: loginId,
      password: password,
      parameters: parameters,
    );
  }

  /// Log out of the current active session.
  Future<void> logout() => GigyaFlutterPluginPlatform.instance.logout();

  /// Register a new user using the given [loginId] and [password].
  ///
  /// Any additional parameters can be provided using the [parameters] map.
  Future<Map<String, dynamic>> register({
    required String loginId,
    required String password,
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) {
    return GigyaFlutterPluginPlatform.instance.register(
      loginId: loginId,
      password: password,
      parameters: parameters,
    );
  }

  /// Remove a social connection from an existing account.
  Future<Map<String, dynamic>> removeConnection(SocialProvider provider) {
    return GigyaFlutterPluginPlatform.instance.removeConnection(provider);
  }

  /// Send a request to the Gigya SDK.
  ///
  /// The [endpoint] specifies which API endpoint to use.
  /// The [parameters] specify the parameters to pass to the endpoint.
  Future<Map<String, dynamic>> send(
    String endpoint, {
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) {
    return GigyaFlutterPluginPlatform.instance.send(
      endpoint,
      parameters: parameters,
    );
  }

  /// Update a given [account].
  ///
  /// After updating an account, it is strongly recommended to verify
  /// if the account is still logged in, using [isLoggedIn].
  Future<Map<String, dynamic>> setAccount(Map<String, dynamic> account) {
    return GigyaFlutterPluginPlatform.instance.setAccount(account);
  }

  /// Set a new session with the given [expiresIn], [sessionToken] and [sessionSecret].
  ///
  /// The [expiresIn] indicates the amount of seconds until the session expires.
  Future<void> setSession({
    required int expiresIn,
    required String sessionSecret,
    required String sessionToken,
  }) {
    return GigyaFlutterPluginPlatform.instance.setSession(
      expiresIn: expiresIn,
      sessionSecret: sessionSecret,
      sessionToken: sessionToken,
    );
  }

  /// Show the screen set with the given [name].
  ///
  /// Returns the stream of screenset events.
  Stream<ScreensetEvent> showScreenSet(
    String name, {
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) {
    return GigyaFlutterPluginPlatform.instance.showScreenSet(
      name,
      parameters: parameters,
    );
  }

  /// Perform a login through the given [provider].
  ///
  /// This method leverages a longer than usual timeout of 5 minutes,
  /// to make sure that long sign-in processes don't fail early.
  Future<Map<String, dynamic>> socialLogin(
    SocialProvider provider, {
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) {
    return GigyaFlutterPluginPlatform.instance.socialLogin(
      provider,
      parameters: parameters,
    );
  }

  /// Perform a single-sign-on.
  Future<Map<String, dynamic>> sso({
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) {
    return GigyaFlutterPluginPlatform.instance.sso(parameters: parameters);
  }
}
