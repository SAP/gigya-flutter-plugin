import 'package:js/js.dart';

/// The static interop class for the emails object.
@JS()
@anonymous
class Emails {
  /// Create a new [Emails] instance.
  external factory Emails({
    List<dynamic> unverified,
    List<dynamic> verified,
  });

  /// The list of unverified email addresses.
  external List<dynamic> get unverified;

  /// The list of verified email addresses.
  external List<dynamic> get verified;
}
