import 'dart:async';

import '../models/conflicting_account.dart';
import '../models/gigya_error.dart';
import '../services/interruption_resolver.dart';
import 'static_interop/account.dart';
import 'static_interop/gigya_web_sdk.dart';
import 'static_interop/models/conflicting_account.dart';
import 'static_interop/parameters/conflicting_account.dart';
import 'static_interop/response/response.dart';

// TODO: implement linkToSite & linkToSocial in _StaticInteropLinkAccountResolver
// TODO: return `_StaticInteropLinkAccountResolver` when required
// TODO: implement setAccount in _StaticInteropPendingRegistrationResolver, using `account.setAccountInfo` endpoint

/// This class represents an [InterruptionResolver]
/// that uses static interop for its implementation.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/416d41b170b21014bbc5a10ce4041860.html#error-code-definitions-table
class StaticInteropInterruptionResolverFactory extends InterruptionResolverFactory {
  /// The default constructor.
  const StaticInteropInterruptionResolverFactory();

  @override
  InterruptionResolver? fromErrorCode(GigyaError exception) {
    // TODO: what is the error code for the `_StaticInteropLinkAccountResolver`?
    switch (exception.errorCode) {
      case 206001:
        return const _StaticInteropPendingRegistrationResolver();
      case 206002:
        return PendingVerificationResolver(exception.registrationToken ?? '');
      default:
        return null;
    }
  }
}

class _StaticInteropLinkAccountResolver extends LinkAccountResolver {
  _StaticInteropLinkAccountResolver({required this.registrationToken}) {
    _conflictingAccounts = _getConflictingAccounts();
  }

  final String registrationToken;

  late final Future<ConflictingAccount>? _conflictingAccounts;

  @override
  Future<ConflictingAccount>? get conflictingAccount => _conflictingAccounts;

  /// Get the conflicting accounts for the user.
  Future<ConflictingAccount> _getConflictingAccounts() {
    final Completer<ConflictingAccount> completer = Completer<ConflictingAccount>();
    final ConflictingAccountParameters parameters = ConflictingAccountParameters(
      regToken: registrationToken,
      callback: (ConflictingAccountResponse response) {
        if (completer.isCompleted) {
          return;
        }

        if (response.errorCode == 0) {
          final JsConflictingAccount? account = response.conflictingAccount;

          completer.complete(
            ConflictingAccount(
              loginID: account?.loginID,
              loginProviders: account?.loginProviders ?? const <String>[],
            ),
          );
        } else {
          completer.completeError(
            GigyaError(
              apiVersion: response.apiVersion,
              callId: response.callId,
              details: response.details,
              errorCode: response.errorCode,
            ),
          );
        }
      },
    );

    GigyaWebSdk.instance.accounts.getConflictingAccount(parameters);

    return completer.future;
  }
}

class _StaticInteropPendingRegistrationResolver extends PendingRegistrationResolver {
  const _StaticInteropPendingRegistrationResolver();
}
