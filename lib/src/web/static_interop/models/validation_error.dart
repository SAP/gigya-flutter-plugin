import 'dart:js_interop';

/// The extension type for the validation error object.
@JS()
@anonymous
@staticInterop
extension type ValidationError(JSObject _) {
  /// The validation error code.
  external int get errorCode;

  /// The name of the field that caused the validation error.
  ///
  /// This field name uses dot notation, i.e. `profile.name`.
  external String get fieldName;

  /// The validation error message.
  external String get message;

  /// COnvert this validation error message to a map.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errorCode': errorCode,
      'fieldName': fieldName,
      'message': message,
    };
  }
}
