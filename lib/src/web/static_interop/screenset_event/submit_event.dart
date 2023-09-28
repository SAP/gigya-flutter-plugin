import 'dart:js_interop';

import '../../../models/screenset_event.dart';

/// The extension type for the submit event of the `Account.showScreenset` event stream.
///
/// See: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/413a5b7170b21014bbc5a10ce4041860.html?locale=en-US#onsubmit-event-data
@JS()
@anonymous
@staticInterop
extension type SubmitEvent(JSObject _) {
  /// An object that contains the user's account information.
  /// Only the `data`, `profile` and `subscriptions` are included.
  ///
  /// This is null if the user is not logged in.
  external JSAny? get accountInfo;

  /// The name of the event.
  external String get eventName;

  /// The name of the form that is about to be submitted.
  external String get form;

  /// The name of the screen that contains the form that is about to be submitted.
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
        'accountInfo': accountInfo.dartify(),
        'form': form,
        'screen': screen,
        'source': source,
      },
    );
  }
}
