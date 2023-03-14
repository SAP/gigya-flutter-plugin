import 'dart:html' as html;

import 'package:js/js.dart';

/// The static interop class for [html.Window].
@JS()
@staticInterop
class JSWindow {}

/// This extension defines the static interop definition
/// for the [html.Window] class.
extension JSWindowExtension on JSWindow {
  /// Set the `onGigyaServiceReady` function on the [html.Window].
  ///
  /// This function is called when the Gigya Web SDK has been initialized.
  external set onGigyaServiceReady(void Function(Object? arguments) onReady);
}

/// Get the `gigya` JavaScript object.
@JS('window.gigya')
external GigyaWebSdk get gigyaWebSdk;

/// The static interop class for the `gigya` JavaScript object.
@JS()
@staticInterop
class GigyaWebSdk {}

/// This extension defines the static interop definition
/// for the [GigyaWebSdk] class.
extension GigyaWebSdkExtension on GigyaWebSdk {}
