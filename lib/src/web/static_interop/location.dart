import 'package:js/js.dart';

/// The static interop class for the `Coordinates` object.
@JS()
@anonymous
class Coordinates {
  /// Construct a new [Coordinates] instance.
  external factory Coordinates(String? lat, String? lon);

  /// The longitude of the coordinate.
  external double? get lat;

  /// The latitude of the coordinate.
  external double? get lon;
}

/// The static interop class for the `Location` object.
@JS()
@anonymous
class Location {
  /// Construct a new [Location] instance.
  external factory Location({
    String? city,
    Coordinates? coordinates,
    String? country,
    String? state,
  });

  /// The name of the city in which the location is located.
  external String? get city;

  /// The coordinates of the location.
  external Coordinates? get coordinates;

  /// The two character country code of the location.
  external String? get country;

  /// The state in which the location is located.
  external String? get state;

  /// Convert the given [location] to a [Map].
  ///
  /// Since the [Location] class is an anonymous JavaScript type,
  /// this has to be a static method instead of an instance method.
  static Map<String, dynamic> toMap(Location location) {
    return <String, dynamic>{
      'city': location.city,
      'country': location.country,
      'coordinates': <String, dynamic>{
        'lat': location.coordinates?.lat,
        'lon': location.coordinates?.lon,
      },
      'state': location.state,
    };
  }
}
