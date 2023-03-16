import 'package:js/js.dart';

/// The static interop class for the `Favorite` object.
@JS()
@anonymous
class Favorite {
  /// Construct a new [Favorite] instance.
  external factory Favorite({
    String? category,
    String? id,
    String? name,
  });

  /// The category of the favorite.
  external String? get category;

  /// The id of the favorite.
  external String? get id;

  /// The name of the favorite.
  external String? get name;
}

/// The static interop class for the `Favorites` object.
@JS()
@anonymous
class Favorites {
  /// Construct a new [Favorites] instance.
  external factory Favorites({
    List<Favorite> activities,
    List<Favorite> books,
    List<Favorite> interests,
    List<Favorite> movies,
    List<Favorite> music,
    List<Favorite> television,
  });

  /// The user's favorite activities.
  external List<Favorite> get activities;

  /// The user's favorite books.
  external List<Favorite> get books;

  /// The user's interests.
  external List<Favorite> get interests;

  /// The user's favorite movies.
  external List<Favorite> get movies;

  /// The user's favorite music.
  external List<Favorite> get music;

  /// The user's favorite television programmes.
  external List<Favorite> get television;
}
