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
}
