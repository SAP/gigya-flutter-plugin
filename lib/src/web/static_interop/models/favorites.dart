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
  @JS('activities')
  external List<dynamic>? get _activities;

  @JS('books')
  external List<dynamic>? get _books;

  @JS('interests')
  external List<dynamic>? get _interests;

  @JS('movies')
  external List<dynamic>? get _movies;

  @JS('music')
  external List<dynamic>? get _music;

  @JS('television')
  external List<dynamic>? get _television;

  /// The user's favorite activities.
  List<Favorite> get activities {
    return _activities?.cast<Favorite>() ?? <Favorite>[];
  }

  /// The user's favorite books.
  List<Favorite> get books => _books?.cast<Favorite>() ?? <Favorite>[];

  /// The user's interests.
  List<Favorite> get interests => _interests?.cast<Favorite>() ?? <Favorite>[];

  /// The user's favorite movies.
  List<Favorite> get movies => _movies?.cast<Favorite>() ?? <Favorite>[];

  /// The user's favorite music.
  List<Favorite> get music => _music?.cast<Favorite>() ?? <Favorite>[];

  /// The user's favorite television programmes.
  List<Favorite> get television => _television?.cast<Favorite>() ?? <Favorite>[];

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
