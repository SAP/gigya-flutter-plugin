import 'package:js/js.dart';

/// The static interop class for the `Skill` object.
@JS()
@anonymous
@staticInterop
class Skill {}

/// This extension defines the static interop definition
/// for the [Skill] class.
extension SkillExtension on Skill {
  /// The user's proficiency in the skill.
  external String? get level;

  /// The user's skill.
  external String? get skill;

  /// The years of the user's skill.
  external int? get years;

  /// Convert this skill to a [Map].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'level': level,
      'skill': skill,
      'years': years,
    };
  }
}
