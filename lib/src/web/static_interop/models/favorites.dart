import 'dart:js_interop';

/// The extension type for the `Favorite` object.
@JS()
extension type Favorite._(JSObject _) implements JSObject {
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

/// The extension type for the `Favorites` object.
@JS()
extension type Favorites._(JSObject _) implements JSObject {
  @JS('activities')
  external JSArray<Favorite>? get _activities;

  @JS('books')
  external JSArray<Favorite>? get _books;

  @JS('interests')
  external JSArray<Favorite>? get _interests;

  @JS('movies')
  external JSArray<Favorite>? get _movies;

  @JS('music')
  external JSArray<Favorite>? get _music;

  @JS('television')
  external JSArray<Favorite>? get _television;

  /// The user's favorite activities.
  List<Favorite> get activities {
    return _activities?.toDart ?? const <Favorite>[];
  }

  /// The user's favorite books.
  List<Favorite> get books {
    return _books?.toDart ?? const <Favorite>[];
  }

  /// The user's interests.
  List<Favorite> get interests {
    return _interests?.toDart ?? const <Favorite>[];
  }

  /// The user's favorite movies.
  List<Favorite> get movies {
    return _movies?.toDart ?? const <Favorite>[];
  }

  /// The user's favorite music.
  List<Favorite> get music {
    return _music?.toDart ?? const <Favorite>[];
  }

  /// The user's favorite television programmes.
  List<Favorite> get television {
    return _television?.toDart ?? const <Favorite>[];
  }

  /// Convert this object to a [Map].
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
