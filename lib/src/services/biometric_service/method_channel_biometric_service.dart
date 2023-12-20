import 'package:flutter/services.dart' show MethodChannel, PlatformException;
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';

import '../../models/enums/methods.dart';

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
  Future<void> optIn({
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) async {
    try {
      return await _channel
          .invokeMethod<void>(
            BiometricMethods.optIn.methodName,
            parameters,
          )
          .timeout(
            BiometricMethods.optIn.timeout,
            onTimeout: () => throw const GigyaTimeoutError(),
          );
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<void> optOut({
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) async {
    try {
      return await _channel
          .invokeMethod<void>(
            BiometricMethods.optOut.methodName,
            parameters,
          )
          .timeout(
            BiometricMethods.optOut.timeout,
            onTimeout: () => throw const GigyaTimeoutError(),
          );
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<void> lockSession() async {
    try {
      return await _channel.invokeMethod<void>(
        BiometricMethods.lockSession.methodName,
      );
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<void> unlockSession({
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) async {
    try {
      return await _channel
          .invokeMethod<void>(
            BiometricMethods.unlockSession.methodName,
            parameters,
          )
          .timeout(
            BiometricMethods.unlockSession.timeout,
            onTimeout: () => throw const GigyaTimeoutError(),
          );
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }
}
