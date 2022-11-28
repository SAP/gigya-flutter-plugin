import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:gigya_flutter_plugin/src/models/gigya_error.dart';

import '../models/enums/methods.dart';

/// This service defines a Web Authentication service.
class WebAuthnService {
  /// The default constructor.
  const WebAuthnService(this._channel);

  final MethodChannel _channel;

  /// Login using WebAuthn/FIDO combination.
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

  /// Register using WebAuthn/FIDO combination.
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

  /// Revoke WebAuthn/FIDO authentication.
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
}
