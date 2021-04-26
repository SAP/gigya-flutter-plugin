import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:gigya_flutter_plugin/interruption/interruption_resolver.dart';
import 'package:gigya_flutter_plugin/models/gigya_models.dart';

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
class GigyaSdk with DataMixin {
  static const MethodChannel _channel = const MethodChannel('gigya_flutter_plugin');

  /// Singleton shared instance of the Gigya SDK.
  static final GigyaSdk instance = GigyaSdk._();

  /// Resolver factory instance.cd
  final ResolverFactory resolverFactory = ResolverFactory(_channel);

  /// Private initializer.
  GigyaSdk._();

  /// Testing basic channeling.
  Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// General/Anonymous send request initiator.
  ///
  /// Request should receive an [endpoint] and required [params] map.
  Future<Map<String, dynamic>?> send(endpoint, params) async {
    final json = await (_channel
        .invokeMethod<String>(Methods.sendRequest.name, {'endpoint': endpoint, 'parameters': params}).catchError((error) {
      return throw GigyaResponse.fromJson(decodeError(error));
    }).timeout(_getTimeout(Methods.sendRequest), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return jsonEncode(_timeoutError());
    }) as FutureOr<String>);
    return jsonDecode(json);
  }

  /// Login using LoginId/password combination.
  ///
  /// Optional [params] map is available.
  Future<Map<String, dynamic>?> login(loginId, password, {params}) async {
    final response = await _channel.invokeMapMethod<String, dynamic>(Methods.loginWithCredentials.name,
        {'loginId': loginId, 'password': password, 'parameters': params ?? {}}).catchError((error) {
      debugPrint('error');
      return throw GigyaResponse.fromJson(decodeError(error));
    }).timeout(_getTimeout(Methods.loginWithCredentials), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return _timeoutError();
    });
    return response;
  }

  /// Register new user using email/password combination.
  ///
  /// Optional [params] map is available.
  Future<Map<String, dynamic>?> register(loginId, password, {params}) async {
    final response = await _channel.invokeMapMethod<String, dynamic>(Methods.registerWithCredentials.name,
        {'email': loginId, 'password': password, 'parameters': params ?? {}}).catchError((error) {
      return throw GigyaResponse.fromJson(decodeError(error));
    }).timeout(_getTimeout(Methods.registerWithCredentials), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return _timeoutError();
    });
    return response;
  }

  /// Check logged in status.
  Future<bool> isLoggedIn() async {
    final state = await _channel.invokeMethod<bool>(Methods.isLoggedIn.name);
    return state ?? false;
  }

  /// Request account object.
  ///
  /// Optional [invalidate] parameter is available to make sure a new account call is preformed, ignoring caching strategy.
  /// API is relevant only when host is logged in.
  /// Account caching strategies are *currently* handled in native code.
  Future<Map<String, dynamic>?> getAccount({invalidate, parameters}) async {
    final response = await _channel.invokeMapMethod<String, dynamic>(
        Methods.getAccount.name, {'invalidate': invalidate, 'parameters': parameters}).catchError((error) {
      return throw GigyaResponse.fromJson(decodeError(error));
    }).timeout(_getTimeout(Methods.getAccount), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return _timeoutError();
    });
    return response;
  }

  /// Update account object providing a mapped [account].
  ///
  /// API is relevant only when host is logged in.
  /// It is suggested to use "isLoggedIn" call to verify state.
  Future<Map<String, dynamic>?> setAccount(account) async {
    final response =
        await _channel.invokeMapMethod<String, dynamic>(Methods.setAccount.name, {'account': account}).catchError((error) {
      return throw GigyaResponse.fromJson(decodeError(error));
    }).timeout(_getTimeout(Methods.setAccount), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return _timeoutError();
    });
    return response;
  }

  /// Log out of current active session.
  Future<void> logout() async {
    await _channel.invokeMethod(Methods.logOut.name).catchError((error) {
      debugPrint('Error logging out');
    }).timeout(_getTimeout(Methods.logOut), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return _timeoutError();
    });
  }

  /// Perform a social login given the [provider] identity.
  /// This call will specifically call the "notifySocialLogin" endpoint.
  /// All social provider integration is the host's responsibility.
  ///
  /// Long timeout is set (5 minutes) in order to make sure that long sign in processes will not break.
  Future<Map<String, dynamic>?> socialLogin(SocialProvider provider, {parameters}) async {
    final response = await _channel.invokeMapMethod<String, dynamic>(
        Methods.socialLogin.name, {'provider': provider.name, 'parameters': parameters}).catchError((error) {
      return throw GigyaResponse.fromJson(decodeError(error));
    }).timeout(_getTimeout(Methods.socialLogin), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return _timeoutError();
    });
    return response;
  }

  /// Add a social connection to an existing account.
  ///
  /// Will require social connection to be authenticated.
  Future<Map<String, dynamic>?> addConnection(SocialProvider provider) async {
    final response = await _channel
        .invokeMapMethod<String, dynamic>(Methods.addConnection.name, {'provider': provider.name}).catchError((error) {
      return throw GigyaResponse.fromJson(decodeError(error));
    }).timeout(_getTimeout(Methods.addConnection), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return _timeoutError();
    });
    return response;
  }

  /// Remove a social connection from an existing account.
  Future<Map<String, dynamic>?> removeConnection(SocialProvider provider) async {
    final response = await _channel
        .invokeMapMethod<String, dynamic>(Methods.removeConnection.name, {'provider': provider.name}).catchError((error) {
      return throw GigyaResponse.fromJson(decodeError(error));
    }).timeout(_getTimeout(Methods.removeConnection), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return _timeoutError();
    });
    return response;
  }

  /// Screen-sets event subscription.
  StreamSubscription<dynamic>? _screenSetsEventStream;

  showScreenSet(name, OnScreenSetEvent onScreenSetEvent, {parameters}) async {
    await _channel.invokeMethod(Methods.showScreenSet.name, {'screenSet': name, 'parameters': parameters});

    const EventChannel _stream = EventChannel('screensetEvents');
    _screenSetsEventStream = _stream.receiveBroadcastStream().listen((onData) {
      onScreenSetEvent(onData['event'], onData['data']);
      if (onData['event'] == 'onHide' || onData['event'] == 'onCanceled') {
        _screenSetsEventStream = null;
      }
    });
  }

  /// Specific timeout logic for specific methods.
  Duration _getTimeout(Methods method) {
    switch (method) {
      case Methods.socialLogin:
      case Methods.addConnection:
        return Duration(minutes: 5);
      default:
        return Duration(minutes: 1);
    }
  }

  /// Genetic timeout error.
  Map<String, dynamic> _timeoutError() {
    return {
      'statusCode': 500,
      'errorCode': 504002,
      'errorDetails': 'A timeout that was defined in the request is reached',
    };
  }
}

mixin DataMixin {
  /// Mapping communication error structure.
  Map<String, dynamic>? decodeError(PlatformException error) {
    if (error.details != null && error.details is Map<dynamic, dynamic>) {
      final mapped = error.details.cast<String, dynamic>();
      return mapped;
    }
    return {};
  }
}
