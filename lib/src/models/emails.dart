/// This class represents a collection of [verified] and [unverified] email addresses.
class Emails {
  /// The default constructor.
  const Emails({
    this.unverified = const <String>[],
    this.verified = const <String>[],
  });

  /// The default constructor.
  factory Emails.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? unverified = json['unverified'] as List<dynamic>?;
    final List<dynamic>? verified = json['verified'] as List<dynamic>?;

    return Emails(
      unverified: unverified?.cast<String>() ?? <String>[],
      verified: verified?.cast<String>() ?? <String>[],
    );
  }

  /// The list of unverified email addresses.
  final List<String> unverified;

  /// The list of verified email addresses.
  final List<String> verified;

  /// Convert this object into a JSON object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'unverified': unverified,
      'verified': verified,
    };
  }
}
