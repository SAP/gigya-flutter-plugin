import 'package:js/js.dart';
import 'package:js/js_util.dart';

import '../../../models/screenset_event.dart';
import '../models/profile.dart';

/// This typedef defines the function signature for the handler of the screenset before submit event.
///
/// This function should return false if submission should be cancelled.
typedef BeforeSubmitEventHandler = bool Function(ScreensetEvent event);

/// The static interop class for the before submit event of the `Account.showScreenset` event stream.
///
/// See: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/413a5b7170b21014bbc5a10ce4041860.html?locale=en-US#onbeforesubmit-event-data
@JS()
@anonymous
@staticInterop
class BeforeSubmitEvent {}

/// This extension defines the static interop definition
/// for the [BeforeSubmitEvent] class.
extension BeforeSubmitEventExtension on BeforeSubmitEvent {
  /// The name of the event.
  external String get eventName;

  /// The ID of the form.
  external String get form;

  /// An object containing a copy of the form data that is about to be sent.
  external Object? get formData;

  /// The ID of the screen that is about to be loaded.
  external String? get nextScreen;

  /// The current profile data of the user. This is null if the user is not logged in.
  external Profile? get profile;

  /// The name of the screen.
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
        'formData': dartify(formData),
        'nextScreen': nextScreen,
        'profile': profile?.toMap(),
        'screen': screen,
        'source': source,
      },
    );
  }
}
