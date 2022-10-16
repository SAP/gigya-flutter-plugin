import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:gigya_flutter_plugin/interruption/interruption_resolver.dart';
import 'package:gigya_flutter_plugin/models/gigya_models.dart';
import 'package:gigya_flutter_plugin/services/webauthn_service.dart';

import 'mixin/global_mixin.dart';

enum Methods {
  sendRequest,
  loginWithCredentials,
  registerWithCredentials,
  setAccount,
  getAccount,
  isLoggedIn,
  logOut,
  socialLogin,
  addConnection,
  removeConnection,
  showScreenSet,
  forgotPassword,
  initSdk,
  getSession,
  setSession,
  sso,
}

extension MethodsExt on Methods {
  get name => describeEnum(this);
}

/// Current supported social providers.
enum SocialProvider {
  google,
  facebook,
  line,
  wechat,
  apple,
  amazon,
  linkedin,
  yahoo,
}

extension SocialProviderExt on SocialProvider {
  get name => describeEnum(this);
}

typedef void OnScreenSetEvent(event, data);

/// Main Gigya SDK interface class.
///
/// Do not instantiate this class. Instead use [GigyaSDk.instance] initializer to make
/// sure you are using the same instance across your application.
/// Using the singleton pattern here is crucial to prevent channels overlapping.
class GigyaSdk with DataMixin, GigyaResponseMixin {
  static const MethodChannel _channel =
      const MethodChannel('gigya_flutter_plugin');

  /// Singleton shared instance of the Gigya SDK.
  static final GigyaSdk instance = GigyaSdk._();

  /// Resolver factory instance.cd
  final ResolverFactory resolverFactory = ResolverFactory(_channel);

  final WebAuthnService webAuthn = WebAuthnService(_channel);

  /// Private initializer.
  GigyaSdk._();

  /// Testing basic channeling.
  Future<String> get platformVersion async {
    final result = await _channel.invokeMethod<String>('getPlatformVersion');
    return result!;
  }

  /// General/Anonymous send request initiator.
  ///
  /// Request should receive an [endpoint] and required [params] map.
  Future<Map<String, dynamic>?> send(endpoint, params) async {
    final json = await _channel.invokeMethod<String>(
      Methods.sendRequest.name,
      {
        'endpoint': endpoint,
        'parameters': params,
      },
    ).catchError((error) {
      return throw GigyaResponse.fromJson(decodeError(error));
    }).timeout(getTimeout(Methods.sendRequest), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return jsonEncode(timeoutError());
    });
    return json != null ? jsonDecode(json) : null;
  }

  /// Login using LoginId/password combination.
  ///
  /// Optional [params] map is available.
  Future<Map<String, dynamic>?> login(loginId, password, {params}) async {
    final result = await _channel.invokeMapMethod<String, dynamic>(
      Methods.loginWithCredentials.name,
      {
        'loginId': loginId,
        'password': password,
        'parameters': params ?? {},
      },
    ).catchError((error) {
      debugPrint('error');
      return throw GigyaResponse.fromJson(decodeError(error));
    }).timeout(getTimeout(Methods.loginWithCredentials), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return timeoutError();
    });
    return result;
  }

  /// Register new user using email/password combination.
  ///
  /// Optional [params] map is available.
  Future<Map<String, dynamic>?> register(loginId, password, {params}) async {
    final result = await _channel.invokeMapMethod<String, dynamic>(
      Methods.registerWithCredentials.name,
      {
        'email': loginId,
        'password': password,
        'parameters': params ?? {},
      },
    ).catchError((error) {
      return throw GigyaResponse.fromJson(decodeError(error));
    }).timeout(getTimeout(Methods.registerWithCredentials), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return timeoutError();
    });
    return result;
  }

  /// Check logged in status.
  Future<bool> isLoggedIn() async {
    final result = await _channel.invokeMethod<bool>(Methods.isLoggedIn.name);
    return result ?? false;
  }

  /// Request account object.
  ///
  /// Optional [invalidate] parameter is available to make sure a new account call is preformed, ignoring caching strategy.
  /// API is relevant only when host is logged in.
  /// Account caching strategies are *currently* handled in native code.
  Future<Map<String, dynamic>?> getAccount({invalidate, parameters}) async {
    final result = await _channel.invokeMapMethod<String, dynamic>(
      Methods.getAccount.name,
      {
        'invalidate': invalidate,
        'parameters': parameters,
      },
    ).catchError((error) {
      return throw GigyaResponse.fromJson(decodeError(error));
    }).timeout(getTimeout(Methods.getAccount), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return timeoutError();
    });
    return result;
  }

  /// Update account object providing a mapped [account].
  ///
  /// API is relevant only when host is logged in.
  /// It is suggested to use "isLoggedIn" call to verify state.
  Future<Map<String, dynamic>?> setAccount(account) async {
    final result = await _channel.invokeMapMethod<String, dynamic>(
      Methods.setAccount.name,
      {'account': account},
    ).catchError((error) {
      return throw GigyaResponse.fromJson(decodeError(error));
    }).timeout(getTimeout(Methods.setAccount), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return timeoutError();
    });
    return result;
  }

  /// Log out of current active session.
  Future<void> logout() async {
    await _channel.invokeMethod(Methods.logOut.name).catchError((error) {
      debugPrint('Error logging out');
    }).timeout(getTimeout(Methods.logOut), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return timeoutError();
    });
  }

  /// Forgot password using LoginId
  Future<Map<String, dynamic>?> forgotPassword(loginId) async {
    final result = await _channel.invokeMapMethod<String, dynamic>(
      Methods.forgotPassword.name,
      {
        'loginId': loginId,
      },
    ).timeout(getTimeout(Methods.forgotPassword), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return timeoutError();
    });
    return result;
  }

  /// Init SDK using apiKey and apiDomain
  Future<Map<String, dynamic>?> initSdk(String apiKey, String apiDomain,
      [bool forceLogout = true]) async {
    if (forceLogout) {
      await logout();
    }

    final result = await _channel.invokeMapMethod<String, dynamic>(
      Methods.initSdk.name,
      {
        'apiKey': apiKey,
        'apiDomain': apiDomain,
      },
    ).timeout(getTimeout(Methods.initSdk), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return timeoutError();
    });
    return result;
  }

  /// Perform a social login given the [provider] identity.
  /// This call will specifically call the "notifySocialLogin" endpoint.
  /// All social provider integration is the host's responsibiliy.
  ///
  /// Long timeout is set (5 minutes) in order to make sure that long sign in processes will not break.
  Future<Map<String, dynamic>?> socialLogin(SocialProvider provider,
      {parameters}) async {
    final result = await _channel.invokeMapMethod<String, dynamic>(
      Methods.socialLogin.name,
      {
        'provider': provider.name,
        'parameters': parameters,
      },
    ).catchError((error) {
      return throw GigyaResponse.fromJson(decodeError(error));
    }).timeout(getTimeout(Methods.socialLogin), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return timeoutError();
    });
    return result;
  }

  Future<Map<String, dynamic>?> sso(
      {parameters}) async {
    final result = await _channel.invokeMapMethod<String, dynamic>(
      Methods.sso.name,
      {
        'provider': 'sso',
        'parameters': parameters,
      },
    ).catchError((error) {
      return throw GigyaResponse.fromJson(decodeError(error));
    }).timeout(getTimeout(Methods.sso), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return timeoutError();
    });
    return result;
  }

  /// Add a social connection to an existing account.
  ///
  /// Will require social connection to be authenticated.
  Future<Map<String, dynamic>?> addConnection(SocialProvider provider) async {
    final result = await _channel.invokeMapMethod<String, dynamic>(
      Methods.addConnection.name,
      {
        'provider': provider.name,
      },
    ).catchError((error) {
      return throw GigyaResponse.fromJson(decodeError(error));
    }).timeout(getTimeout(Methods.addConnection), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return timeoutError();
    });
    return result;
  }

  /// Remove a social connection from an existing account.
  Future<Map<String, dynamic>?> removeConnection(
      SocialProvider provider) async {
    final result = await _channel.invokeMapMethod<String, dynamic>(
      Methods.removeConnection.name,
      {
        'provider': provider.name,
      },
    ).catchError((error) {
      return throw GigyaResponse.fromJson(decodeError(error));
    }).timeout(getTimeout(Methods.removeConnection), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return timeoutError();
    });
    return result;
  }

  /// Get current session.
  Future<Map<String, dynamic>?> getSession() async {
    final result = await _channel.invokeMapMethod<String, dynamic>(
      Methods.getSession.name,
    ).catchError((error) {
      debugPrint('get session error $error');
      throw error;
    }).timeout(getTimeout(Methods.getSession), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return timeoutError();
    });
    return result;
  }

  /// Log out of current active session.
  Future<void> setSession(
      String sessionToken, String sessionSecret, double expiration) async {
    await _channel.invokeMapMethod(Methods.setSession.name, {
      "sessionToken": sessionToken,
      "sessionSecret": sessionSecret,
      "expires_in": expiration
    }).catchError((error) {
      debugPrint('Set session error');
    }).timeout(getTimeout(Methods.setSession), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return timeoutError();
    });
  }

  /// Link social account to existing site account.
  Future<Map<String, dynamic>?> linkToSite(
      String loginId, String password) async {
    final result = await _channel.invokeMapMethod<String, dynamic>(
      'linkToSite',
      {
        'loginId': loginId,
        'password': password,
      },
    ).catchError((error) {
      throw GigyaResponse.fromJson(decodeError(error));
    }).timeout(getTimeout(Methods.removeConnection), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return timeoutError();
    });
    return result;
  }

  /// Screen-sets event subscription.
  // ignore: unused_field, cancel_subscriptions
  StreamSubscription<dynamic>? _screenSetsEventStream;

  showScreenSet(name, OnScreenSetEvent onScreenSetEvent, {parameters}) async {
    await _channel.invokeMethod(
      Methods.showScreenSet.name,
      {
        'screenSet': name,
        'parameters': parameters,
      },
    );

    const EventChannel _stream = EventChannel('screensetEvents');
    _screenSetsEventStream = _stream.receiveBroadcastStream().listen((onData) {
      onScreenSetEvent(
        onData['event'],
        onData['data'],
      );
      if (onData['event'] == 'onHide' || onData['event'] == 'onCanceled') {
        _screenSetsEventStream = null;
      }
    });
  }

}
