import 'dart:async';
import 'dart:html' as html;
import 'dart:js_util';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '../models/gigya_error.dart';
import '../platform_interface/gigya_flutter_plugin_platform_interface.dart';
import '../services/interruption_resolver.dart';
import 'static_interop/account.dart';
import 'static_interop/gigya_web_sdk.dart';
import 'static_interop/parameters/basic.dart';
import 'static_interop/parameters/login.dart';
import 'static_interop/response/response.dart';
import 'static_interop/window.dart';
import 'static_interop_interruption_resolver.dart';
import 'web_error_code.dart';

/// An implementation of [GigyaFlutterPluginPlatform] that uses JavaScript static interop.
class GigyaFlutterPluginWeb extends GigyaFlutterPluginPlatform {
  /// Register [GigyaFlutterPluginWeb] as the default implementation for the web plugin.
  ///
  /// This method is used by the `GeneratedPluginRegistrant` class.
  static void registerWith(Registrar registrar) {
    GigyaFlutterPluginPlatform.instance = GigyaFlutterPluginWeb();
  }

  @override
  InterruptionResolverFactory get interruptionResolverFactory => const StaticInteropInterruptionResolverFactory();

  @override
  Future<void> initSdk({
    required String apiDomain,
    required String apiKey,
    bool forceLogout = true,
  }) async {
    final Completer<void> onGigyaServiceReadyCompleter = Completer<void>();
    final JSWindow domWindow = html.window as JSWindow;

    // Set `window.onGigyaServiceReady` before creating the script.
    // That function is called when the SDK has been initialized.
    domWindow.onGigyaServiceReady = allowInterop((Object? arguments) {
      if (!onGigyaServiceReadyCompleter.isCompleted) {
        onGigyaServiceReadyCompleter.complete();
      }
    });

    final html.ScriptElement script = html.ScriptElement()
      ..async = true
      ..defer = false
      ..type = 'text/javascript'
      ..lang = 'javascript'
      ..crossOrigin = 'anonymous'
      ..src = 'https://cdns.$apiDomain/js/gigya.js?apikey=$apiKey';

    html.document.head!.append(script);

    await script.onLoad.first;

    if (forceLogout) {
      await logout();
    }

    return onGigyaServiceReadyCompleter.future;
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
                errorCode: response.errorCode,
                errorDetails: response.errorDetails,
              ),
            );
            break;
        }
      }),
    );

    gigyaWebSdk.accounts.session.verify(parameters);

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
      callback: allowInterop((LoginResponse response) {
        if (completer.isCompleted) {
          return;
        }

        if (response.errorCode == 0) {
          completer.complete(response.toMap());
        } else {
          completer.completeError(
            GigyaError(
              apiVersion: response.apiVersion,
              callId: response.callId,
              errorCode: response.errorCode,
              errorDetails: response.errorDetails,
            ),
          );
        }
      }),
    );

    gigyaWebSdk.accounts.login(loginParameters);

    return completer.future;
  }

  @override
  Future<void> logout() {
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
              errorCode: response.errorCode,
              errorDetails: response.errorDetails,
            ),
          );
        }
      }),
    );

    gigyaWebSdk.accounts.logout(parameters);

    return completer.future;
  }
}
