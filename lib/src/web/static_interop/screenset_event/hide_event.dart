import 'package:js/js.dart';

import '../../../models/screenset_event.dart';

/// The static interop class for the hide event of the `Account.showScreenset` event stream.
///
/// See: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/413a5b7170b21014bbc5a10ce4041860.html?locale=en-US#onhide-event-data
@JS()
@anonymous
@staticInterop
class HideEvent {}

/// This extension defines the static interop definition
/// for the [HideEvent] class.
extension HideEventExtension on HideEvent {
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
    return ScreensetEvent(
      eventName,
      <String, dynamic>{
        'reason': reason,
        'source': source,
      },
    );
  }
}
