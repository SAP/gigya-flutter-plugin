import 'dart:convert';

/// This class represents a single favorite.
class Favorite {
  /// The private constructor.
  Favorite._({
    this.category,
    this.id,
    this.name,
  });

  /// The default constructor.
  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite._(
      category: json['category'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
    );
  }

  /// The id of the favorite.
  final String? id;

  /// The name of the favorite.
  final String? name;

  /// The category of the favorite.
  final String? category;

  /// Convert this object into a JSON object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'category': category,
    };
  }
}

/// This class represents a collection of [Favorites] for an indivudual.
class Favorites {
  /// The private constructor.
  Favorites._({
    this.activities = const <Favorite>[],
    this.books = const <Favorite>[],
    this.interests = const <Favorite>[],
    this.movies = const <Favorite>[],
    this.music = const <Favorite>[],
    this.television = const <Favorite>[],
  });

  /// The default constructor.
  factory Favorites.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? activities = json['activities'] as List<dynamic>?;
    final List<dynamic>? books = json['books'] as List<dynamic>?;
    final List<dynamic>? interests = json['interests'] as List<dynamic>?;
    final List<dynamic>? movies = json['movies'] as List<dynamic>?;
    final List<dynamic>? music = json['music'] as List<dynamic>?;
    final List<dynamic>? television = json['television'] as List<dynamic>?;

    return Favorites._(
      activities: _favoritesFromList(activities?.cast<String>()),
      books: _favoritesFromList(books?.cast<String>()),
      interests: _favoritesFromList(interests?.cast<String>()),
      movies: _favoritesFromList(movies?.cast<String>()),
      music: _favoritesFromList(music?.cast<String>()),
      television: _favoritesFromList(television?.cast<String>()),
    );
  }

  /// The favorite activities of the individual.
  final List<Favorite> activities;

  /// The favorite books of the individual.
  final List<Favorite> books;

  /// The interests of the individual.
  final List<Favorite> interests;

  /// The favorite movies of the individual.
  final List<Favorite> movies;

  /// The favorite music of the individual.
  final List<Favorite> music;

  /// The favorite television shows of the individual.
  final List<Favorite> television;

  static List<Favorite> _favoritesFromList(List<String>? items) {
    if (items == null) {
      return <Favorite>[];
    }

    return items.map((String item) {
      return Favorite.fromJson(jsonDecode(item) as Map<String, dynamic>);
    }).toList();
  }

  /// Convert this object into a JSON object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'activities': activities.map((Favorite a) => a.toJson()).toList(),
      'books': books.map((Favorite b) => b.toJson()).toList(),
      'interests': interests.map((Favorite i) => i.toJson()).toList(),
      'movies': movies.map((Favorite m) => m.toJson()).toList(),
      'television': television.map((Favorite t) => t.toJson()).toList(),
    };
  }
}
