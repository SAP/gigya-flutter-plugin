import 'package:js/js.dart';

import '../emails.dart';
import '../profile.dart';
import '../session_info.dart';

/// The static interop class for the Gigya Login API response.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/eb93d538b9ae45bfadd9a8aaa8806753.html#response-data
@JS()
@anonymous
class LoginResponse {
  /// Construct a [LoginResponse] object.
  external factory LoginResponse({
    int? apiVersion,
    String callId,
    String? createdTimestamp,
    Emails? emails,
    int errorCode,
    String? errorDetails,
    String? errorMessage,
    bool? isActive,
    bool? isRegistered,
    bool? isVerified,
    String? lastLogin,
    Location? lastLoginLocation,
    String? lastUpdated,
    String? loginProvider,
    String? oldestDataUpdated,
    Profile? profile,
    String? registered,
    SessionInfo? sessionInfo,
    Object? signatureTimestamp,
    String? socialProviders,
    String? UID, // ignore: non_constant_identifier_names
    String? UIDSignature, // ignore: non_constant_identifier_names
    String? verified,
  });

  /// The version of the Gigya API that was used.
  external int? get apiVersion;

  /// The unique identifier of the transaction.
  external String get callId;

  /// The timestamp of the creation of the user.
  external String? get createdTimestamp;

  /// The verified and unverified email addresses of the user.
  external Emails? get emails;

  /// The response error code.
  ///
  /// A value of zero indicates success.
  /// Any other number indicates a failure.
  ///
  /// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/416d41b170b21014bbc5a10ce4041860.html
  external int get errorCode;

  /// The additional details of the encountered error.
  external String? get errorDetails;

  /// The error message for the given [errorCode].
  external String? get errorMessage;

  /// Whether the user is active.
  external bool? get isActive;

  /// Whether the user is registered.
  external bool? get isRegistered;

  /// Whether the user is verified.
  external bool? get isVerified;

  /// The timestamp of the last login of the user.
  external String? get lastLogin;

  /// The last login location of the user.
  external Location? get lastLoginLocation;

  /// The timestamp of the last update to the user's profile,
  /// preferences or subscriptions data.
  external String? get lastUpdated;

  /// The login provider that was last used to log in.
  external String? get loginProvider;

  /// The timestamp, when the oldest data of the user was refreshed.
  external String? get oldestDataUpdated;

  /// The user's profile.
  external Profile? get profile;

  /// The timestamp when the user was registered.
  external String? get registered;

  /// The session info for the user's session.
  external SessionInfo? get sessionInfo;

  /// The timestamp of the [UIDSignature].
  /// This value can be a [String] or a [num].
  external Object? get signatureTimestamp;

  /// The comma separated list of social providers linked to this user.
  external String? get socialProviders;

  /// The unique id of this user.
  external String? get UID; // ignore: non_constant_identifier_names

  /// The verification signature of the [UID].
  external String? get UIDSignature; // ignore: non_constant_identifier_names

  /// The timestamp when the user was verified.
  external String? get verified;

  /// Convert the given [response] to a [Map].
  ///
  /// Since the [LoginResponse] class is an anonymous JavaScript type,
  /// this has to be a static method instead of an instance method.
  static Map<String, dynamic> toMap(LoginResponse response) {
    final Emails? emails = response.emails;
    final SessionInfo? sessionInfo = response.sessionInfo;

    final Profile? profile = response.profile;

    return <String, dynamic>{
      'createdTimestamp': response.createdTimestamp,
      if (emails != null)
        'emails': <String, dynamic>{
          'unverified': emails.unverified,
          'verified': emails.verified,
        },
      'isActive': response.isActive,
      'isRegistered': response.isRegistered,
      'isVerified': response.isVerified,
      'lastLogin': response.lastLogin,
      'lastUpdated': response.lastUpdated,
      'loginProvider': response.loginProvider,
      'oldestDataUpdated': response.oldestDataUpdated,
      if (profile != null) 'profile': Profile.toMap(profile),
      'registered': response.registered,
      if (sessionInfo != null)
        'sessionInfo': <String, dynamic>{
          'cookieName': sessionInfo.cookieName,
          'cookieValue': sessionInfo.cookieValue,
        },
      'signatureTimestamp': response.signatureTimestamp,
      'socialProviders': response.socialProviders,
      'UID': response.UID,
      'UIDSignature': response.UIDSignature,
      'verified': response.verified,
    };
  }
}
