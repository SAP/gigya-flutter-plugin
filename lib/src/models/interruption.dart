import 'package:flutter/services.dart' show MethodChannel, PlatformException;

import 'conflicting_accounts.dart';
import 'enums/methods.dart';
import 'enums/social_provider.dart';
import 'gigya_error.dart';

/// This interface represents the base interruption resolver.
abstract class InterruptionResolver {
  /// The default constructor.
  const InterruptionResolver();
}

/// The resolver factory for interruptions.
class InterruptionResolverFactory {
  /// The default constructor.
  const InterruptionResolverFactory(this._channel);

  final MethodChannel _channel;

  /// Get an [InterruptionResolver] for the given [GigyaError.errorCode].
  InterruptionResolver? fromErrorCode(GigyaError exception) {
    switch (exception.errorCode) {
      case 403043:
        return LinkAccountResolver(_channel);
      case 206001:
        return PendingRegistrationResolver(_channel);
      case 206002:
        return PendingVerificationResolver(exception.registrationToken ?? '');
      default:
        return null;
    }
  }
}

/// The resolver for a link account flow interruption.
class LinkAccountResolver extends InterruptionResolver {
  /// The default constructor.
  LinkAccountResolver(this._channel) {
    conflictingAccounts = _getConflictingAccounts();
  }

  final MethodChannel _channel;

  /// The conflicting accounts of the user.
  late final Future<ConflictingAccounts> conflictingAccounts;

  /// Get the conflicting accounts for the user.
  Future<ConflictingAccounts> _getConflictingAccounts() async {
    final Map<String, dynamic>? result =
        await _channel.invokeMapMethod<String, dynamic>(
      Methods.getConflictingAccounts.methodName,
    );

    return ConflictingAccounts.fromJson(result ?? <String, dynamic>{});
  }

  /// Link a social account to an existing site account.
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

      return result ?? <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  /// Link a site account to an existing social account.
  Future<Map<String, dynamic>> linkToSocial(SocialProvider provider) async {
    try {
      final Map<String, dynamic>? result =
          await _channel.invokeMapMethod<String, dynamic>(
        Methods.linkToSocial.methodName,
        <String, dynamic>{'provider': provider.name},
      );

      return result ?? <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }
}

/// The resolver for a registration interruption.
class PendingRegistrationResolver extends InterruptionResolver {
  /// The default constructor.
  const PendingRegistrationResolver(this._channel);

  final MethodChannel _channel;

  /// Set the user account using the given [parameters].
  Future<Map<String, dynamic>> setAccount(
    Map<String, dynamic> parameters,
  ) async {
    try {
      final Map<String, dynamic>? result =
          await _channel.invokeMapMethod<String, dynamic>(
        Methods.resolveSetAccount.methodName,
        parameters,
      );

      return result ?? <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }
}

/// The resolver for a pending verification interuption.
class PendingVerificationResolver extends InterruptionResolver {
  /// The default constructor.
  const PendingVerificationResolver(this.registrationToken);

  /// The registration token of this resolver.
  ///
  /// This token can be used to resolve the registration interruption.
  final String registrationToken;
}
