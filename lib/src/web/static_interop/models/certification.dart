import 'dart:js_interop';

/// The extension type for the Certification object.
@JS()
@anonymous
@staticInterop
extension type Certification._(JSObject _) {
  /// Create a new [Certification] instance.
  external factory Certification({
    String? authority,
    String? endDate,
    String? name,
    String? number,
    String? startDate,
  });

  /// Create a new [Certification] instance from the given [map].
  factory Certification.fromMap(Map<String, dynamic> map) {
    return Certification(
      authority: map['authority'] as String?,
      endDate: map['endDate'] as String?,
      name: map['name'] as String?,
      number: map['number'] as String?,
      startDate: map['startDate'] as String?,
    );
  }

  /// The certification authority.
  external String? get authority;

  /// The date that the certification expired.
  external String? get endDate;

  /// The name of the certification.
  external String? get name;

  /// The certification number.
  external String? get number;

  /// The date that the certification was issued.
  external String? get startDate;

  /// Convert this certification to a [Map].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'authority': authority,
      'endDate': endDate,
      'name': name,
      'number': number,
      'startDate': startDate,
    };
  }
}
