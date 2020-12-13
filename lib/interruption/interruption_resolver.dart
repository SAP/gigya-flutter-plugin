import 'package:flutter/services.dart';
import 'package:gigya_flutter_plugin/gigya_flutter_plugin.dart';
import 'package:gigya_flutter_plugin/models/gigya_models.dart';

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

class LinkAccountResolver with DataMixin {
  final MethodChannel _channel;

  LinkAccountResolver(this._channel) {
    getConflictingAccounts();
  }

  Future<ConflictingAccounts> getConflictingAccounts() async {
    Map<String, dynamic> map =  await _channel.invokeMapMethod<String, dynamic>('getConflictingAccounts');
    return ConflictingAccounts.fromJson(map);
  }

  Future<Account> linkToSite(String loginId, String password) async {
    final Map<String, dynamic> res = await _channel.invokeMapMethod<String, dynamic>('linkToSite', {
      'loginId': loginId,
      'password': password,
    }).catchError((error) {
      throw GigyaResponse.fromJson(decodeError(error));
    });
    final Account account = Account.fromJson(res);
    return account;
  }

  Future<Account> linkToSocial(SocialProvider provider) async {
    final Map<String, dynamic> res = await _channel.invokeMapMethod<String, dynamic>('linkToSocial', {
      'provider': provider.name,
    }).catchError((error) {
      throw GigyaResponse.fromJson(decodeError(error));
    });
    final Account account = Account.fromJson(res);
    return account;
  }
}

class PendingRegistrationResolver with DataMixin {
  final MethodChannel _channel;

  PendingRegistrationResolver(this._channel);

  Future<Account> setAccount(Map<String, dynamic> map) async {
    final Map<String, dynamic> res = await _channel.invokeMapMethod<String, dynamic>('resolveSetAccount', {
      map,
    }).catchError((error) {
      throw GigyaResponse.fromJson(decodeError(error));
    });
    final Account account = Account.fromJson(res);
    return account;
  }
}

class PendingVerificationResolver {
  final String _regToken;

  PendingVerificationResolver(this._regToken);

  String get regToken => _regToken;
}
