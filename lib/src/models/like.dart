/// This class represents a like.
class Like {
  /// The private constructor.
  Like._({
    this.category,
    this.id,
    this.name,
    this.time,
  });

  /// The default constructor.
  factory Like.fromJson(Map<String, dynamic> json) {
    return Like._(
      category: json['category'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      time: DateTime.tryParse(json['time'] as String? ?? ''),
    );
  }

  /// The category name of the like.
  final String? category;

  /// The id of the like.
  final String? id;

  /// The name of the like.
  final String? name;

  /// The timestamp of the like.
  final DateTime? time;

  /// Convert this object into a JSON object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'category': category,
      'id': id,
      'name': name,
      'time': time?.toIso8601String(),
    };
  }
}
