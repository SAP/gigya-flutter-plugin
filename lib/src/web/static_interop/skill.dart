import 'package:js/js.dart';

/// The static interop class for the `Skill` object.
@JS()
@anonymous
class Skill {
  /// Construct a new [Skill] instance.
  external factory Skill({String? level, String? skill, int? years});

  /// The user's proficiency in the skill.
  external String? get level;

  /// The user's skill.
  external String? get skill;

  /// The years of the user's skill.
  external int? get years;

  /// Convert the given [skill] to a [Map].
  ///
  /// Since the [Skill] class is an anonymous JavaScript type,
  /// this has to be a static method instead of an instance method.
  static Map<String, dynamic> toMap(Skill skill) {
    return <String, dynamic>{
      'level': skill.level,
      'skill': skill.skill,
      'years': skill.years,
    };
  }
}
