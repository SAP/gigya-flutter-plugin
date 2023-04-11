import 'package:js/js.dart';

/// The static interop class for the `Favorite` object.
@JS()
@anonymous
@staticInterop
class Favorite {}

/// This extension defines the static interop definition
/// for the [Favorite] class.
extension FavoriteExtension on Favorite {
  /// The category of the favorite.
  external String? get category;

  /// The id of the favorite.
  external String? get id;

  /// The name of the favorite.
  external String? get name;

  /// Convert this favorite to a [Map].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'category': category,
    };
  }
}

/// The static interop class for the `Favorites` object.
@JS()
@anonymous
@staticInterop
class Favorites {}

/// This extension defines the static interop definition
/// for the [Favorites] class.
extension FavoritesExtension on Favorites {
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

  /// Convert this favorites object to a [Map].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'activities': activities.map((Favorite f) => f.toMap()).toList(),
      'books': books.map((Favorite f) => f.toMap()).toList(),
      'interests': interests.map((Favorite f) => f.toMap()).toList(),
      'movies': movies.map((Favorite f) => f.toMap()).toList(),
      'music': music.map((Favorite f) => f.toMap()).toList(),
      'television': television.map((Favorite f) => f.toMap()).toList(),
    };
  }
}
