import 'dart:js_interop';

/// The extension type for the `Coordinates` object.
@JS()
extension type Coordinates._(JSObject _) implements JSObject {
  /// The latitude of the coordinate.
  external double get lat;

  /// The longitude of the coordinate.
  external double get lon;

  /// Convert these coordinates to a [Map].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lon': lon,
    };
  }
}

/// The extension type for the `Location` object.
@JS()
extension type Location._(JSObject _) implements JSObject {
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
      if (coordinates != null) 'coordinates': coordinates!.toMap(),
      'state': state,
    };
  }
}
