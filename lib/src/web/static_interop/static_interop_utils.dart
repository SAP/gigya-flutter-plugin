import 'models/account_login_id.dart';
import 'models/emails.dart';
import 'models/location.dart';
import 'models/profile.dart';
import 'models/session_info.dart';
import 'response/response.dart';

// TODO: convert this class to an `abstract final class` once Class Modifiers are available.

/// This class represents a namespace with utilities for static JS interop.
abstract class StaticInteropUtils {
  /// Convert a [BaseAccountResponse] (or one of its subclasses) to a map.
  static Map<String, dynamic> _accountResponseToMap(
    BaseAccountResponse response,
  ) {
    Map<String, dynamic>? accountInfo;
    Map<String, dynamic>? loginInfo;

    final Map<String, dynamic>? profileAsMap = response.profile?.toMap();

    if (profileAsMap != null) {
      // The lastLoginLocation field is not in the profile
      // when using the Gigya Web SDK.
      // Instead, it is located inside the login response.
      // Add it to the profile map.
      profileAsMap['lastLoginLocation'] = response.lastLoginLocation?.toMap();
    }

    // TODO: once `BaseAccountResponse` is sealed, use a switch here

    if (response is AccountInfoResponse) {
      accountInfo = <String, dynamic>{
        'inTransition': response.inTransition,
      };
    }

    if (response is LoginResponse) {
      final SessionInfo? sessionInfo = response.sessionInfo;

      loginInfo = <String, dynamic>{
        'isNewUser': response.isNewUser,
        'regToken': response.regToken,
        if (sessionInfo != null)
          'sessionInfo': <String, dynamic>{
            'cookieName': sessionInfo.cookieName,
            'cookieValue': sessionInfo.cookieValue,
          },
      };
    }

    // First, add the base `BaseAccountResponse` fields.
    return <String, dynamic>{
      'created': response.created,
      if (response.emails != null)
        'emails': <String, dynamic>{
          'unverified': response.emails!.unverified,
          'verified': response.emails!.verified,
        },
      'isActive': response.isActive,
      'isRegistered': response.isRegistered,
      'isVerified': response.isVerified,
      'lastLogin': response.lastLogin,
      'lastUpdated': response.lastUpdated,
      if (response.loginIds != null) 'loginIDs': response.loginIds!.map((AccountLoginId l) => l.toMap()).toList(),
      'loginProvider': response.loginProvider,
      'oldestDataUpdated': response.oldestDataUpdated,
      if (profileAsMap != null) 'profile': profileAsMap,
      'registered': response.registered,
      'regSource': response.regSource,
      'signatureTimestamp': response.signatureTimestamp,
      'socialProviders': response.socialProviders,
      'UID': response.UID,
      'UIDSignature': response.UIDSignature,
      'verified': response.verified,
      // Then amend the specific fields per subclass.
      if (accountInfo != null) ...accountInfo,
      if (loginInfo != null) ...loginInfo,
    };
  }

  /// Convert the given [response] to a [Map].
  ///
  /// Since methods that are defined in an extension cannot be overridden
  /// (because extensions are resolved against their static type),
  /// the [Response] class cannot define an overridable `toMap()` function.
  ///
  /// See: https://dart.dev/language/extension-methods#static-types-and-dynamic
  static Map<String, dynamic> responseToMap<T extends Response>(T response) {
    // First, add the base `Response` fields.
    return <String, dynamic>{
      'apiVersion': response.apiVersion,
      'callId': response.callId,
      'errorCode': response.errorCode,
      'errorDetails': response.errorDetails,
      'errorMessage': response.errorDetails,
      // Then amend the specific fields per subclass.
      if (response is BaseAccountResponse) ..._accountResponseToMap(response),
    };
  }
}
