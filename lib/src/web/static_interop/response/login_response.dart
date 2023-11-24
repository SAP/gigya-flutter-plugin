import 'dart:js_interop';

import '../models/emails.dart';
import '../models/location.dart';
import '../models/profile.dart';
import '../models/session_info.dart';
import 'response.dart';

/// The extension type for the Gigya Login API response.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/eb93d538b9ae45bfadd9a8aaa8806753.html#response-data
@JS()
@anonymous
@staticInterop
extension type LoginResponse(Response baseResponse) {
  // TODO: preferences, subscriptions should be in the login response

  /// The timestamp of the creation of the user.
  external String? get created;

  /// The verified and unverified email addresses of the user.
  external Emails? get emails;

  /// Whether the user is active.
  external bool? get isActive;

  /// Whether the user that is logging in is a new user.
  external bool? get isNewUser;

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

  /// The source of the registration.
  external String? get regSource;

  /// The registration token.
  external String? get regToken;

  /// The session info for the user's session.
  external SessionInfo? get sessionInfo;

  /// The timestamp of the [UIDSignature].
  external String? get signatureTimestamp;

  /// The comma separated list of social providers linked to this user.
  external String? get socialProviders;

  /// The unique id of this user.
  external String? get UID; // ignore: non_constant_identifier_names

  /// The verification signature of the [UID].
  external String? get UIDSignature; // ignore: non_constant_identifier_names

  /// The timestamp when the user was verified.
  external String? get verified;

  /// Convert this response to a [Map].
  Map<String, dynamic> toMap() {
    final Map<String, dynamic>? profileAsMap = profile?.toMap();

    if (profileAsMap != null && lastLoginLocation != null) {
      // The lastLoginLocation field is not in the profile
      // when using the Gigya Web SDK.
      // Instead, it is located inside the login response.
      // Add it to the profile map.
      profileAsMap['lastLoginLocation'] = lastLoginLocation!.toMap();
    }

    return <String, dynamic>{
      'created': created,
      if (emails != null) 'emails': emails!.toMap(),
      'isActive': isActive,
      'isNewUser': isNewUser,
      'isRegistered': isRegistered,
      'isVerified': isVerified,
      'lastLogin': lastLogin,
      'lastUpdated': lastUpdated,
      'loginProvider': loginProvider,
      'oldestDataUpdated': oldestDataUpdated,
      if (profileAsMap != null) 'profile': profileAsMap,
      'registered': registered,
      'regSource': regSource,
      'regToken': regToken,
      if (sessionInfo != null) 'sessionInfo': sessionInfo!.toMap(),
      'signatureTimestamp': signatureTimestamp,
      'socialProviders': socialProviders,
      'UID': UID,
      'UIDSignature': UIDSignature,
      'verified': verified,
    };
  }
}
