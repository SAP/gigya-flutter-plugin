import 'package:js/js.dart';

/// The static interop class for the emails object.
@JS()
@anonymous
@staticInterop
class Emails {}

/// This extension defines the static interop definition
/// for the [Emails] class.
extension EmailsExtension on Emails {
  @JS('unverified')
  external List<dynamic>? get _unverified;

  @JS('verified')
  external List<dynamic>? get _verified;

  /// The list of unverified email addresses.
  List<String> get unverified => _unverified?.cast<String>() ?? <String>[];

  /// The list of verified email addresses.
  List<String> get verified => _verified?.cast<String>() ?? <String>[];
}
