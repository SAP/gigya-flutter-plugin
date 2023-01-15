import 'address.dart';

/// This class represents the OIDC struct.
class OidcData {
  /// The private constructor.
  OidcData._({
    this.address,
    this.emailVerified,
    this.locale,
    this.middleName,
    this.name,
    this.phoneNumber,
    this.phoneNumberVerified,
    this.updatedAt,
    this.website,
    this.zoneInfo,
  });

  /// The default constructor.
  factory OidcData.fromJson(Map<String, dynamic> json) {
    final String? updatedAt = json['updated_at'] as String?;
    final Map<String, dynamic>? address =
        json['address'] as Map<String, dynamic>?;

    return OidcData._(
      address: address == null ? null : Address.fromJson(address),
      emailVerified: json['email_verified'] as String?,
      locale: json['locale'] as String?,
      middleName: json['middle_name'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      phoneNumberVerified: json['phone_number_verified'] as String?,
      updatedAt: updatedAt == null ? null : DateTime.tryParse(updatedAt),
      website: json['website'] as String?,
      zoneInfo: json['zoneinfo'] as String?,
    );
  }

  /// The address of the user.
  final Address? address;

  /// The verified email address of the user.
  final String? emailVerified;

  /// The language locale of the user.
  final String? locale;

  /// The middle name of the user.
  final String? middleName;

  /// The name of the user.
  final String? name;

  /// The phone number of the user.
  final String? phoneNumber;

  /// The verified phone number of the user.
  final String? phoneNumberVerified;

  /// The timestamp when the user was last updated.
  final DateTime? updatedAt;

  /// The website url of the user.
  final String? website;

  /// The zone info of the user.
  final String? zoneInfo;

  /// Convert this object into a JSON object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (address != null) 'address': address!.toJson(),
      'email_verified': emailVerified,
      'locale': locale,
      'middle_name': middleName,
      'name': name,
      'phone_number': phoneNumber,
      'phone_number_verified': phoneNumberVerified,
      'updated_at': updatedAt?.toString(),
      'website': website,
      'zoneinfo': zoneInfo,
    };
  }
}
