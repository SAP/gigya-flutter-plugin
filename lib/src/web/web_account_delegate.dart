import 'dart:async';
import 'dart:js_interop';
import 'package:js/js_util.dart' show allowInterop;

import '../models/gigya_error.dart';
import 'static_interop/gigya_web_sdk.dart';
import 'static_interop/models/profile.dart';
import 'static_interop/parameters/account.dart';
import 'static_interop/response/account_response.dart';

/// This class handles updating and retrieving account information for the web.
class WebAccountDelegate {
  /// Create an instance of [WebAccountDelegate].
  const WebAccountDelegate();

  /// Get the account information for the current user.
  Future<Map<String, dynamic>> getAccount({
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) async {
    final Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();

    GigyaWebSdk.instance.accounts.getAccountInfo.callAsFunction(
      null,
      GetAccountParameters(
        extraProfileFields: parameters['extraProfileFields'] as String?,
        include: parameters['include'] as String?,
        callback: allowInterop(
          (GetAccountResponse response) {
            if (completer.isCompleted) {
              return;
            }

            if (response.accountResponse.baseResponse.errorCode == 0) {
              completer.complete(response.toMap());
            } else {
              completer.completeError(
                GigyaError(
                  apiVersion: response.accountResponse.baseResponse.apiVersion,
                  callId: response.accountResponse.baseResponse.callId,
                  details: response.accountResponse.baseResponse.details,
                  errorCode: response.accountResponse.baseResponse.errorCode,
                ),
              );
            }
          },
        ).toJS,
      ),
    );

    return completer.future;
  }

  /// Set the account information using the given [account].
  Future<Map<String, dynamic>> setAccount(Map<String, dynamic> account) {
    final Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();

    final Map<String, dynamic>? profile = account['profile'] as Map<String, dynamic>?;
    final Map<String, dynamic>? data = account['data'] as Map<String, dynamic>?;

    GigyaWebSdk.instance.accounts.setAccountInfo.callAsFunction(
      null,
      SetAccountParameters(
        addLoginEmails: account['addLoginEmails'] as String?,
        conflictHandling: account['conflictHandling'] as String?,
        data: data.jsify(),
        newPassword: account['newPassword'] as String?,
        password: account['password'] as String?,
        profile: profile == null ? null : Profile.fromMap(profile),
        removeLoginEmails: account['removeLoginEmails'] as String?,
        requirePasswordChange: account['requirePasswordChange'] as bool?,
        secretAnswer: account['secretAnswer'] as String?,
        secretQuestion: account['secretQuestion'] as String?,
        username: account['username'] as String?,
        callback: allowInterop(
          (SetAccountResponse response) {
            if (completer.isCompleted) {
              return;
            }

            // If the call succeeded, there is no data of value to send back.
            // However, if the call failed, the error details will include the validation errors.
            if (response.baseResponse.errorCode == 0) {
              completer.complete(const <String, dynamic>{});
            } else {
              completer.completeError(
                GigyaError(
                  apiVersion: response.baseResponse.apiVersion,
                  callId: response.baseResponse.callId,
                  details: response.details,
                  errorCode: response.baseResponse.errorCode,
                ),
              );
            }
          },
        ).toJS,
      ),
    );

    return completer.future;
  }
}
