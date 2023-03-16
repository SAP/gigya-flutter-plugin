import 'package:js/js.dart';

/// The static interop class for the Education object.
@JS()
@anonymous
class Education {
  /// Construct a new [Education] instance.
  external factory Education({
    String? degree,
    String? endYear,
    String? fieldOfStudy,
    String? school,
    String? schoolType,
    String? startYear,
  });

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
}
