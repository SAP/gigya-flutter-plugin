import 'dart:js_interop';

/// The extension type for the `Skill` object.
@JS()
extension type Skill._(JSObject _) implements JSObject {
  /// The user's proficiency in the skill.
  external String? get level;

  /// The user's skill.
  external String? get skill;

  /// The amount of years the user is proficient in the given skill.
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
