import 'emails.dart';
import 'profile.dart';

/// This class represents an account.
class Account {
  /// The default constructor.
  Account({
    required this.emails,
    this.createdTimestamp,
    this.isActive,
    this.isRegistered,
    this.isVerified,
    this.lastLoginTimestamp,
    this.lastUpdatedTimestamp,
    this.loginProvider,
    this.oldestDataUpdateTimestamp,
    this.profile,
    this.registeredTimestamp,
    this.signatureTimestamp,
    this.socialProviders = const <String>[],
    this.uid,
    this.uidSignature,
    this.verifiedTimestamp,
  });

  /// Construct an account from the given [json].
  factory Account.fromJson(Map<String, dynamic> json) {
    final String? createdTimestamp = json['createdTimestamp'] as String?;
    final Map<String, dynamic>? emails =
        (json['emails'] as Map<Object?, Object?>?)?.cast<String, dynamic>();
    final Map<String, dynamic>? profile =
        (json['profile'] as Map<Object?, Object?>?)?.cast<String, dynamic>();
    final String? lastLoginTimestamp = json['lastLogin'] as String?;
    final String? lastUpdatedTimestamp = json['lastUpdated'] as String?;
    final String? oldestDataUpdateTimestamp =
        json['oldestDataUpdated'] as String?;
    final String? registeredTimestamp = json['registered'] as String?;
    final String? verifiedTimestamp = json['verified'] as String?;
    final String socialProviders = json['socialProviders'] as String? ?? '';

    // The signature timestamp can be either an ISO 8601 date,
    // or the number of seconds since the UNIX epoch (1 Jan 1970).
    final DateTime? signatureTimestamp = switch (json['signatureTimestamp']) {
      final String timestamp => DateTime.parse(timestamp),
      final int timestamp =>
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000),
      final double timestamp =>
        DateTime.fromMillisecondsSinceEpoch(timestamp.toInt() * 1000),
      _ => null,
    };

    return Account(
      emails: emails == null ? const Emails() : Emails.fromJson(emails),
      createdTimestamp: DateTime.tryParse(createdTimestamp ?? ''),
      isActive: json['isActive'] as bool?,
      isRegistered: json['isRegistered'] as bool?,
      isVerified: json['isVerified'] as bool?,
      lastLoginTimestamp: DateTime.tryParse(lastLoginTimestamp ?? ''),
      lastUpdatedTimestamp: DateTime.tryParse(lastUpdatedTimestamp ?? ''),
      loginProvider: json['loginProvider'] as String?,
      oldestDataUpdateTimestamp:
          DateTime.tryParse(oldestDataUpdateTimestamp ?? ''),
      profile: profile == null ? null : Profile.fromJson(profile),
      registeredTimestamp: DateTime.tryParse(registeredTimestamp ?? ''),
      signatureTimestamp: signatureTimestamp,
      socialProviders: socialProviders.split(','),
      uid: json['UID'] as String?,
      uidSignature: json['UIDSignature'] as String?,
      verifiedTimestamp: DateTime.tryParse(verifiedTimestamp ?? ''),
    );
  }

  /// The timestamp, in UTC, on which the account was created.
  final DateTime? createdTimestamp;

  /// Whether this account is active.
  final bool? isActive;

  /// Whether this account is registered.
  final bool? isRegistered;

  /// Whether this account is verified.
  final bool? isVerified;

  /// The list of email addresses for the account.
  final Emails emails;

  /// The timestamp of the last login of the user.
  final DateTime? lastLoginTimestamp;

  /// The timestamp, in UTC, when the user's profile, preferences,
  /// or subscriptions data was last updated.
  final DateTime? lastUpdatedTimestamp;

  /// The name of current login provider for this account.
  ///
  /// If the user logged in using a custom site login mechanism,
  /// then the value of this attribute will be `site`.
  final String? loginProvider;

  /// The timestamp, in UTC, when the oldest data of the user was refreshed.
  final DateTime? oldestDataUpdateTimestamp;

  /// The profile linked to this account.
  final Profile? profile;

  /// The timestamp, in UTC, when the user was registered.
  final DateTime? registeredTimestamp;

  /// The timestamp of the [uidSignature], in UTC.
  /// This signature should be used for login validation.
  final DateTime? signatureTimestamp;

  /// The social providers linked to this account.
  final List<String> socialProviders;

  /// The UID of the account.
  final String? uid;

  /// The UID signature of the account.
  final String? uidSignature;

  /// The timestamp, in UTC, when the user was verified.
  final DateTime? verifiedTimestamp;

  /// Convert this object into a JSON object.
  Map<String, dynamic> toJson() {
    final Profile? accountProfile = profile;

    return <String, dynamic>{
      'createdTimestamp': createdTimestamp?.toIso8601String(),
      'emails': emails.toJson(),
      'isActive': isActive,
      'isRegistered': isRegistered,
      'isVerified': isVerified,
      'lastLoginTimestamp': lastLoginTimestamp?.toIso8601String(),
      'lastUpdatedTimestamp': lastUpdatedTimestamp?.toIso8601String(),
      'loginProvider': loginProvider,
      'oldestDataUpdatedTimestamp':
          oldestDataUpdateTimestamp?.toIso8601String(),
      if (accountProfile != null) 'profile': accountProfile.toJson(),
      'registeredTimestamp': registeredTimestamp?.toIso8601String(),
      'signatureTimestamp': signatureTimestamp?.toIso8601String(),
      'socialProviders': socialProviders,
      'UID': uid,
      'UIDSignature': uidSignature,
      'verifiedTimestamp': verifiedTimestamp?.toIso8601String(),
    };
  }
}
