/// This class represents a patent.
class Patent {
  /// The private constructor.
  Patent._({
    this.date,
    this.number,
    this.office,
    this.status,
    this.summary,
    this.title,
    this.url,
  });

  /// The default constructor.
  factory Patent.fromJson(Map<String, dynamic> json) {
    final String? issueDate = json['date'] as String?;

    return Patent._(
      date: issueDate == null ? null : DateTime.tryParse(issueDate),
      number: json['number'] as String?,
      office: json['office'] as String?,
      status: json['status'] as String?,
      summary: json['summary'] as String?,
      title: json['title'] as String?,
      url: json['url'] as String?,
    );
  }

  /// The date the parent was issued.
  final DateTime? date;

  /// The patent number.
  final String? number;

  /// The name of the office that owns the patent.
  final String? office;

  /// The status of the patent.
  final String? status;

  /// The summary of what the patent is about.
  final String? summary;

  /// The title of the patent.
  final String? title;

  /// The url to the patent document.
  final String? url;

  /// Convert this object into a JSON object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'date': date?.toString(),
      'number': number,
      'office': office,
      'status': status,
      'summary': summary,
      'title': title,
      'url': url,
    };
  }
}
