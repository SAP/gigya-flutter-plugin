import 'package:js/js.dart';

import '../response/response.dart';

// TODO: refactor to extension type
// - AddEventHandlersParameters class
// - LoginGlobalEventResponse class

/// This class represents the parameters for the `Accounts.addEventHandlers` function,
/// which registers event handlers for global events in the Gigya SDK.
///
/// The `onLogout`, `onConnectionAdded` and `onConnectionRemoved` handlers are specifically omitted from this class,
/// since the methods that emit these events also support a callback function.
///
/// The `onError` handler is specifically omitted from this class.
/// If the Gigya SDK fails to initialize, a timeout exception is thrown instead.
/// For screen sets, the error event is passed to the [Stream] directly.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/41532ab870b21014bbc5a10ce4041860.html#global-application-events
@JS()
@anonymous
@staticInterop
class AddEventHandlersParameters {
  /// Construct a new [AddEventHandlersParameters] instance.
  external factory AddEventHandlersParameters({
    // TODO: the documentation does not specify the structure of `onAfterResponse` response.
    void Function(Object? response)? onAfterResponse,
    void Function(LoginGlobalEventResponse response)? onLogin,
  });
}
