import 'dart:js_interop';

import '../global_events/login_event.dart';

/// The extension type that defines the parameters for the `Accounts.addEventHandlers` function.
///
/// The `onLogout`, `onConnectionAdded` and `onConnectionRemoved` handlers are specifically omitted from this class,
/// since the methods that emit these events also support a callback function,
/// which is used in specific static interop definitions for these events.
///
/// The `onError` handler is specifically omitted from this class.
/// If the Gigya SDK fails to initialize, a timeout exception is thrown instead.
/// For screen sets, the error event is passed to the [Stream] directly.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/41532ab870b21014bbc5a10ce4041860.html#global-application-events
@JS()
@anonymous
@staticInterop
extension type AddEventHandlersParameters._(JSObject _) implements JSObject {
  /// Construct a new [AddEventHandlersParameters] instance.
  /// 
  /// The [onAfterResponse] function receives a nullable [JSAny] argument,
  /// and has [JSVoid] as return type.
  /// 
  /// The [onLogin] function receives a [LoginEvent] argument,
  /// and has [JSVoid] as return type.
  external factory AddEventHandlersParameters({
    JSFunction? onAfterResponse,
    JSFunction? onLogin,
  });
}
