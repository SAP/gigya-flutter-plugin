import 'dart:async';
import 'dart:js_interop';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:js/js_util.dart' show allowInterop;
import 'package:web/web.dart' as web;

import '../models/gigya_error.dart';
import '../platform_interface/gigya_flutter_plugin_platform_interface.dart';
import '../services/interruption_resolver.dart';
import 'enums/web_error_code.dart';
import 'static_interop/gigya_web_sdk.dart';
import 'static_interop/models/profile.dart';
import 'static_interop/parameters/account.dart';
import 'static_interop/parameters/basic.dart';
import 'static_interop/parameters/login.dart';
import 'static_interop/parameters/registration.dart';
import 'static_interop/response/registration_response.dart';
import 'static_interop/response/response.dart';
import 'static_interop/window.dart';
import 'web_interruption_resolver.dart';

/// An implementation of [GigyaFlutterPluginPlatform] that uses JavaScript static interop.
class GigyaFlutterPluginWeb extends GigyaFlutterPluginPlatform {
  /// Register [GigyaFlutterPluginWeb] as the default implementation for the web plugin.
  ///
  /// This method is used by the `GeneratedPluginRegistrant` class.
  static void registerWith(Registrar registrar) {
    GigyaFlutterPluginPlatform.instance = GigyaFlutterPluginWeb();
  }

  @override
  InterruptionResolverFactory get interruptionResolverFactory {
    return const WebInterruptionResolverFactory();
  }

  @override
  Future<Map<String, dynamic>> finalizeRegistration(
    String registrationToken, {
    String? include,
    bool allowAccountsLinking = false,
  }) {
    final Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();

    GigyaWebSdk.instance.accounts.finalizeRegistration.callAsFunction(
      null,
      FinalizeRegistrationParameters(
        allowAccountsLinking: allowAccountsLinking,
        include: include,
        regToken: registrationToken,
        callback: allowInterop(
          (LoginResponse response) {
            if (completer.isCompleted) {
              return;
            }

            if (response.baseResponse.errorCode == 0) {
              completer.complete(response.toMap());
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
          },
        ).toJS,
      ),
    );

    return completer.future;
  }

  @override
  Future<String> initRegistration({required bool isLite}) {
    final Completer<String> initRegistrationCompleter = Completer<String>();

    GigyaWebSdk.instance.accounts.initRegistration.callAsFunction(
      null,
      InitRegistrationParameters(
        isLite: isLite,
        callback: allowInterop(
          (InitRegistrationResponse response) {
            if (initRegistrationCompleter.isCompleted) {
              return;
            }

            if (response.baseResponse.errorCode == 0) {
              initRegistrationCompleter.complete(response.regToken ?? '');
            } else {
              initRegistrationCompleter.completeError(
                GigyaError(
                  apiVersion: response.baseResponse.apiVersion,
                  callId: response.baseResponse.callId,
                  details: response.baseResponse.details,
                  errorCode: response.baseResponse.errorCode,
                ),
              );
            }
          },
        ).toJS,
      ),
    );

    return initRegistrationCompleter.future;
  }

  @override
  Future<Map<String, dynamic>> getAccount({
    bool invalidate = false,
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

  @override
  Future<void> initSdk({
    required String apiDomain,
    required String apiKey,
    bool forceLogout = false,
  }) async {
    final Completer<void> onGigyaServiceReadyCompleter = Completer<void>();
    final GigyaWindow domWindow = GigyaWindow(web.window);

    // Set `window.onGigyaServiceReady` before creating the script.
    // That function is called when the SDK has been initialized.
    domWindow.onGigyaServiceReady = allowInterop((JSString? _) {
      if (!onGigyaServiceReadyCompleter.isCompleted) {
        onGigyaServiceReadyCompleter.complete();
      }
    }).toJS;

    // If the Gigya SDK is ready beforehand, complete directly.
    // This is the case when doing a Hot Reload, where the application starts from scratch,
    // even though the Gigya SDK script is still attached to the DOM and ready.
    // See https://docs.flutter.dev/tools/hot-reload#how-to-perform-a-hot-reload
    final bool sdkIsReady = domWindow.gigya != null && GigyaWebSdk.instance.isReady;

    if (sdkIsReady) {
      if (!onGigyaServiceReadyCompleter.isCompleted) {
        onGigyaServiceReadyCompleter.complete();
      }
    } else {
      final Completer<void> scriptLoadCompleter = Completer<void>();

      final web.HTMLScriptElement script = (web.document.createElement('script') as web.HTMLScriptElement)
        ..async = true
        ..defer = false
        ..type = 'text/javascript'
        ..lang = 'javascript'
        ..crossOrigin = 'anonymous'
        ..src = 'https://cdns.$apiDomain/js/gigya.js?apikey=$apiKey'
        ..onload = allowInterop((JSAny _) {
          if (!scriptLoadCompleter.isCompleted) {
            scriptLoadCompleter.complete();
          }
        }).toJS;

      web.document.head!.append(script);

      await scriptLoadCompleter.future;
    }

    // If `onGigyaServiceReady` takes too long to be called
    // (for instance if the network is unavailable, or Gigya does not initialize properly),
    // exit with a timeout error.
    await onGigyaServiceReadyCompleter.future.timeout(
      const Duration(seconds: 5),
      onTimeout: () => throw const GigyaTimeoutError(),
    );

    if (forceLogout) {
      await logout();
    }
  }

  @override
  Future<bool> isLoggedIn() {
    final Completer<bool> completer = Completer<bool>();
    final BasicParameters parameters = BasicParameters(
      callback: allowInterop((Response response) {
        if (completer.isCompleted) {
          return;
        }

        switch (WebErrorCode.fromErrorCode(response.errorCode)) {
          case WebErrorCode.success:
            completer.complete(true);
            break;
          case WebErrorCode.unauthorizedUser:
            completer.complete(false);
            break;
          default:
            completer.completeError(
              GigyaError(
                apiVersion: response.apiVersion,
                callId: response.callId,
                details: response.details,
                errorCode: response.errorCode,
              ),
            );
            break;
        }
      }).toJS,
    );

    GigyaWebSdk.instance.accounts.session.verify.callAsFunction(
      null,
      parameters,
    );

    return completer.future;
  }

  @override
  Future<Map<String, dynamic>> login({
    required String loginId,
    required String password,
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) {
    final Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();

    final LoginParameters loginParameters = LoginParameters(
      loginID: loginId,
      password: password,
      captchaToken: parameters['captchaToken'] as String?,
      include: parameters['include'] as String?,
      loginMode: parameters['loginMode'] as String?,
      redirectURL: parameters['redirectURL'] as String?,
      regToken: parameters['regToken'] as String?,
      sessionExpiration: parameters['sessionExpiration'] as int?,
      callback: allowInterop((LoginResponse response) {
        if (completer.isCompleted) {
          return;
        }

        if (response.baseResponse.errorCode == 0) {
          completer.complete(response.toMap());
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
      }).toJS,
    );

    GigyaWebSdk.instance.accounts.login.callAsFunction(
      null,
      loginParameters,
    );

    return completer.future;
  }

  @override
  Future<void> logout() async {
    if (!await isLoggedIn()) {
      return;
    }

    final Completer<void> completer = Completer<void>();
    final BasicParameters parameters = BasicParameters(
      callback: allowInterop((Response response) {
        if (completer.isCompleted) {
          return;
        }

        if (response.errorCode == 0) {
          completer.complete();
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
      }).toJS,
    );

    GigyaWebSdk.instance.accounts.logout.callAsFunction(
      null,
      parameters,
    );

    return completer.future;
  }

  @override
  Future<Map<String, dynamic>> register({
    required String loginId,
    required String password,
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) async {
    // Start registration by retrieving the regToken.
    // If it was already provided, skip the initRegistration step.
    String regToken = parameters['regToken'] as String? ?? '';

    if (regToken.isEmpty) {
      regToken = await initRegistration(
        isLite: parameters['isLite'] as bool? ?? false,
      );
    }

    final Map<String, Object?>? profile = parameters['profile'] as Map<String, Object?>?;
    final Completer<Map<String, Object?>> registrationCompleter = Completer<Map<String, Object?>>();

    GigyaWebSdk.instance.accounts.register.callAsFunction(
      null,
      RegistrationParameters(
        // Explicitly finalize using the register endpoint.
        // This way, calling `finalizeRegistration` is not needed.
        // For lite accounts, the `accounts.register` endpoint is never used anyway.
        // That flow uses `accounts.initRegistration` and `accounts.setAccountInfo` instead.
        finalizeRegistration: true,
        regToken: regToken,
        email: loginId,
        password: password,
        captchaToken: parameters['captchaToken'] as String?,
        include: parameters['include'] as String?,
        lang: parameters['lang'] as String?,
        profile: profile == null ? null : Profile.fromMap(profile),
        regSource: parameters['regSource'] as String?,
        secretAnswer: parameters['secretAnswer'] as String?,
        secretQuestion: parameters['secretQuestion'] as String?,
        sessionExpiration: parameters['sessionExpiration'] as int?,
        siteUID: parameters['siteUID'] as String?,
        callback: allowInterop(
          (LoginResponse response) {
            if (registrationCompleter.isCompleted) {
              return;
            }

            if (response.baseResponse.errorCode == 0) {
              registrationCompleter.complete(response.toMap());
            } else {
              // The error response does not seem to return the regToken.
              // Forward it manually.
              registrationCompleter.completeError(
                GigyaError(
                  apiVersion: response.baseResponse.apiVersion,
                  callId: response.baseResponse.callId,
                  details: <String, Object?>{
                    ...response.baseResponse.details,
                    'regToken': regToken,
                  },
                  errorCode: response.baseResponse.errorCode,
                ),
              );
            }
          },
        ).toJS,
      ),
    );

    return registrationCompleter.future;
  }

  @override
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
