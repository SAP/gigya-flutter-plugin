/// This class represents a certification.
class Certification {
  /// The private constructor.
  Certification._({
    this.authority,
    this.endDate,
    this.name,
    this.number,
    this.startDate,
  });

  /// The default constructor.
  factory Certification.fromJson(Map<String, dynamic> json) {
    return Certification._(
      authority: json['authority'] as String?,
      endDate: json['endDate'] as String?,
      name: json['name'] as String?,
      number: json['number'] as String?,
      startDate: json['startDate'] as String?,
    );
  }

  /// The authority which issued the certification.
  final String? authority;

  /// The end date of the validity of the certification.
  final String? endDate;

  /// The name of the certification.
  final String? name;

  /// The certification number.
  final String? number;

  /// The start date of the validity of the certification.
  final String? startDate;

  /// Convert this object to a JSON object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'authority': authority,
      'endDate': endDate,
      'name': name,
      'number': number,
      'startDate': startDate,
    };
  }
}
