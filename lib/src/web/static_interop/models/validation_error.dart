import 'package:js/js.dart';

/// The static interop class for the validation error object.
@JS()
@anonymous
@staticInterop
class ValidationError {}

/// This extension defines the static interop definition
/// for the [ValidationError] class.
extension ValidationErrorExtension on ValidationError {
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
