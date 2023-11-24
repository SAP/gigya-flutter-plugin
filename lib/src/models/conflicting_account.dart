/// This class represents a model that is used to resolve an account conflict.
class ConflictingAccount {
  /// The default constructor.
  const ConflictingAccount({
    this.loginID,
    this.loginProviders = const <String>[],
  });

  /// The default constructor.
  factory ConflictingAccount.fromJson(Map<String, dynamic> json) {
    // Lists coming from `jsonDecode` always have dynamic as type.
    final List<dynamic>? providers = json['loginProviders'] as List<dynamic>?;

    return ConflictingAccount(
      loginID: json['loginID'] as String?,
      loginProviders: providers?.cast<String>() ?? <String>[],
    );
  }

  /// The login id of the user.
  final String? loginID;

  /// The list of login providers
  /// that can be used to resolve the account conflict.
  final List<String> loginProviders;
}
