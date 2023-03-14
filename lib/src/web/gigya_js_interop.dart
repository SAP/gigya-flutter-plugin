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
  external set onGigyaServiceReady(void Function() onReady);
}
