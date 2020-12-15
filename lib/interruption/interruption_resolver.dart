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

  Future<Map<String, dynamic>> linkToSite(String loginId, String password) async {
    final Map<String, dynamic> res = await _channel.invokeMapMethod<String, dynamic>('linkToSite', {
      'loginId': loginId,
      'password': password,
    }).catchError((error) {
      throw GigyaResponse.fromJson(decodeError(error));
    });
    return res;
  }

  Future<Map<String, dynamic>> linkToSocial(SocialProvider provider) async {
    final Map<String, dynamic> res = await _channel.invokeMapMethod<String, dynamic>('linkToSocial', {
      'provider': provider.name,
    }).catchError((error) {
      throw GigyaResponse.fromJson(decodeError(error));
    });
    return res;
  }
}

class PendingRegistrationResolver with DataMixin {
  final MethodChannel _channel;

  PendingRegistrationResolver(this._channel);

  Future<Map<String, dynamic>> setAccount(Map<String, dynamic> map) async {
    final Map<String, dynamic> res = await _channel.invokeMapMethod<String, dynamic>('resolveSetAccount', {
      map,
    }).catchError((error) {
      throw GigyaResponse.fromJson(decodeError(error));
    });
    return res;
  }
}

class PendingVerificationResolver {
  final String _regToken;

  PendingVerificationResolver(this._regToken);

  String get regToken => _regToken;
}
