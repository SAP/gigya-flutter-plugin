import 'dart:js_interop';

/// The extension type for the `Work` object.
@JS()
@anonymous
@staticInterop
extension type Work._(JSObject _) {
  /// Construct a new [Work] instance.
  external factory Work({
    String? company,
    int? companySize,
    String? companyID,
    String? endDate,
    String? industry,
    bool? isCurrent,
    String? startDate,
    String? title,
  });

  /// Create a new [Work] instance from the given [map].
  factory Work.fromMap(Map<String, dynamic> map) {
    return Work(
      company: map['company'] as String?,
      companyID: map['companyID'] as String?,
      companySize: map['companySize'] as int?,
      endDate: map['endDate'] as String?,
      industry: map['industry'] as String?,
      isCurrent: map['isCurrent'] as bool?,
      startDate: map['startDate'] as String?,
      title: map['title'] as String?,
    );
  }

  /// The name of the company.
  external String? get company;

  /// The size of the [company] in number of employees.
  external int? get companySize;

  /// The id of the company.
  external String? get companyID;

  /// The date the user stopped working at the company.
  external String? get endDate;

  /// The industry of the company.
  external String? get industry;

  /// Whether the user currently works at the company.
  external bool? get isCurrent;

  /// The date the user started working at the company.
  external String? get startDate;

  /// The user's title in the [company].
  external String? get title;

  /// Convert this work object into a [Map].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'company': company,
      'companyID': companyID,
      'companySize': companySize,
      'endDate': endDate,
      'industry': industry,
      'isCurrent': isCurrent,
      'startDate': startDate,
      'title': title,
    };
  }
}
