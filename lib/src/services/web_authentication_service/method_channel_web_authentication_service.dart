import 'dart:convert';

import 'package:flutter/services.dart' show MethodChannel, PlatformException;
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';

import '../../models/enums/methods.dart';

/// This class represents a [WebAuthenticationService] that uses a [MethodChannel]
/// for its implementation.
class MethodChannelWebAuthenticationService extends WebAuthenticationService {
  /// The default constructor.
  const MethodChannelWebAuthenticationService(this._channel);

  final MethodChannel _channel;

  @override
  Future<Map<String, dynamic>> login() async {
    try {
      final Map<String, dynamic>? result =
          await _channel.invokeMapMethod<String, dynamic>(
        WebAuthnMethods.login.methodName,
        <String, dynamic>{},
      ).timeout(
        Methods.sendRequest.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return result ?? <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> passkeyLogin() async {
    try {
      final Map<String, dynamic>? result =
          await _channel.invokeMapMethod<String, dynamic>(
        WebAuthnMethods.passkeyLogin.methodName,
        <String, dynamic>{},
      ).timeout(
        Methods.sendRequest.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return result ?? <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> register() async {
    try {
      final String? json = await _channel.invokeMethod<String>(
        WebAuthnMethods.register.methodName,
        <String, dynamic>{},
      ).timeout(
        Methods.sendRequest.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      if (json == null) {
        return <String, dynamic>{};
      }

      return jsonDecode(json) as Map<String, dynamic>;
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> passkeyRegister() async {
    try {
      final String? json = await _channel.invokeMethod<String>(
        WebAuthnMethods.passkeyRegister.methodName,
        <String, dynamic>{},
      ).timeout(
        Methods.sendRequest.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      if (json == null) {
        return <String, dynamic>{};
      }

      return jsonDecode(json) as Map<String, dynamic>;
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> revoke() async {
    try {
      final String? json = await _channel.invokeMethod<String>(
        WebAuthnMethods.revoke.methodName,
        <String, dynamic>{},
      ).timeout(
        Methods.sendRequest.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      if (json == null) {
        return <String, dynamic>{};
      }

      return jsonDecode(json) as Map<String, dynamic>;
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> passkeyRevoke(String id) async {
    try {
      final String? json = await _channel.invokeMethod<String>(
        WebAuthnMethods.passkeyRevoke.methodName,
        <String, dynamic>{
          'id': id,
        },
      ).timeout(
        Methods.sendRequest.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      if (json == null) {
        return <String, dynamic>{};
      }

      return jsonDecode(json) as Map<String, dynamic>;
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> passkeyGetCredentials() async {
    try {
      final String? json = await _channel.invokeMethod<String>(
        WebAuthnMethods.passkeyGetCredentials.methodName,
        <String, dynamic>{},
      ).timeout(
        Methods.sendRequest.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      if (json == null) {
        return <String, dynamic>{};
      }

      return jsonDecode(json) as Map<String, dynamic>;
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }
}
