import 'package:js/js.dart';
import 'package:js/js_util.dart';

import '../../../models/screenset_event.dart';

/// This typedef defines the function signature for the handler of the screenset before validation event.
///
/// This function should return a [Future] that resolves with a [Map] containing the error messages per field in the form.
/// If there are no errors, this future should resolve with `null` as value.
typedef BeforeValidationEventHandler = Future<Map<String, dynamic>?> Function(ScreensetEvent event);

/// The static interop class for the before validation event of the `Account.showScreenset` event stream.
///
/// See: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/413a5b7170b21014bbc5a10ce4041860.html?locale=en-US#onbeforevalidation
@JS()
@anonymous
@staticInterop
class BeforeValidationEvent {}

/// This extension defines the static interop definition
/// for the [BeforeValidationEvent] class.
extension BeforeValidationEventExtension on BeforeValidationEvent {
  /// The data object for the user. This will be empty if the user is not logged in.
  external Object? get data;

  /// The name of the event.
  external String get eventName;

  /// The ID of the form that failed.
  external String get form;

  /// An object containing the properties of the form fields.
  external Object? get formData;

  /// The profile object for the user. This will be empty if the user is not logged in.
  external Object? get profile;

  /// The name of the screen on which the form was submitted.
  external String get screen;

  /// The source plugin that generated this event.
  /// The value of this field is the name of the plugin's API method,
  /// e.g., 'showLoginUI', 'showCommentsUI', etc.
  external String get source;

  /// The subscriptions data for the user. This will be empty if the user is not logged in.
  external Object? get subscriptions;

  /// Serialize this event into a [ScreensetEvent].
  ScreensetEvent serialize() {
    return ScreensetEvent(
      eventName,
      <String, dynamic>{
        'data': dartify(data),
        'form': form,
        'formData': dartify(formData),
        'profile': dartify(profile),
        'screen': screen,
        'source': source,
        'subscriptions': dartify(subscriptions),
      },
    );
  }
}
