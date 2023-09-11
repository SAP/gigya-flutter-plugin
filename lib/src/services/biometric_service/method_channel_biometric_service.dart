import 'package:flutter/services.dart' show MethodChannel, PlatformException;
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';

import '../../models/enums/methods.dart';
import 'biometric_service.dart';

/// This class represents a [BiometricService] that uses a [MethodChannel]
/// for its implementation.
class MethodChannelBiometricService extends BiometricService {
  /// The default constructor.
  const MethodChannelBiometricService(this._channel);

  final MethodChannel _channel;

  @override
  Future<bool> isAvailable() async {
    try {
      final bool? result = await _channel.invokeMethod<bool>(
        BiometricMethods.isAvailable.methodName,
      );

      return result ?? false;
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<bool> isLocked() async {
    try {
      final bool? result = await _channel.invokeMethod<bool>(
        BiometricMethods.isLocked.methodName,
      );

      return result ?? false;
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<bool> isOptIn() async {
    try {
      final bool? result = await _channel.invokeMethod<bool>(
        BiometricMethods.isOptIn.methodName,
      );

      return result ?? false;
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<bool> optIn({
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) async {
    try {
      final bool? result = await _channel
          .invokeMethod<bool>(
            BiometricMethods.optIn.methodName,
            parameters,
          )
          .timeout(
            BiometricMethods.optIn.timeout,
            onTimeout: () => throw const GigyaTimeoutError(),
          );

      return result ?? false;
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<bool> optOut({
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) async {
    try {
      final bool? result = await _channel
          .invokeMethod<bool>(
            BiometricMethods.optOut.methodName,
            parameters,
          )
          .timeout(
            BiometricMethods.optOut.timeout,
            onTimeout: () => throw const GigyaTimeoutError(),
          );

      return result ?? false;
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<bool> lockSession() async {
    try {
      final bool? result = await _channel.invokeMethod<bool>(
        BiometricMethods.lockSession.methodName,
      );

      return result ?? false;
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<bool> unlockSession({
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) async {
    try {
      final bool? result = await _channel
          .invokeMethod<bool>(
            BiometricMethods.unlockSession.methodName,
            parameters,
          )
          .timeout(
            BiometricMethods.unlockSession.timeout,
            onTimeout: () => throw const GigyaTimeoutError(),
          );

      return result ?? false;
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }
}
