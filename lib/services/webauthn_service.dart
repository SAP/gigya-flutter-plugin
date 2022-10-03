import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../gigya_flutter_plugin.dart';
import '../mixin/global_mixin.dart';
import '../models/gigya_models.dart';

enum WebAuthnMethods {
  webAuthnLogin,
  webAuthnRegister,
  webAuthnRevoke
}

extension MethodsExt on WebAuthnMethods {
  get name => describeEnum(this);
}

class WebAuthnService with DataMixin, GigyaResponseMixin {
  final MethodChannel _channel;

  WebAuthnService(this._channel);

  /// Login using WebAuthn/FIDO combination.
  Future<Map<String, dynamic>?> webAuthnLogin() async {
    final result = await _channel.invokeMapMethod<String, dynamic>(
      WebAuthnMethods.webAuthnLogin.name,
      {},
    ).catchError((error) {
      debugPrint('error');
      return throw GigyaResponse.fromJson(decodeError(error));
    }).timeout(getTimeout(Methods.sendRequest), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return timeoutError();
    });
    return result;
  }

  /// Register using WebAuthn/FIDO combination.
  Future<Map<String, dynamic>?> webAuthnRegister() async {
    final json = await _channel.invokeMethod<String>(
      WebAuthnMethods.webAuthnRegister.name,
      {},
    ).catchError((error) {
      return throw GigyaResponse.fromJson(decodeError(error));
    }).timeout(getTimeout(Methods.sendRequest), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return jsonEncode(timeoutError());
    });
    return json != null ? jsonDecode(json) : null;
  }

  /// Revoke WebAuthn/FIDO.
  Future<Map<String, dynamic>?> webAuthnRevoke() async {
    final json = await _channel.invokeMethod<String>(
      WebAuthnMethods.webAuthnRevoke.name,
      {},
    ).catchError((error) {
      return throw GigyaResponse.fromJson(decodeError(error));
    }).timeout(getTimeout(Methods.sendRequest), onTimeout: () {
      debugPrint('A timeout that was defined in the request is reached');
      return jsonEncode(timeoutError());
    });
    return json != null ? jsonDecode(json) : null;
  }
}