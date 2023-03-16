import 'package:js/js.dart';

/// The static interop class for the `Work` object.
@JS()
@anonymous
class Work {
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

  /// The name of the company.
  external String? get company;

  /// The size of the company in number of employees.
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

  /// The user's title in the company.
  external String? get title;

  /// Convert the given [work] to a [Map].
  ///
  /// Since the [Work] class is an anonymous JavaScript type,
  /// this has to be a static method instead of an instance method.
  static Map<String, dynamic> toMap(Work work) {
    return <String, dynamic>{
      'company': work.company,
      'companyID': work.companyID,
      'companySize': work.companySize,
      'endDate': work.endDate,
      'industry': work.industry,
      'isCurrent': work.isCurrent,
      'startDate': work.startDate,
      'title': work.title,
    };
  }
}
