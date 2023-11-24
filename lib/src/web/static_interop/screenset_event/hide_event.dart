import 'dart:js_interop';

import '../../../models/enums/screen_set_event_type.dart';
import '../../../models/screenset_event.dart';

/// The extension type for the hide event of the `Account.showScreenset` event stream.
///
/// See: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/413a5b7170b21014bbc5a10ce4041860.html?locale=en-US#onhide-event-data
@JS()
@anonymous
@staticInterop
extension type HideEvent(JSObject _) {
  /// The name of the event.
  external String get eventName;

  /// The reason why the screen-set closed, which is either 'canceled' or 'finished'.
  external String get reason;

  /// The source plugin that generated this event.
  /// The value of this field is the name of the plugin's API method,
  /// e.g., 'showLoginUI', 'showCommentsUI', etc.
  external String get source;

  /// Serialize this event into a [ScreensetEvent].
  ScreensetEvent serialize() {
    switch (reason) {
      case 'canceled':
        return ScreensetEvent(
          ScreenSetEventType.onCancel.name,
          <String, dynamic>{'source': source},
        );
      case 'finished':
      default:
        return ScreensetEvent(
          ScreenSetEventType.onHide.name,
          <String, dynamic>{'source': source},
        );
    }
  }
}
