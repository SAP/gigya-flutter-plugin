import 'package:js/js.dart';
import 'package:js/js_util.dart';

import '../../../models/screenset_event.dart';

/// This typedef defines the function signature for the handler of the screenset error event.
///
/// This function may return a [Map] with a `nextScreen` key.
typedef ErrorEventHandler = Map<String, dynamic>? Function(ScreensetEvent event);

/// The static interop class for the error event of the `Account.showScreenset` event stream.
///
/// See: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/413a5b7170b21014bbc5a10ce4041860.html?locale=en-US#onerror-event-data
@JS()
@anonymous
@staticInterop
class ErrorEvent {}

/// This extension defines the static interop definition
/// for the [ErrorEvent] class.
extension ErrorEventExtension on ErrorEvent {
  /// The name of the event.
  external String get eventName;

  /// The ID of the form that failed.
  external String get form;

  /// The response of the encapsulated API call that failed.
  external Object? get response;

  /// The ID of the screen that contains the form that failed.
  external String get screen;

  /// The source plugin that generated this event.
  /// The value of this field is the name of the plugin's API method,
  /// e.g., 'showLoginUI', 'showCommentsUI', etc.
  external String get source;

  /// Serialize this event into a [ScreensetEvent].
  ScreensetEvent serialize() {
    return ScreensetEvent(
      eventName,
      <String, dynamic>{
        'form': form,
        'response': dartify(response),
        'screen': screen,
        'source': source,
      },
    );
  }
}
