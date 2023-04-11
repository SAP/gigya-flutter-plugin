import 'package:js/js.dart';

/// The static interop class for the `Publication` object.
@JS()
@anonymous
@staticInterop
class Publication {}

/// This extension defines the static interop definition
/// for the [Publication] class.
extension PublicationExtension on Publication {
  /// The publication date.
  external String? get date;

  /// The name of the publisher that published the publication.
  external String? get publisher;

  /// The summary of the publication.
  external String? get summary;

  /// The title of the publication.
  external String? get title;

  /// The url to the publication's document.
  external String? get url;

  /// Convert this publication into a [Map].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'publisher': publisher,
      'summary': summary,
      'title': title,
      'url': url,
    };
  }
}
