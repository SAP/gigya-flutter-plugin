import 'dart:js_interop';

import '../../../models/screenset_event.dart';
import '../models/profile.dart';

/// The extension type for the after validation event of the `Account.showScreenset` event stream.
///
/// See: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/413a5b7170b21014bbc5a10ce4041860.html?locale=en-US#onaftervalidation
@JS()
@anonymous
@staticInterop
extension type AfterValidationEvent(JSObject _) {
  /// The data object for the user. This will be empty if the user is not logged in.
  external JSAny? get data;

  /// The name of the event.
  external String get eventName;

  /// The ID of the form.
  external String get form;

  /// The profile object for the user.
  /// This will be empty if the user is not logged in.
  external Profile? get profile;

  /// The name of the screen.
  external String get screen;

  /// The source plugin that generated this event.
  /// The value of this field is the name of the plugin's API method,
  /// e.g., 'showLoginUI', 'showCommentsUI', etc.
  external String get source;

  // TODO: This should be the subscriptions static interop type.

  /// The subscriptions data for the user. This will be empty if the user is not logged in.
  external JSAny? get subscriptions;

  /// An object containing the data for any fields that failed validation.
  external JSAny? get validationErrors;

  /// Serialize this event into a [ScreensetEvent].
  ScreensetEvent serialize() {
    return ScreensetEvent(
      eventName,
      <String, dynamic>{
        'data': data.dartify(),
        'form': form,
        'profile': profile?.toMap(),
        'screen': screen,
        'source': source,
        'subscriptions': subscriptions.dartify(),
        'validationErrors': validationErrors.dartify(),
      },
    );
  }
}