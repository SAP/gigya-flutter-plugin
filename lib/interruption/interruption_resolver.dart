import 'package:flutter/services.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';
import 'package:gigya_flutter_plugin/models/gigya_models.dart';

/// Determines the relevant interruption resolver according to given error.
class ResolverFactory {
  final MethodChannel _channel;

  ResolverFactory(this._channel);

  dynamic getResolver(GigyaResponse response) {
    switch (response.errorCode) {
      case 403043:
        return LinkAccountResolver(_channel);
      case 206001:
        return PendingRegistrationResolver(_channel);
      case 206002:
        return PendingVerificationResolver(response.regToken);
      default:
        return null;
    }
  }
}

/// Resolver used for link account flow interruption.
class LinkAccountResolver with DataMixin {
  final MethodChannel _channel;

  LinkAccountResolver(this._channel) {
    getConflictingAccounts();
  }

  /// Get the user conflicting account object to determine how to resolve the flow.
  Future<ConflictingAccounts> getConflictingAccounts() => _channel
      .invokeMapMethod<String, dynamic>('getConflictingAccounts')
      .then((value) => ConflictingAccounts.fromJson(value ?? {}));

  /// Link social account to existing site account.
  Future<Map<String, dynamic>?> linkToSite(String loginId, String password) =>
      _channel.invokeMapMethod<String, dynamic>('linkToSite', {
        'loginId': loginId,
        'password': password,
      }).catchError((error) {
        throw GigyaResponse.fromJson(decodeError(error));
      });

  /// Link site account to existing social account.
  Future<Map<String, dynamic>?> linkToSocial(SocialProvider provider) =>
      _channel.invokeMapMethod<String, dynamic>('linkToSocial', {
        'provider': provider.name,
      }).catchError((error) {
        throw GigyaResponse.fromJson(decodeError(error));
      });
}

/// Resolver used for pending registration interruption.
class PendingRegistrationResolver with DataMixin {
  final MethodChannel _channel;

  PendingRegistrationResolver(this._channel);

  /// Set the missing account data in order to resolve the interruption.
  Future<Map<String, dynamic>?> setAccount(Map<String, dynamic> map) => _channel
          .invokeMapMethod<String, dynamic>('resolveSetAccount', map)
          .catchError((error) {
        print('setAccount Error: $error');
        throw GigyaResponse.fromJson(decodeError(error));
      });
}

/// Resolver used for pending verification interruption.
///
/// Use available [regToken] value to resolve.
class PendingVerificationResolver {
  final String? _regToken;

  PendingVerificationResolver(this._regToken);

  String? get regToken => _regToken;
}
