import 'package:flutter/services.dart' show MethodChannel, PlatformException;

import '../../models/enums/methods.dart';
import '../../models/gigya_error.dart';
import 'otp_service.dart';

/// This class represents an [OtpService] that uses a [MethodChannel]
/// for its implementation.
class MethodChannelOtpService extends OtpService {
  /// The default constructor.
  const MethodChannelOtpService(this._channel);

  final MethodChannel _channel;

  final Duration _timeout = const Duration(minutes: 1);

  @override
  Future<PendingOtpVerification> login(
    String phone, {
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) async {
    try {
      await _channel.invokeMethod<void>(
        OtpMethods.login.methodName,
        <String, dynamic>{'phone': phone, 'parameters': parameters},
      ).timeout(
        _timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return _MethodChannelPendingVerification(_channel);
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> update(
    String phone, {
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) async {
    try {
      final Map<String, dynamic>? result =
          await _channel.invokeMapMethod<String, dynamic>(
        OtpMethods.update.methodName,
        <String, dynamic>{'phone': phone, 'parameters': parameters},
      ).timeout(
        _timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return result ?? <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }
}

/// This class represents a [PendingOtpVerification] that uses a [MethodChannel]
/// for its implementation.
class _MethodChannelPendingVerification extends PendingOtpVerification {
  /// The default constructor.
  _MethodChannelPendingVerification(this._channel);

  final MethodChannel _channel;

  @override
  Future<Map<String, dynamic>> verify(String code) async {
    try {
      final Map<String, dynamic>? result =
          await _channel.invokeMapMethod<String, dynamic>(
        OtpMethods.verify.methodName,
        <String, dynamic>{'code': code},
      );

      return result ?? <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }
}
