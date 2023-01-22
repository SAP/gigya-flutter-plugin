import 'emails.dart';
import 'profile.dart';
import 'session_info.dart';

/// This class represents an account.
class Account {
  /// The default constructor.
  Account({
    required this.emails,
    this.created,
    this.createdTimestamp,
    this.isActive,
    this.isRegistered,
    this.isVerified,
    this.lastLoginTimestamp,
    this.lastUpdatedTimestamp,
    this.loginProvider,
    this.oldestUpdateTimestamp,
    this.profile,
    this.registered,
    this.registeredTimestamp,
    this.sessionInfo,
    this.signatureTimestamp,
    this.socialProviders,
    this.uid,
    this.uidSignature,
    this.verified,
    this.verifiedTimestamp,
  });

  /// Construct an account from the given [json].
  factory Account.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? emails =
        json['emails'] as Map<String, dynamic>?;
    final Map<String, dynamic>? profile =
        json['profile'] as Map<String, dynamic>?;
    final Map<String, dynamic>? session =
        json['sessionInfo'] as Map<String, dynamic>?;

    return Account(
      emails: emails == null ? const Emails() : Emails.fromJson(emails),
      created: json['created'] as String?,
      createdTimestamp: json['createdTimestamp'] as Object?,
      isActive: json['isActive'] as bool?,
      isRegistered: json['isRegistered'] as bool?,
      isVerified: json['isVerified'] as bool?,
      lastLoginTimestamp: json['lastLoginTimestamp'] as Object?,
      lastUpdatedTimestamp: json['lastUpdatedTimestamp'] as Object?,
      loginProvider: json['loginProvider'] as String?,
      oldestUpdateTimestamp: json['oldestDataUpdatedTimestamp'] as Object?,
      profile: profile == null ? null : Profile.fromJson(profile),
      registered: json['registered'] as String?,
      registeredTimestamp: json['registeredTimestamp'] as Object?,
      sessionInfo: session == null ? null : SessionInfo.fromJson(session),
      signatureTimestamp: json['signatureTimestamp'] as Object?,
      socialProviders: json['socialProviders'] as String?,
      uid: json['UID'] as String?,
      uidSignature: json['UIDSignature'] as String?,
      verified: json['verified'] as String?,
      verifiedTimestamp: json['verifiedTimestamp'] as Object?,
    );
  }

  /// The created status of the account.
  final String? created;

  /// The creation timestamp of the account.
  final Object? createdTimestamp; // TODO: this should be a `DateTime?`.

  /// Whether this account is active.
  final bool? isActive;

  /// Whether this account is registered.
  final bool? isRegistered;

  /// Whether this account is verified.
  final bool? isVerified;

  /// The list of email addresses for the account.
  final Emails emails;

  /// The timestamp of the last login.
  final Object? lastLoginTimestamp; // TODO: this should be a `DateTime?`.

  /// The timestamp of the last update.
  final Object? lastUpdatedTimestamp; // TODO: this should be a `DateTime?`.

  /// The name of current login provider for this account.
  ///
  /// If the user logged in using a custom site login mechanism,
  /// then the value of this attribute will be `site`.
  final String? loginProvider;

  /// The timestamp of the oldest data update.
  final Object? oldestUpdateTimestamp; // TODO: this should be a `DateTime?`.

  /// The profile linked to this account.
  final Profile? profile;

  /// The registered status of the account.
  final String? registered;

  /// The timestamp of the account registration.
  final Object? registeredTimestamp; // TODO: this should be a `DateTime?`.

  /// The session info for the account.
  final SessionInfo? sessionInfo;

  /// The timestamp of the [uidSignature].
  final Object? signatureTimestamp; // TODO: this should be a `DateTime?`.

  /// The social providers linked to this account.
  final String? socialProviders; // TODO: This should be a `List<String>`

  /// The UID of the account.
  final String? uid;

  /// The UID signature of the account.
  final String? uidSignature;

  /// The verified status of this account.
  final String? verified;

  /// The timestamp of the [verified] status.
  final Object? verifiedTimestamp; // TODO: this should be a `DateTime?`.

  /// Convert this object into a JSON object.
  Map<String, dynamic> toJson() {
    final Profile? accountProfile = profile;
    final SessionInfo? session = sessionInfo;

    return <String, dynamic>{
      'created': created,
      'createdTimestamp': createdTimestamp?.toString(),
      'emails': emails.toJson(),
      'isActive': isActive,
      'isRegistered': isRegistered,
      'isVerified': isVerified,
      'lastLoginTimestamp': lastLoginTimestamp?.toString(),
      'lastUpdatedTimestamp': lastUpdatedTimestamp?.toString(),
      'loginProvider': loginProvider,
      'oldestDataUpdatedTimestamp': oldestUpdateTimestamp?.toString(),
      if (accountProfile != null) 'profile': accountProfile.toJson(),
      'registered': registered,
      'registeredTimestamp': registeredTimestamp?.toString(),
      if (session != null) 'sessionInfo': session.toJson(),
      'signatureTimestamp': signatureTimestamp?.toString(),
      'socialProviders': socialProviders,
      'UID': uid,
      'UIDSignature': uidSignature,
      'verified': verified,
      'verifiedTimestamp': verifiedTimestamp?.toString(),
    };
  }
}
