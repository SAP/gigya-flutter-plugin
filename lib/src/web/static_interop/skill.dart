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
}
