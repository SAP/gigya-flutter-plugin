import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../mixin/global_mixin.dart';
import '../models/gigya_models.dart';

enum OtpMethods {
  login,
  update,
  verify,
}

extension OtpMethodsExtension on OtpMethods {
  String get name {
    switch (this) {
      case OtpMethods.login:
        return 'otpLogin';
      case OtpMethods.update:
        return 'otpUpdate';
      case OtpMethods.verify:
        return 'otpVerify';
    }
  }
}

class OtpService with DataMixin, GigyaResponseMixin {
  final MethodChannel _channel;

  OtpService(this._channel);

  /// Login using otp phone combination.
  ///
  /// Optional [params] map is available.
  Future<PendingOtpVerification> login(phone, {params}) async {
    final result = await _channel.invokeMapMethod<String, dynamic>(
      OtpMethods.login.name,
      {
        'phone': phone,
        'parameters': params ?? {},
      },
    ).catchError((error) {
      debugPrint('error');
      return throw GigyaResponse.fromJson(decodeError(error));
    }).timeout(Duration(minutes: 1), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return timeoutError();
    });
    return PendingOtpVerification(_channel);
  }

  /// Update using otp phone combination.
  ///
  /// Optional [params] map is available.
  Future<Map<String, dynamic>?> update(phone, {params}) async {
    final result = await _channel.invokeMapMethod<String, dynamic>(
      OtpMethods.update.name,
      {
        'phone': phone,
        'parameters': params ?? {},
      },
    ).catchError((error) {
      debugPrint('error');
      return throw GigyaResponse.fromJson(decodeError(error));
    }).timeout(Duration(minutes: 1), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return timeoutError();
    });
    return result;
  }
}

/// Verify OTP resolver
class PendingOtpVerification with GigyaResponseMixin, DataMixin {
  final MethodChannel _channel;

  PendingOtpVerification(this._channel);

  Future<Map<String, dynamic>?> verify(code) async {
    final result = await _channel.invokeMapMethod<String, dynamic>(
      OtpMethods.verify.name,
      {
        'code': code,
      },
    ).catchError((error) {
      throw GigyaResponse.fromJson(decodeError(error));
    });
    return result;
  }
}
