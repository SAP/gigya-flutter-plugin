/// This class represents a publication.
class Publication {
  /// The private constructor.
  Publication._({
    this.date,
    this.publisher,
    this.summary,
    this.title,
    this.url,
  });

  /// The default constructor.
  factory Publication.fromJson(Map<String, dynamic> json) {
    final String? publishDate = json['date'] as String?;

    return Publication._(
      date: publishDate == null ? null : DateTime.tryParse(publishDate),
      publisher: json['publisher'] as String?,
      summary: json['summary'] as String?,
      title: json['title'] as String?,
      url: json['url'] as String?,
    );
  }

  /// The date of the publication.
  final DateTime? date;

  /// The name of the publisher.
  final String? publisher;

  /// The summary of the publication.
  final String? summary;

  /// The title of the publication.
  final String? title;

  /// The url to the publication.
  final String? url;

  /// Convert this object to a JSON object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'date': date?.toIso8601String(),
      'publisher': publisher,
      'summary': summary,
      'title': title,
      'url': url,
    };
  }
}
