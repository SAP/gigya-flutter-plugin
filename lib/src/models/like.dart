/// This class represents a like.
class Like {
  /// The private constructor.
  Like._({
    this.category,
    this.id,
    this.name,
    // TODO: what is the meaning of this parameter? timestamp is enough here
    this.time,
    // TODO: this should either be an `int?` or a `DateTime?`, not a `double?`
    this.timestamp,
  });

  /// The default constructor.
  factory Like.fromJson(Map<String, dynamic> json) {
    return Like._(
      category: json['category'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      time: json['time'] as String?,
      timestamp: json['timestamp'] as double?,
    );
  }

  /// The category name of the like.
  final String? category;

  /// The id of the like.
  final String? id;

  /// The name of the like.
  final String? name;

  /// The formatted time of the like.
  final String? time;

  /// The timestamp of the like.
  final double? timestamp;

  /// Convert this object into a JSON object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'category': category,
      'id': id,
      'name': name,
      'time': time,
      'timestamp': timestamp,
    };
  }
}
