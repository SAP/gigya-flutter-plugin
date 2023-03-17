import 'package:js/js.dart';

/// The static interop class for the Certification object.
@JS()
@anonymous
@staticInterop
class Certification {
  /// Create a new [Certification] instance.
  external factory Certification({
    String? authority,
    String? endDate,
    String? name,
    String? number,
    String? startDate,
  });
}

/// This extension defines the static interop definition
/// for the [Certification] class.
extension CertificationExtension on Certification {
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
