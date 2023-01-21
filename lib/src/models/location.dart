/// This class represents a location.
class Location {
  /// The private constructor.
  Location._({
    this.city,
    this.coordinates,
    this.country,
    this.state,
  });

  /// The default constructor.
  factory Location.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? jsonCoordinates =
        json['coordinates'] as Map<String, dynamic>?;

    final double? latitude = jsonCoordinates?['lat'] as double?;
    final double? longitude = jsonCoordinates?['lon'] as double?;

    Coordinates? coordinates;

    if (latitude != null && longitude != null) {
      coordinates = Coordinates(latitude: latitude, longitude: longitude);
    }

    return Location._(
      city: json['city'] as String?,
      coordinates: coordinates,
      country: json['country'] as String?,
      state: json['state'] as String?,
    );
  }

  /// The name of the city at the given [coordinates].
  final String? city;

  /// The coordinates of the location.
  final Coordinates? coordinates;

  /// The name of the country at the given [coordinates].
  final String? country;

  /// The name of the state at the given [coordinates].
  final String? state;

  /// Convert this object to a JSON object.
  Map<String, dynamic> toJson() {
    final Coordinates? latLng = coordinates;

    return <String, dynamic>{
      'city': city,
      if (latLng != null) 'coordinates': latLng.toJson(),
      'country': country,
      'state': state,
    };
  }
}

/// This class represents a set of coordinates.
class Coordinates {
  /// The default constructor.
  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  /// The latitude of the coordinate.
  final double latitude;

  /// The longitude of the coordinate.
  final double longitude;

  /// Convert the coordinates to a JSON object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'lat': latitude,
      'lon': longitude,
    };
  }
}
