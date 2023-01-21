/// This class represents an education.
class Education {
  /// The private constructor.
  Education._({
    this.degree,
    this.endYear,
    this.fieldOfStudy,
    this.school,
    this.schoolType,
    this.startYear,
  });

  /// The default constructor.
  factory Education.fromJson(Map<String, dynamic> json) {
    return Education._(
      degree: json['degree'] as String?,
      endYear: json['endYear'] as String?,
      fieldOfStudy: json['fieldOfStudy'] as String?,
      school: json['school'] as String?,
      schoolType: json['schoolType'] as String?,
      startYear: json['startYear'] as String?,
    );
  }

  /// The degree of the education.
  final String? degree;

  /// The year in which the degree was finished.
  final String? endYear;

  /// The field of study of the degree.
  final String? fieldOfStudy;

  /// The name of the school where the degree was taught.
  final String? school;

  /// The type of the school where the degree was taught.
  final String? schoolType;

  /// The year in which the degree was started.
  final String? startYear;

  /// Convert this object into a JSON object.
  Map<String, dynamic> toJson() {
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
