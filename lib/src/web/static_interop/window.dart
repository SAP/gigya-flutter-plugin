import 'package:js/js.dart';
import 'package:web/web.dart' show Window;

import 'gigya_web_sdk.dart';

/// The static interop extension type for the [Window].
@JS()
@staticInterop
extension type GigyaWindow(Window window) {
  /// Get the `gigya` JavaScript object on the [Window].
  external GigyaWebSdk get gigya;

  /// Set the `onGigyaServiceReady` function on the [Window].
  ///
  /// This function is called when the Gigya Web SDK has been initialized.
  external set onGigyaServiceReady(void Function(Object? arguments) onReady);
}
