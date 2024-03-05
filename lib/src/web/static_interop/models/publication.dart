import 'dart:js_interop';

/// The extension type for the `Publication` object.
@JS()
extension type Publication._(JSObject _) implements JSObject {
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
