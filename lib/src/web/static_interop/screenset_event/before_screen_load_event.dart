import 'dart:js_interop';

import '../../../models/screenset_event.dart';
import '../models/profile.dart';

/// The extension type for the before screen load event of the `Account.showScreenset` event stream.
///
/// See: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/413a5b7170b21014bbc5a10ce4041860.html?locale=en-US#onbeforescreenload-event-data
@JS()
@anonymous
@staticInterop
extension type BeforeScreenLoadEvent(JSObject _) {
  /// The name of the current screen, before the screen switch.
  external String get currentScreen;

  /// The site custom data fields related to the user,
  /// as known before the form submission.
  external JSAny? get data;

  /// The name of the event.
  external String get eventName;

  /// The name of the form that triggered this screen switch.
  external String get form;

  /// The name of the screen about to be loaded.
  external String get nextScreen;

  /// The user's profile data. This is null if the user is not logged in.
  external Profile? get profile;

  /// The response of the previous screen's submit operation.
  external JSAny? get response;

  /// The source plugin that generated this event.
  /// The value of this field is the name of the plugin's API method,
  /// e.g., 'showLoginUI', 'showCommentsUI', etc.
  external String get source;

  /// Serialize this event into a [ScreensetEvent].
  ScreensetEvent serialize() {
    return ScreensetEvent(
      eventName,
      <String, dynamic>{
        'currentScreen': currentScreen,
        'data': data.dartify(),
        'form': form,
        'nextScreen': nextScreen,
        'profile': profile?.toMap(),
        'response': response.dartify(),
        'source': source,
      },
    );
  }
}
