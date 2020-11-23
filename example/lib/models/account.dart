import 'package:gigya_flutter_plugin/models/gigya_models.dart';

/// Specific response object for login flow.
/// Object represents the account schema object and can be extended accordingly.
class AccountResponse extends GigyaResponse {
  String _uid;

  String get uid => _uid;

  AccountResponse.fromJson(dynamic json) : super.fromJson(json) {
    _uid = json["UID"];
  }
}