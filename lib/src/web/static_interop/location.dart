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
  external factory Location();

  /// The name of the city in which the location is located.
  external String? get city;

  /// The coordinates of the location.
  external Coordinates? get coordinates;

  /// The two character country code of the location.
  external String? get country;

  /// The state in which the location is located.
  external String? get state;
}
