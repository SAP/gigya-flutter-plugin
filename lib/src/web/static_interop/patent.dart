import 'package:js/js.dart';

/// The static interop class for the `Patent` object.
@JS()
@anonymous
class Patent {
  /// Construct a new [Patent] instance.
  external factory Patent({
    String? date,
    String? number,
    String? office,
    String? status,
    String? summary,
    String? title,
    String? url,
  });

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

  /// Convert the given [patent] to a [Map].
  ///
  /// Since the [Patent] class is an anonymous JavaScript type,
  /// this has to be a static method instead of an instance method.
  static Map<String, dynamic> toMap(Patent patent) {
    return <String, dynamic>{
      'date': patent.date,
      'number': patent.number,
      'office': patent.office,
      'status': patent.status,
      'summary': patent.summary,
      'title': patent.title,
      'url': patent.url,
    };
  }
}
