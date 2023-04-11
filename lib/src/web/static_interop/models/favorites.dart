import 'dart:js_interop';

/// The extension type for the `Favorite` object.
@JS()
@anonymous
@staticInterop
extension type Favorite._(JSObject _) implements JSObject {
  /// Construct a new [Favorite] instance.
  external factory Favorite({
    String? category,
    String? id,
    String? name,
  });

  /// Create a new [Favorite] instance from the given [map].
  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      category: map['category'] as String?,
      id: map['id'] as String?,
      name: map['name'] as String?,
    );
  }

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
extension type Favorites._(JSObject _) {
  /// Construct a new [Favorites] instance.
  external factory Favorites({
    JSArray activities,
    JSArray books,
    JSArray interests,
    JSArray movies,
    JSArray music,
    JSArray television,
  });

  /// Create a new [Favorites] instance from the given [map].
  factory Favorites.fromMap(Map<String, dynamic> map) {
    final List<Map<String, dynamic>> activities =
        map['activities'] as List<Map<String, dynamic>>? ?? const <Map<String, dynamic>>[];
    final List<Map<String, dynamic>> books =
        map['books'] as List<Map<String, dynamic>>? ?? const <Map<String, dynamic>>[];
    final List<Map<String, dynamic>> interests =
        map['interests'] as List<Map<String, dynamic>>? ?? const <Map<String, dynamic>>[];
    final List<Map<String, dynamic>> movies =
        map['movies'] as List<Map<String, dynamic>>? ?? const <Map<String, dynamic>>[];
    final List<Map<String, dynamic>> music =
        map['music'] as List<Map<String, dynamic>>? ?? const <Map<String, dynamic>>[];
    final List<Map<String, dynamic>> television =
        map['television'] as List<Map<String, dynamic>>? ?? const <Map<String, dynamic>>[];

    return Favorites(
      activities: activities.map(Favorite.fromMap).toList().toJS,
      books: books.map(Favorite.fromMap).toList().toJS,
      interests: interests.map(Favorite.fromMap).toList().toJS,
      movies: movies.map(Favorite.fromMap).toList().toJS,
      music: music.map(Favorite.fromMap).toList().toJS,
      television: television.map(Favorite.fromMap).toList().toJS,
    );
  }  
  
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
