import 'package:js/js.dart';

/// The static interop class for the emails object.
@JS()
@anonymous
@staticInterop
class Emails {
  /// Create a new [Emails] instance.
  external factory Emails({
    List<dynamic> unverified,
    List<dynamic> verified,
  });
}

/// This extension defines the static interop definition
/// for the [Emails] class.
extension EmailsExtension on Emails {
  /// The list of unverified email addresses.
  external List<dynamic> get unverified;

  /// The list of verified email addresses.
  external List<dynamic> get verified;
}
