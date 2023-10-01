import 'dart:js_interop';

import '../models/account_login_id.dart';
import '../models/emails.dart';
import '../models/location.dart';
import '../models/profile.dart';
import '../models/validation_error.dart';
import 'response.dart';

// TODO: preferences, subscriptions should be in `GetAccountResponse`

/// The extension type for the get account response.
@JS()
@anonymous
@staticInterop
extension type GetAccountResponse(Response baseResponse) {
  /// The timestamp of the creation of the user.
  external String? get created;

  /// The custom user data that is not part of the [profile].
  external JSAny? get data;

  /// The verified and unverified email addresses of the user.
  external Emails? get emails;

  /// Whether this account is currently in transition.
  ///
  /// An account that is in transition cannot be modified.
  external bool? get inTransition;  

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

  @JS('loginIDs')
  external JSArray? get _loginIds;

  /// The login IDs for the user.
  List<AccountLoginId>? get loginIds {
    return _loginIds?.toDart.cast<AccountLoginId>();
  }  

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

  // TODO: add lockedUntil when DateTime static interop is fixed.
  // Currently it is not supported, so add a static interop type for the date class
  // See: https://github.com/dart-lang/sdk/issues/52021  

  /// Convert this response to a [Map].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'created': created,
      'data': data.dartify(),
      'emails': emails?.toMap(),
      'inTransition': inTransition,
      'isActive': isActive,
      'isRegistered': isRegistered,
      'isVerified': isVerified,
      'lastLogin': lastLogin,
      'lastLoginLocation': lastLoginLocation?.toMap(),
      'lastUpdated': lastUpdated,
      if (loginIds != null)
        'loginIds': loginIds!.map((AccountLoginId id) => id.toMap()).toList(),
      'loginProvider': loginProvider,
      'oldestDataUpdated': oldestDataUpdated,
      'profile': profile?.toMap(),
      'registered': registered,
      'regSource': regSource,
      'signatureTimestamp': signatureTimestamp,
      'socialProviders': socialProviders,
      'UID': UID,
      'UIDSignature': UIDSignature,
      'verified': verified,
    };
  }
}

/// The extension type for the Gigya Set Account API response.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/4139777d70b21014bbc5a10ce4041860.html?locale=en-US#response-object-data-members
@JS()
@anonymous
@staticInterop
extension type SetAccountResponse(Response baseResponse) {
  /// Get the error details.
  /// 
  /// The error details will include the [validationErrors].
  Map<String, Object?> get details {
    return <String, Object?>{
      ...baseResponse.details,
      'validationErrors': validationErrors.map((ValidationError e) => e.toMap()).toList(),
    };
  }

  @JS('validationErrors')
  external JSArray? get _validationErrors;

  /// The validation errors for the set account payload.
  List<ValidationError> get validationErrors {
    return _validationErrors?.toDart.cast<ValidationError>() ?? const <ValidationError>[];
  }
}
