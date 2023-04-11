import 'package:js/js.dart';

/// The static interop class for the `Patent` object.
@JS()
@anonymous
@staticInterop
class Patent {}

/// This extension defines the static interop definition
/// for the [Patent] class.
extension PatentExtension on Patent {
  /// The issue date of the patent.
  external String? get date;

  /// The patent number.
  external String? get number;

  /// The name of the office that issued the patent.
  external String? get office;

  /// The status of the patent.
  external String? get status;

  /// The summary of the patent.
  external String? get summary;

  /// The title of the patent.
  external String? get title;

  /// The url to the patent document.
  external String? get url;

  /// Convert this patent into a [Map].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'number': number,
      'office': office,
      'status': status,
      'summary': summary,
      'title': title,
      'url': url,
    };
  }
}
