import 'dart:async';
import 'dart:js_interop';
import 'package:js/js_util.dart' show allowInterop;

import '../models/conflicting_account.dart';
import '../models/gigya_error.dart';
import '../services/interruption_resolver.dart';
import 'static_interop/gigya_web_sdk.dart';
import 'static_interop/models/conflicting_account.dart';
import 'static_interop/parameters/conflicting_account.dart';
import 'static_interop/response/response.dart';

// TODO: implement linkToSite & linkToSocial in _LinkAccountResolver
// TODO: return `_LinkAccountResolver` when required

/// This class represents an [InterruptionResolver]
/// that uses static interop for its implementation.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/416d41b170b21014bbc5a10ce4041860.html#error-code-definitions-table
class WebInterruptionResolverFactory extends InterruptionResolverFactory {
  /// The default constructor.
  const WebInterruptionResolverFactory();

  @override
  InterruptionResolver? fromErrorCode(GigyaError exception) {
    // TODO: what is the error code for the `_StaticInteropLinkAccountResolver`?
    switch (exception.errorCode) {
      case 206001:
        return const _PendingRegistrationResolver();
      case 206002:
        return PendingVerificationResolver(exception.registrationToken ?? '');
      default:
        return null;
    }
  }
}

class _LinkAccountResolver extends LinkAccountResolver {
  _LinkAccountResolver({required this.registrationToken}) {
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
      callback: allowInterop((ConflictingAccountResponse response) {
        if (completer.isCompleted) {
          return;
        }

        if (response.baseResponse.errorCode == 0) {
          final WebConflictingAccount? account = response.conflictingAccount;

          completer.complete(
            ConflictingAccount(
              loginID: account?.loginID,
              loginProviders: account?.loginProviders ?? const <String>[],
            ),
          );
        } else {
          completer.completeError(
            GigyaError(
              apiVersion: response.baseResponse.apiVersion,
              callId: response.baseResponse.callId,
              details: response.baseResponse.details,
              errorCode: response.baseResponse.errorCode,
            ),
          );
        }
      }).toJS,
    );

    GigyaWebSdk.instance.accounts.getConflictingAccount.callAsFunction(
      null,
      parameters,
    );

    return completer.future;
  }
}

class _PendingRegistrationResolver extends PendingRegistrationResolver {
  const _PendingRegistrationResolver();

  // TODO: implement set account info & call it here
}
