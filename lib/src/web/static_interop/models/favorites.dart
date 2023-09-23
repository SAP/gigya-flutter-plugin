import 'dart:js_interop';

/// The extension type for the `Favorite` object.
@JS()
@anonymous
@staticInterop
extension type Favorite(JSObject _) {
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
@anonymous
@staticInterop
extension type Favorites(JSObject _) {
  @JS('activities')
  external JSArray? get _activities;

  @JS('books')
  external JSArray? get _books;

  @JS('interests')
  external JSArray? get _interests;

  @JS('movies')
  external JSArray? get _movies;

  @JS('music')
  external JSArray? get _music;

  @JS('television')
  external JSArray? get _television;

  /// The user's favorite activities.
  List<Favorite> get activities {
    return _activities?.toDart.cast<Favorite>() ?? const <Favorite>[];
  }

  /// The user's favorite books.
  List<Favorite> get books {
    return _books?.toDart.cast<Favorite>() ?? const <Favorite>[];
  }

  /// The user's interests.
  List<Favorite> get interests {
    return _interests?.toDart.cast<Favorite>() ?? const <Favorite>[];
  }

  /// The user's favorite movies.
  List<Favorite> get movies {
    return _movies?.toDart.cast<Favorite>() ?? const <Favorite>[];
  }

  /// The user's favorite music.
  List<Favorite> get music {
    return _music?.toDart.cast<Favorite>() ?? const <Favorite>[];
  }

  /// The user's favorite television programmes.
  List<Favorite> get television {
    return _television?.toDart.cast<Favorite>() ?? const <Favorite>[];
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
