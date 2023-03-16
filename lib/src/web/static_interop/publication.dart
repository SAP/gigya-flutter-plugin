import 'package:js/js.dart';

/// The static interop class for the `Publication` object.
@JS()
@anonymous
class Publication {
  /// Construct a new [Publication] instance.
  external factory Publication({
    String? date,
    String? publisher,
    String? summary,
    String? title,
    String? url,
  });

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

  /// Convert the given [publication] to a [Map].
  ///
  /// Since the [Publication] class is an anonymous JavaScript type,
  /// this has to be a static method instead of an instance method.
  static Map<String, dynamic> toMap(Publication publication) {
    return <String, dynamic>{
      'date': publication.date,
      'publisher': publication.publisher,
      'summary': publication.summary,
      'title': publication.title,
      'url': publication.url,
    };
  }
}
