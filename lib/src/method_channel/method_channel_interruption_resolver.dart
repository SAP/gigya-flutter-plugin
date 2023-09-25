import 'package:flutter/services.dart' show MethodChannel, PlatformException;

import '../models/conflicting_account.dart';
import '../models/enums/methods.dart';
import '../models/enums/social_provider.dart';
import '../models/gigya_error.dart';
import '../services/interruption_resolver.dart';

/// This class represents an [InterruptionResolver] that uses a [MethodChannel]
/// for its implementation.
class MethodChannelInterruptionResolverFactory
    extends InterruptionResolverFactory {
  /// The default constructor.
  const MethodChannelInterruptionResolverFactory(this._channel);

  final MethodChannel _channel;

  @override
  InterruptionResolver? fromErrorCode(GigyaError exception) {
    // TODO: create an enum for these error codes. See web_error_code.dart.
    switch (exception.errorCode) {
      case 403043:
        return _MethodChannelLinkAccountResolver(_channel);
      case 206001:
        return _MethodChannelPendingRegistrationResolver(_channel);
      case 206002:
        return PendingVerificationResolver(exception.registrationToken ?? '');
      default:
        return null;
    }
  }
}

class _MethodChannelLinkAccountResolver extends LinkAccountResolver {
  _MethodChannelLinkAccountResolver(this._channel) {
    _conflictingAccount = _getConflictingAccount();
  }

  final MethodChannel _channel;

  late final Future<ConflictingAccount>? _conflictingAccount;

  @override
  Future<ConflictingAccount>? get conflictingAccount => _conflictingAccount;

  /// Get the conflicting account for the user.
  Future<ConflictingAccount> _getConflictingAccount() async {
    try {
      final Map<String, dynamic>? result =
          await _channel.invokeMapMethod<String, dynamic>(
        Methods.getConflictingAccounts.methodName,
      );

      return ConflictingAccount.fromJson(result ?? const <String, dynamic>{});
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
          await _channel.invokeMapMethod<String, dynamic>(
        Methods.linkToSite.methodName,
        <String, dynamic>{
          'loginId': loginId,
          'password': password,
        },
      );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> linkToSocial(SocialProvider provider) async {
    try {
      final Map<String, dynamic>? result =
          await _channel.invokeMapMethod<String, dynamic>(
        Methods.linkToSocial.methodName,
        <String, dynamic>{'provider': provider.name},
      );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }
}

class _MethodChannelPendingRegistrationResolver
    extends PendingRegistrationResolver {
  /// The default constructor.
  const _MethodChannelPendingRegistrationResolver(this._channel);

  final MethodChannel _channel;

  @override
  Future<Map<String, dynamic>> setAccount(
    Map<String, dynamic> parameters,
  ) async {
    try {
      final Map<String, dynamic>? result =
          await _channel.invokeMapMethod<String, dynamic>(
        Methods.resolveSetAccount.methodName,
        parameters,
      );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }
}
