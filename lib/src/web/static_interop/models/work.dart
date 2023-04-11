import 'package:js/js.dart';

/// The static interop class for the `Work` object.
@JS()
@anonymous
@staticInterop
class Work {}

/// This extension defines the static interop definition
/// for the [Work] class.
extension WorkExtension on Work {
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
