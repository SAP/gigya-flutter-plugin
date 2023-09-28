import 'dart:js_interop';

import '../../../models/screenset_event.dart';

/// The extension type for the field changed event of the `Account.showScreenset` event stream.
///
/// See: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/413a5b7170b21014bbc5a10ce4041860.html?locale=en-US#onfieldchanged-event-data
@JS()
@anonymous
@staticInterop
extension type FieldChangedEvent(JSObject _) {
  /// The error message for the [field].
  external String? get errMsg;

  /// The name of the event.
  external String get eventName;

  /// Whether the [field] is currently valid.
  external bool get isValid;

  /// The name of the field that changed.
  external String get field;

  /// The name of the form that contains the changed field.
  external String get form;

  /// The name of the screen that contains the changed field.
  external String get screen;

  /// The source plugin that generated this event.
  /// The value of this field is the name of the plugin's API method,
  /// e.g., 'showLoginUI', 'showCommentsUI', etc.
  external String get source;

  /// The current value of the [field].
  external String? get value;

  /// Serialize this event into a [ScreensetEvent].
  ScreensetEvent serialize() {
    return ScreensetEvent(
      eventName,
      <String, dynamic>{
        'errMsg': errMsg,
        'isValid': isValid,
        'field': field,
        'form': form,
        'screen': screen,
        'source': source,
        'value': value,
      },
    );
  }
}
