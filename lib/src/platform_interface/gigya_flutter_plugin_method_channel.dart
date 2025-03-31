import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/enums/methods.dart';
import '../models/enums/social_provider.dart';
import '../models/gigya_error.dart';
import '../models/screenset_event.dart';
import '../services/biometric_service/biometric_service.dart';
import '../services/biometric_service/method_channel_biometric_service.dart';
import '../services/interruption_resolver/interruption_resolver.dart';
import '../services/interruption_resolver/method_channel_interruption_resolver.dart';
import '../services/otp_service/method_channel_otp_service.dart';
import '../services/otp_service/otp_service.dart';
import '../services/web_authentication_service/method_channel_web_authentication_service.dart';
import '../services/web_authentication_service/web_authentication_service.dart';
import 'gigya_flutter_plugin_platform_interface.dart';

/// An implementation of [GigyaFlutterPluginPlatform] that uses method channels.
class MethodChannelGigyaFlutterPlugin extends GigyaFlutterPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final MethodChannel methodChannel = const MethodChannel(
    'com.sap.gigya_flutter_plugin/methods',
  );

  /// The event channel that provides the stream of screen set events.
  @visibleForTesting
  final EventChannel screenSetEvents = const EventChannel(
    'com.sap.gigya_flutter_plugin/screenSetEvents',
  );

  @override
  InterruptionResolverFactory get interruptionResolverFactory {
    return MethodChannelInterruptionResolverFactory(methodChannel);
  }

  @override
  OtpService get otpService => MethodChannelOtpService(methodChannel);

  @override
  WebAuthenticationService get webAuthenticationService {
    return MethodChannelWebAuthenticationService(methodChannel);
  }

  @override
  BiometricService get biometricService {
    return MethodChannelBiometricService(methodChannel);
  }

  @override
  Future<Map<String, dynamic>> addConnection(SocialProvider provider) async {
    try {
      final Map<String, dynamic>? result =
          await methodChannel.invokeMapMethod<String, dynamic>(
        Methods.addConnection.methodName,
        <String, dynamic>{'provider': provider.name},
      ).timeout(
        Methods.addConnection.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> forgotPassword(String loginId) async {
    try {
      final Map<String, dynamic>? result =
          await methodChannel.invokeMapMethod<String, dynamic>(
        Methods.forgotPassword.methodName,
        <String, dynamic>{'loginId': loginId},
      ).timeout(
        Methods.forgotPassword.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> getAccount({
    bool invalidate = false,
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) async {
    try {
      final Map<String, dynamic>? result =
          await methodChannel.invokeMapMethod<String, dynamic>(
        Methods.getAccount.methodName,
        <String, dynamic>{
          'invalidate': invalidate,
          'parameters': parameters,
        },
      ).timeout(
        Methods.getAccount.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> getSession() async {
    try {
      final Map<String, dynamic>? result = await methodChannel
          .invokeMapMethod<String, dynamic>(Methods.getSession.methodName)
          .timeout(
            Methods.getSession.timeout,
            onTimeout: () => throw const GigyaTimeoutError(),
          );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<void> initSdk({
    required String apiDomain,
    required String apiKey,
    String? cname,
    bool forceLogout = true,
  }) async {
    // First, initialize the Gigya SDK.
    try {
      await methodChannel.invokeMethod<void>(
        Methods.initSdk.methodName,
        <String, dynamic>{
          'apiKey': apiKey,
          'apiDomain': apiDomain,
          'cname': cname
        },
      ).timeout(
        Methods.initSdk.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }

    // Then logout if requested.
    if (forceLogout) {
      await logout();
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final bool? result = await methodChannel.invokeMethod<bool>(
        Methods.isLoggedIn.methodName,
      );

      return result ?? false;
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> linkToSite({
    required String loginId,
    required String password,
  }) async {
    try {
      final Map<String, dynamic>? result =
          await methodChannel.invokeMapMethod<String, dynamic>(
        Methods.linkToSite.methodName,
        <String, dynamic>{
          'loginId': loginId,
          'password': password,
        },
      ).timeout(
        Methods.linkToSite.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> login({
    required String loginId,
    required String password,
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) async {
    try {
      final Map<String, dynamic>? result =
          await methodChannel.invokeMapMethod<String, dynamic>(
        Methods.loginWithCredentials.methodName,
        <String, dynamic>{
          'loginId': loginId,
          'password': password,
          'parameters': parameters,
        },
      ).timeout(
        Methods.loginWithCredentials.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await methodChannel.invokeMethod<void>(Methods.logOut.methodName).timeout(
            Methods.logOut.timeout,
            onTimeout: () => throw const GigyaTimeoutError(),
          );
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> register({
    required String loginId,
    required String password,
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) async {
    try {
      final Map<String, dynamic>? result =
          await methodChannel.invokeMapMethod<String, dynamic>(
        Methods.registerWithCredentials.methodName,
        <String, dynamic>{
          'email': loginId,
          'password': password,
          'parameters': parameters,
        },
      ).timeout(
        Methods.registerWithCredentials.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> removeConnection(SocialProvider provider) async {
    try {
      final Map<String, dynamic>? result =
          await methodChannel.invokeMapMethod<String, dynamic>(
        Methods.removeConnection.methodName,
        <String, dynamic>{'provider': provider.name},
      ).timeout(
        Methods.removeConnection.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> send(
    String endpoint, {
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) async {
    try {
      final String? json = await methodChannel.invokeMethod<String>(
        Methods.sendRequest.methodName,
        <String, dynamic>{
          'endpoint': endpoint,
          'parameters': parameters,
        },
      ).timeout(
        Methods.sendRequest.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      if (json == null) {
        return const <String, dynamic>{};
      }

      return jsonDecode(json) as Map<String, dynamic>;
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> setAccount(Map<String, dynamic> account) async {
    try {
      final Map<String, dynamic>? result =
          await methodChannel.invokeMapMethod<String, dynamic>(
        Methods.setAccount.methodName,
        <String, dynamic>{'account': account},
      ).timeout(
        Methods.setAccount.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<void> setSession({
    required int expiresIn,
    required String sessionSecret,
    required String sessionToken,
  }) {
    try {
      return methodChannel.invokeMethod<void>(
        Methods.setSession.methodName,
        <String, dynamic>{
          'sessionToken': sessionToken,
          'sessionSecret': sessionSecret,
          'expires_in': expiresIn,
        },
      ).timeout(
        Methods.setSession.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Stream<ScreensetEvent> showScreenSet(
    String name, {
    Map<String, dynamic> parameters = const <String, dynamic>{},
    bool isDebug = false,
  }) async* {
    try {
      await methodChannel.invokeMethod<void>(
        Methods.showScreenSet.methodName,
        <String, dynamic>{
          'screenSet': name,
          'parameters': parameters,
          'isDebug': isDebug,
        },
      );
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }

    yield* screenSetEvents.receiveBroadcastStream().map((dynamic event) {
      // The binary messenger sends things back as `dynamic`.
      // If the event is a `Map`,
      // it does not have type information and comes back as `Map<Object?, Object?>`.
      // Cast it using `Map.cast()` to at least recover the type of the key.
      // The values are still `Object?`, though.
      final Map<String, Object?> typedEvent =
          (event as Map<Object?, Object?>).cast<String, Object?>();

      // Now grab the data of the event,
      // using `Map.cast()` to recover the type of the keys.
      final Map<String, Object?>? data =
          (typedEvent['data'] as Map<Object?, Object?>?)
              ?.cast<String, Object?>();

      return ScreensetEvent(
        typedEvent['event'] as String,
        data ?? <String, Object?>{},
      );
    });
  }

  @override
  Future<void> dismissScreenSet() async {
    try {
      await methodChannel
          .invokeMethod<void>(Methods.dismissScreenSet.methodName);
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> socialLogin(
    SocialProvider provider, {
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) async {
    try {
      final Map<String, dynamic>? result =
          await methodChannel.invokeMapMethod<String, dynamic>(
        Methods.socialLogin.methodName,
        <String, dynamic>{
          'provider': provider.name,
          'parameters': parameters,
        },
      ).timeout(
        Methods.socialLogin.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> sso({
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) async {
    try {
      final Map<String, dynamic>? result =
          await methodChannel.invokeMapMethod<String, dynamic>(
        Methods.sso.methodName,
        <String, dynamic>{
          'provider': 'sso',
          'parameters': parameters,
        },
      );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<String?> getAuthCode() async {
    try {
      final String? result = await methodChannel
          .invokeMethod<String>(Methods.getAuthCode.methodName);
      return result;
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }
}
