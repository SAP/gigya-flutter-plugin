import 'package:js/js.dart';
import 'package:js/js_util.dart';

import '../models/account_login_id.dart';
import '../models/emails.dart';
import '../models/location.dart';
import '../models/profile.dart';
import 'response.dart';

// TODO: preferences, subscriptions should be in `AccountResponse`

// TODO: make the `BaseAccountResponse` class sealed once Class Modifiers is available

/// The static interop class for the base account response.
@JS()
@anonymous
@staticInterop
class BaseAccountResponse extends Response {}

/// This extension defines the static interop definition
/// for the [BaseAccountResponse] class.
extension BaseAccountResponseExtension on BaseAccountResponse {
  /// The timestamp of the creation of the user.
  external String? get created;

  @JS('data')
  external Object? get _data;

  /// The custom user data that is not part of the [profile].
  ///
  /// Any [List] or [Map] values within this map will have `Object?` as type argument(s).
  Map<String, dynamic>? get data {
    // The underlying structure of `data` is a flexible, user-defined definition
    // and does not fit within a specific static interop definition.
    // Instead use `dartify` to convert the Javascript Object into a Map.
    return (dartify(_data) as Map<Object?, Object?>?)?.cast<String, dynamic>();
  }

  /// The verified and unverified email addresses of the user.
  external Emails? get emails;

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
  external List<dynamic>? get _loginIds;

  /// The login IDs for the user.
  List<AccountLoginId>? get loginIds => _loginIds?.cast<AccountLoginId>();

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
}

/// The static interop class for the account info response.
@JS()
@anonymous
@staticInterop
class AccountInfoResponse extends BaseAccountResponse {}

/// This extension defines the static interop definition
/// for the [AccountInfoResponse] class.
extension AccountInfoResponseExtension on AccountInfoResponse {
  /// Whether this account is currently in transition.
  ///
  /// An account that is in transition cannot be modified.
  external bool? get inTransition;

  // TODO: add lockedUntil when DateTime static interop is fixed.
  // Currently it is not supported, so add a static interop type for the date class
  // See: https://github.com/dart-lang/sdk/issues/52021
}
