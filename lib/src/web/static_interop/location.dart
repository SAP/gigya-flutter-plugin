import 'package:js/js.dart';

/// The static interop class for the `Coordinates` object.
@JS()
@anonymous
@staticInterop
class Coordinates {
  /// Construct a new [Coordinates] instance.
  external factory Coordinates({String? lat, String? lon});
}

/// This extension defines the static interop definition
/// for the [Coordinates] class.
extension CoordinatesExtension on Coordinates {
  /// The longitude of the coordinate.
  external double? get lat;

  /// The latitude of the coordinate.
  external double? get lon;
}

/// The static interop class for the `Location` object.
@JS()
@anonymous
@staticInterop
class Location {
  /// Construct a new [Location] instance.
  external factory Location({
    String? city,
    Coordinates? coordinates,
    String? country,
    String? state,
  });
}

/// This extension defines the static interop definition
/// for the [Location] class.
extension LocationExtension on Location {
  /// The name of the city in which the location is located.
  external String? get city;

  /// The coordinates of the location.
  external Coordinates? get coordinates;

  /// The two character country code of the location.
  external String? get country;

  /// The state in which the location is located.
  external String? get state;

  /// Convert this location to a [Map].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'city': city,
      'country': country,
      'coordinates': <String, dynamic>{
        'lat': coordinates?.lat,
        'lon': coordinates?.lon,
      },
      'state': state,
    };
  }
}
