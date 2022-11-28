import 'package:flutter/services.dart';
import 'package:gigya_flutter_plugin/src/models/gigya_error.dart';

import '../models/enums/methods.dart';

/// This service defines an OTP login service.
class OtpService {
  /// The default constructor.
  const OtpService(this._channel);

  final MethodChannel _channel;

  final Duration _timeout = const Duration(minutes: 1);

  /// Login using the given [phone] number.
  ///
  /// To complete the login flow, call [PendingOtpVerification.verify]
  /// with the code that was sent to the user.
  ///
  /// Returns a [PendingOtpVerification].
  Future<PendingOtpVerification> login(
    String phone, {
    Map<String, dynamic> params = const <String, dynamic>{},
  }) async {
    try {
      await _channel.invokeMapMethod<String, dynamic>(
        OtpMethods.login.methodName,
        <String, dynamic>{'phone': phone, 'parameters': params},
      ).timeout(
        _timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return PendingOtpVerification(_channel);
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  /// Update the login information using the given [phone] number.
  Future<Map<String, dynamic>> update(
    String phone, {
    Map<String, dynamic> params = const <String, dynamic>{},
  }) async {
    try {
      final Map<String, dynamic>? result =
          await _channel.invokeMapMethod<String, dynamic>(
        OtpMethods.update.methodName,
        <String, dynamic>{'phone': phone, 'parameters': params},
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

/// This class represents a pending OTP verification,
///  which can be used to finish a login over telephone.
class PendingOtpVerification {
  /// The default constructor.
  PendingOtpVerification(this._channel);

  final MethodChannel _channel;

  /// Verify the given [code] and finish the current user login.
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
