import 'emails.dart';
import 'profile.dart';
import 'session_info.dart';

/// This class represents an account.
class Account {
  /// The default constructor.
  Account({
    this.created,
    this.data = const <String, dynamic>{},
    this.emails = const Emails(),
    this.isActive,
    this.isRegistered,
    this.isVerified,
    this.lastLogin,
    this.lastUpdated,
    this.loginProvider,
    this.oldestDataUpdated,
    this.profile,
    this.registered,
    this.sessionInfo,
    this.signatureTimestamp,
    this.socialProviders = const <String>[],
    this.uid,
    this.uidSignature,
    this.verified,
  });

  /// Construct an account from the given [json].
  factory Account.fromJson(Map<String, dynamic> json) {
    final String? created = json['created'] as String?;
    final Map<String, dynamic>? emails =
        (json['emails'] as Map<Object?, Object?>?)?.cast<String, dynamic>();
    final Map<String, dynamic>? profile =
        (json['profile'] as Map<Object?, Object?>?)?.cast<String, dynamic>();
    final String? lastLogin = json['lastLogin'] as String?;
    final String? lastUpdated = json['lastUpdated'] as String?;
    final String? oldestDataUpdated = json['oldestDataUpdated'] as String?;
    final String? registered = json['registered'] as String?;
    final String? verified = json['verified'] as String?;
    final Map<String, dynamic>? session =
        (json['sessionInfo'] as Map<Object?, Object?>?)
            ?.cast<String, dynamic>();
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
      created: DateTime.tryParse(created ?? ''),
      data: (json['data'] as Map<Object?, Object?>?)?.cast<String, dynamic>(),
      emails: emails == null ? const Emails() : Emails.fromJson(emails),
      isActive: json['isActive'] as bool?,
      isRegistered: json['isRegistered'] as bool?,
      isVerified: json['isVerified'] as bool?,
      lastLogin: DateTime.tryParse(lastLogin ?? ''),
      lastUpdated: DateTime.tryParse(lastUpdated ?? ''),
      loginProvider: json['loginProvider'] as String?,
      oldestDataUpdated: DateTime.tryParse(oldestDataUpdated ?? ''),
      profile: profile == null ? null : Profile.fromJson(profile),
      registered: DateTime.tryParse(registered ?? ''),
      sessionInfo: session == null ? null : SessionInfo.fromJson(session),
      signatureTimestamp: signatureTimestamp,
      socialProviders: socialProviders.split(','),
      uid: json['UID'] as String?,
      uidSignature: json['UIDSignature'] as String?,
      verified: DateTime.tryParse(verified ?? ''),
    );
  }

  /// The timestamp, in UTC, on which the account was created.
  final DateTime? created;

  /// The custom data for the account, which is not part of the [profile].
  final Map<String, dynamic>? data;

  /// The list of email addresses for the account.
  final Emails emails;

  /// Whether this account is active.
  final bool? isActive;

  /// Whether this account is registered.
  final bool? isRegistered;

  /// Whether this account is verified.
  final bool? isVerified;

  /// The timestamp of the last login of the user.
  final DateTime? lastLogin;

  /// The timestamp, in UTC, when the user's profile, preferences,
  /// or subscriptions data was last updated.
  final DateTime? lastUpdated;

  /// The name of current login provider for this account.
  ///
  /// If the user logged in using a custom site login mechanism,
  /// then the value of this attribute will be `site`.
  final String? loginProvider;

  /// The timestamp, in UTC, of the oldest update to the user's account data.
  final DateTime? oldestDataUpdated;

  /// The profile linked to this account.
  final Profile? profile;

  /// The timestamp, in UTC, when the user was registered.
  final DateTime? registered;

  /// The session info for the account.
  final SessionInfo? sessionInfo;

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
  final DateTime? verified;

  /// Convert this object into a JSON object.
  Map<String, dynamic> toJson() {
    final Profile? accountProfile = profile;

    return <String, dynamic>{
      'created': created?.toIso8601String(),
      'data': data,
      'emails': emails.toJson(),
      'isActive': isActive,
      'isRegistered': isRegistered,
      'isVerified': isVerified,
      'lastLogin': lastLogin?.toIso8601String(),
      'lastUpdated': lastUpdated?.toIso8601String(),
      'loginProvider': loginProvider,
      'oldestDataUpdated': oldestDataUpdated?.toIso8601String(),
      if (accountProfile != null) 'profile': accountProfile.toJson(),
      'registered': registered?.toIso8601String(),
      if (sessionInfo != null) 'sessionInfo': sessionInfo!.toJson(),
      'signatureTimestamp': signatureTimestamp?.toIso8601String(),
      'socialProviders': socialProviders,
      'UID': uid,
      'UIDSignature': uidSignature,
      'verified': verified?.toIso8601String(),
    };
  }
}
