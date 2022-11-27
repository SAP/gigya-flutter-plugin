/// This class represents a section within the career of an individual.
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

  /// The name of the company that the individual worked for.
  final String? company;

  /// The id of the company that the individual worked for.
  final String? companyID;

  /// The size of the [company], in amount of employees.
  final int? companySize;

  /// The description of this section within the career of the individual.
  final String? description;

  /// The end date of this section within the career of the individual.
  final DateTime? endDate;

  /// The name of the industry in which the individual was employed.
  final String? industry;

  /// Whether this section in the individual's career is equal
  /// to the current employment of the individual.
  final bool? isCurrent;

  /// The location where this section of the career of the individual takes place.
  final String? location;

  /// The start date of this section within the career of the individual.
  final DateTime? startDate;

  /// The title of this section within the career of the individual.
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
