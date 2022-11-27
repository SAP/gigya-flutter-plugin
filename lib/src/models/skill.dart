/// This class represents a skill of an individual.
class Skill {
  /// The private constructor.
  Skill._({
    this.level,
    this.skill,
    this.years,
  });

  /// The default constructor.
  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill._(
      level: json['level'] as String?,
      skill: json['skill'] as String?,
      years: json['years'] as int?,
    );
  }

  /// The proficiency in the given skill.
  final String? level;

  /// The name of the skill.
  final String? skill;

  /// The years of experience in the given skill.
  final int? years;

  /// Convert this object into a JSON object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'level': level,
      'skill': skill,
      'years': years,
    };
  }
}
