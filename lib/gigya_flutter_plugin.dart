import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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
}

extension MethodsExt on Methods {
  get name => describeEnum(this);
}

/// Main Gigya SDK interface class.
///
/// Do not instantiate this class. Instead use [GigyaSDk.instance] initializer to make
/// sure you are using the same instance across your application.
/// Using the singleton pattern here is crucial to prevent channels overlapping.
class GigyaSdk {
  static const MethodChannel _channel = const MethodChannel('gigya_flutter_plugin');

  /// Singleton shared instance of the Gigya SDK.
  static final GigyaSdk instance = GigyaSdk._();

  /// Private initializer.
  GigyaSdk._();

  /// Testing basic channeling.
  Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// General/Anonymous send request initiator.
  ///
  /// Request should receive an [endpoint] and required [params] map.
  Future<Map<String, dynamic>> send(endpoint, params) async {
    final json = await _channel
        .invokeMethod<String>(Methods.sendRequest.name, {'endpoint': endpoint, 'parameters': params}).catchError((error) {
      return throw GigyaResponse.fromJson(_decodeError(error));
    });
    return jsonDecode(json);
  }

  /// Login using LoginId/password combination.
  ///
  /// Optional [params] map is available.
  Future<Map<String, dynamic>> login(loginId, password, {params}) async {
    final response = await _channel.invokeMapMethod<String, dynamic>(Methods.loginWithCredentials.name,
        {'loginId': loginId, 'password': password, 'parameters': params ?? {}}).catchError((error) {
      debugPrint('error');
      return throw GigyaResponse.fromJson(_decodeError(error));
    });
    return response;
  }

  /// Register new user using email/password combination.
  ///
  /// Optional [params] map is available.
  Future<Map<String, dynamic>> register(loginId, password, {params}) async {
    final response = await _channel.invokeMapMethod<String, dynamic>(Methods.registerWithCredentials.name,
        {'loginId': loginId, 'password': password, 'parameters': params ?? {}}).catchError((error) {
      return throw GigyaResponse.fromJson(_decodeError(error));
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
  Future<Map<String, dynamic>> getAccount({invalidate}) async {
    final response =
        await _channel.invokeMapMethod<String, dynamic>(Methods.getAccount.name, {'invalidate': invalidate}).catchError((error) {
      return throw GigyaResponse.fromJson(_decodeError(error));
    });
    return response;
  }

  /// Update account object providing a mapped [account].
  ///
  /// API is relevant only when host is logged in.
  /// It is suggested to use "isLoggedIn" call to verify state.
  Future<Map<String, dynamic>> setAccount(account) async {
    final response =
        await _channel.invokeMapMethod<String, dynamic>(Methods.setAccount.name, {'account': account}).catchError((error) {
      return throw GigyaResponse.fromJson(_decodeError(error));
    });
    return response;
  }

  /// Log out of current active session.
  Future<void> logout() async {
    await _channel.invokeMethod(Methods.logOut.name);
  }

  /// Perform a social login given a [providerSessions] map.
  /// This call will specifically call the "notifySocialLogin" endpoint.
  /// All social provider integration is the host's responsibility.
  Future<Map<String, dynamic>> socialLogin(providerSessions) async {
    final response = await _channel
        .invokeMapMethod<String, dynamic>(Methods.socialLogin.name, {'providerSessions': providerSessions}).catchError((error) {
      return throw GigyaResponse.fromJson(_decodeError(error));
    });
    return response;
  }

  /// Mapping communication error structure.
  Map<String, dynamic> _decodeError(PlatformException error) {
    if (error.details != null && error.details is Map<dynamic, dynamic>) {
      final mapped = error.details.cast<String, dynamic>();
      return mapped;
    }
    return {};
  }
}
