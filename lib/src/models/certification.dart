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
      endDate: DateTime.tryParse(json['endDate'] as String? ?? ''),
      name: json['name'] as String?,
      number: json['number'] as String?,
      startDate: DateTime.tryParse(json['startDate'] as String? ?? ''),
    );
  }

  /// The authority which issued the certification.
  final String? authority;

  /// The end date of the validity of the certification.
  final DateTime? endDate;

  /// The name of the certification.
  final String? name;

  /// The certification number.
  final String? number;

  /// The start date of the validity of the certification.
  final DateTime? startDate;

  /// Convert this object to a JSON object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'authority': authority,
      'endDate': endDate?.toIso8601String(),
      'name': name,
      'number': number,
      'startDate': startDate?.toIso8601String(),
    };
  }
}
