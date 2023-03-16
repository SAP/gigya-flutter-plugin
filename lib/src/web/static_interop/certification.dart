import 'package:js/js.dart';

/// The static interop class for the Certification object.
@JS()
@anonymous
class Certification {
  /// Create a new [Certification] instance.
  external factory Certification({
    String? authority,
    String? endDate,
    String? name,
    String? number,
    String? startDate,
  });

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

  /// Convert the given [certification] to a [Map].
  ///
  /// Since the [Certification] class is an anonymous JavaScript type,
  /// this has to be a static method instead of an instance method.
  static Map<String, dynamic> toMap(Certification certification) {
    return <String, dynamic>{
      'authority': certification.authority,
      'endDate': certification.endDate,
      'name': certification.name,
      'number': certification.number,
      'startDate': certification.startDate,
    };
  }
}
