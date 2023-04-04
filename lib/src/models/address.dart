/// This class represents an address.
class Address {
  /// The private constructor.
  Address._({
    this.country,
    this.formatted,
    this.locality,
    this.postalCode,
    this.region,
    this.streetAddress,
  });

  /// The default constructor.
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address._(
      country: json['country'] as String?,
      formatted: json['formatted'] as String?,
      locality: json['locality'] as String?,
      postalCode: json['postal_code'] as String?,
      region: json['region'] as String?,
      streetAddress: json['street_address'] as String?,
    );
  }

  /// The country in which the address is located.
  final String? country;

  /// The formatted address.
  final String? formatted;

  /// The locality of the address.
  final String? locality;

  /// The postal code of the address.
  final String? postalCode;

  /// The name of the region in which the address is located.
  final String? region;

  /// The street address part of this address.
  final String? streetAddress;

  /// Convert this object into a JSON object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'country': country,
      'formatted': formatted,
      'locality': locality,
      'postal_code': postalCode,
      'region': region,
      'street_address': streetAddress,
    };
  }
}
