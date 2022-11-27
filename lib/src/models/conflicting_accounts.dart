/// This class represents a model that is used to resolve an account conflict.
class ConflictingAccounts {
  /// The private constructor.
  const ConflictingAccounts._(this.loginID, this.loginProviders);

  /// The default constructor.
  factory ConflictingAccounts.fromJson(Map<String, dynamic> json) {
    // Lists coming from `jsonDecode` always have dynamic as type.
    final List<dynamic>? providers = json['loginProviders'] as List<dynamic>?;

    return ConflictingAccounts._(
      json['loginID'] as String?,
      providers?.cast<String>() ?? <String>[],
    );
  }

  /// The login id of the user.
  final String? loginID;

  /// The list of login providers
  /// that can be used to resolve the account conflict.
  final List<String> loginProviders;
}
