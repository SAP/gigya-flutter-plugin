import 'dart:js_interop';

/// The extension type for the Education object.
@JS()
extension type Education._(JSObject _) implements JSObject {
  /// The degree for the education.
  external String? get degree;

  /// The year in which the education was finished.
  external String? get endYear;

  /// The field of study of the education.
  external String? get fieldOfStudy;

  /// The name of the school at which the education took place.
  external String? get school;

  /// The type of school at which the education took place.
  external String? get schoolType;

  /// The year in which the education was started.
  external String? get startYear;

  /// Convert this education to a [Map].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'degree': degree,
      'endYear': endYear,
      'fieldOfStudy': fieldOfStudy,
      'school': school,
      'schoolType': schoolType,
      'startYear': startYear,
    };
  }
}
