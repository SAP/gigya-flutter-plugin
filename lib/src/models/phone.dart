/// This class represents a phone number that has a value,
/// a type and a fallback value.
class Phone {
  /// The private constructor.
  Phone._({
    this.defaultNumber,
    this.number,
    this.type,
  });

  /// The default constructor.
  factory Phone.fromJson(Map<String, dynamic> json) {
    return Phone._(
      defaultNumber: json['default'] as String?,
      number: json['number'] as String?,
      type: json['type'] as String?,
    );
  }

  /// The default phone number
  /// that is used as fallback if [number] was not specified.
  final String? defaultNumber;

  /// The phone number of an indivual or organisation.
  final String? number;

  /// The type of phone number.
  final String? type;

  /// Convert this object to a JSON object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'default': defaultNumber,
      'number': number,
      'type': type,
    };
  }
}
