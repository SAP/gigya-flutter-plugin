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
}
