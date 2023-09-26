import 'dart:js_interop';

import 'package:web/web.dart' show Window;

import 'gigya_web_sdk.dart';

/// The static interop extension type for the [Window].
@JS()
@staticInterop
extension type GigyaWindow(Window window) {
  /// Get the `gigya` JavaScript object on the [Window].
  /// 
  /// If `window.gigya` is null or undefined, this getter returns null.
  external GigyaWebSdk? get gigya;

  /// Set the `onGigyaServiceReady` function on the [Window].
  ///
  /// This function is called when the Gigya Web SDK has been initialized.
  /// 
  /// The [onReady] function receives a nullable [JSString] as argument,
  /// and has [JSVoid] as return type.
  /// 
  /// See https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/417f6b5e70b21014bbc5a10ce4041860.html#ongigyaserviceready
  external set onGigyaServiceReady(JSFunction onReady);
}
