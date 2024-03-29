/// This class represents an employment within the career of an individual.
class Work {
  /// The private constructor.
  Work._({
    this.company,
    this.companyID,
    this.companySize,
    this.description,
    this.endDate,
    this.industry,
    this.isCurrent,
    this.location,
    this.startDate,
    this.title,
  });

  /// The default constructor.
  factory Work.fromJson(Map<String, dynamic> json) {
    final String? endDate = json['endDate'] as String?;
    final String? startDate = json['startDate'] as String?;

    // TODO: company size should be an int, not a double.
    final double? companySize = json['companySize'] as double?;

    return Work._(
      company: json['company'] as String?,
      companyID: json['companyID'] as String?,
      companySize: companySize?.toInt(),
      description: json['description'] as String?,
      endDate: endDate == null ? null : DateTime.tryParse(endDate),
      industry: json['industry'] as String?,
      isCurrent: json['isCurrent'] as bool?,
      location: json['location'] as String?,
      startDate: startDate == null ? null : DateTime.tryParse(startDate),
      title: json['title'] as String?,
    );
  }

  /// The name of the company.
  final String? company;

  /// The id of the company.
  final String? companyID;

  /// The size of the [company], in amount of employees.
  final int? companySize;

  /// The description of this employment.
  final String? description;

  /// The date when this employment ended.
  final DateTime? endDate;

  /// The name of the industry in which this employment is categorized.
  final String? industry;

  /// Whether this employment is the current employment of the individual.
  final bool? isCurrent;

  /// The location where this employment occurs.
  final String? location;

  /// The date when this employment started.
  final DateTime? startDate;

  /// The title of the employment.
  final String? title;

  /// Convert this object to a JSON object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'company': company,
      'companyID': companyID,
      // TODO: company size should be an int, not a double.
      'companySize': companySize?.toDouble(),
      'description': description,
      'endDate': endDate?.toString(),
      'industry': industry,
      'isCurrent': isCurrent,
      'location': location,
      'startDate': startDate?.toString(),
      'title': title,
    };
  }
}
