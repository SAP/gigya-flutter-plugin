import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../method_channel/gigya_flutter_plugin_method_channel.dart';
import '../models/enums/social_provider.dart';
import '../models/screenset_event.dart';
import '../services/biometric_service.dart';
import '../services/interruption_resolver.dart';
import '../services/otp_service.dart';
import '../services/web_authentication_service.dart';

/// The platform interface for the Gigya Flutter Plugin.
abstract class GigyaFlutterPluginPlatform extends PlatformInterface {
  /// Constructs a GigyaFlutterPluginPlatform.
  GigyaFlutterPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static GigyaFlutterPluginPlatform _instance =
      MethodChannelGigyaFlutterPlugin();

  /// The default instance of [GigyaFlutterPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelGigyaFlutterPlugin].
  static GigyaFlutterPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GigyaFlutterPluginPlatform] when
  /// they register themselves.
  static set instance(GigyaFlutterPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Get the interruption resolver factory provided by the Gigya SDK.
  InterruptionResolverFactory get interruptionResolverFactory {
    throw UnimplementedError(
      'get interruptionResolverFactory is not implemented.',
    );
  }

  /// Get the One-Time-Password service provided by the Gigya SDK.
  OtpService get otpService {
    throw UnimplementedError('get otpService is not implemented.');
  }

  /// Get the web authentication service provided by the Gigya SDK.
  WebAuthenticationService get webAuthenticationService {
    throw UnimplementedError(
      'get webAuthenticationService is not implemented.',
    );
  }

  /// Get the Biometric service provided by the Gigya SDK.
  BiometricService get biometricService {
    throw UnimplementedError('get biometricService is not implemented.');
  }

  /// Add a social connection to an existing account.
  Future<Map<String, dynamic>> addConnection(SocialProvider provider) {
    throw UnimplementedError('addConnection() is not implemented.');
  }

  /// Start the forgot password flow for the given [loginId].
  Future<Map<String, dynamic>> forgotPassword(String loginId) {
    throw UnimplementedError('forgotPassword() is not implemented.');
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
    throw UnimplementedError('getAccount() is not implemented.');
  }

  /// Get the current session.
  Future<Map<String, dynamic>> getSession() {
    throw UnimplementedError('getSession() is not implemented.');
  }

  /// Initialize the Gigya SDK with the given [apiKey], [apiDomain] and [cname].
  ///
  /// If [forceLogout] is true, the user will be logged out.
  Future<void> initSdk({
    required String apiDomain,
    required String apiKey,
    String? cname,
    bool forceLogout = true,
  }) {
    throw UnimplementedError('initSdk() is not implemented.');
  }

  /// Check whether the user is logged in.
  Future<bool> isLoggedIn() {
    throw UnimplementedError('isLoggedIn() is not implemented.');
  }

  /// Link a social account to an existing site account.
  Future<Map<String, dynamic>> linkToSite({
    required String loginId,
    required String password,
  }) {
    throw UnimplementedError('linkToSite() is not implemented.');
  }

  /// Login using the given [loginId] and [password] combination.
  ///
  /// Any additional parameters can be provided using the [parameters] map.
  Future<Map<String, dynamic>> login({
    required String loginId,
    required String password,
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) {
    throw UnimplementedError('login() is not implemented.');
  }

  /// Log out of the current active session.
  Future<void> logout() {
    throw UnimplementedError('logout() is not implemented.');
  }

  /// Register a new user using the given [loginId] and [password].
  ///
  /// Any additional parameters can be provided using the [parameters] map.
  Future<Map<String, dynamic>> register({
    required String loginId,
    required String password,
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) {
    throw UnimplementedError('register() is not implemented.');
  }

  /// Remove a social connection from an existing account.
  Future<Map<String, dynamic>> removeConnection(SocialProvider provider) {
    throw UnimplementedError('removeConnection() is not implemented.');
  }

  /// Send a request to the Gigya SDK.
  ///
  /// The [endpoint] specifies which API endpoint to use.
  /// The [parameters] specify the parameters to pass to the endpoint.
  Future<Map<String, dynamic>> send(
    String endpoint, {
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) {
    throw UnimplementedError('send() is not implemented.');
  }

  /// Update a given [account].
  ///
  /// After updating an account, it is strongly recommended to verify
  /// if the account is still logged in, using [isLoggedIn].
  Future<Map<String, dynamic>> setAccount(Map<String, dynamic> account) {
    throw UnimplementedError('setAccount() is not implemented.');
  }

  /// Set a new session with the given [expiresIn], [sessionToken] and [sessionSecret].
  ///
  /// The [expiresIn] indicates the amount of seconds until the session expires.
  Future<void> setSession({
    required int expiresIn,
    required String sessionSecret,
    required String sessionToken,
  }) {
    throw UnimplementedError('setSession() is not implemented.');
  }

  /// Show the screen set with the given [name].
  ///
  /// Returns the stream of screenset events.
  Stream<ScreensetEvent> showScreenSet(
    String name, {
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) {
    throw UnimplementedError('showScreenSet() is not implemented.');
  }

  /// Dismiss the currently shown screenset.
  Future<void> dismissScreenSet() {
    throw UnimplementedError('dismissScreenSet() is not implemented.');
  }

  /// Perform a login through the given [provider].
  ///
  /// This method leverages a longer than usual timeout of 5 minutes,
  /// to make sure that long sign-in processes don't fail early.
  Future<Map<String, dynamic>> socialLogin(
    SocialProvider provider, {
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) {
    throw UnimplementedError('socialLogin() is not implemented.');
  }

  /// Perform a single-sign-on.
  Future<Map<String, dynamic>> sso({
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) {
    throw UnimplementedError('sso() is not implemented.');
  }
}
