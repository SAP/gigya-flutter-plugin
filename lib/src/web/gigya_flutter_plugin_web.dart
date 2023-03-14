import 'dart:async';
import 'dart:html' as html;
import 'dart:js_util';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '../platform_interface/gigya_flutter_plugin_platform_interface.dart';
import 'gigya_js_interop.dart';

/// An implementation of [GigyaFlutterPluginPlatform] that uses JavaScript static interop.
class GigyaFlutterPluginWeb extends GigyaFlutterPluginPlatform {
  /// Register [GigyaFlutterPluginWeb] as the default implementation for the web plugin.
  ///
  /// This method is used by the `GeneratedPluginRegistrant` class.
  static void registerWith(Registrar registrar) {
    GigyaFlutterPluginPlatform.instance = GigyaFlutterPluginWeb();
  }

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
}
