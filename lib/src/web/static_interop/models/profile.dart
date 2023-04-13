import 'package:js/js.dart';

import 'certification.dart';
import 'education.dart';
import 'favorites.dart';
import 'like.dart';
import 'patent.dart';
import 'phone.dart';
import 'publication.dart';
import 'skill.dart';
import 'work.dart';

/// This class represents the static interop implementation
/// for the profile object.
@JS()
@anonymous
@staticInterop
class Profile {}

/// This extension defines the static interop definition
/// for the [Profile] class.
extension ProfileExtension on Profile {
  /// The person's activities.
  external String? get activities;

  /// The person's address.
  external String? get address;

  /// The person's age.
  external int? get age;

  /// The person's biography.
  external String? get bio;

  /// The person's birth day.
  external int? get birthDay;

  /// The person's birth month.
  external int? get birthMonth;

  /// The person's birth year.
  external int? get birthYear;

  @JS('certifications')
  external List<dynamic> get _certifications;

  /// The person's certifications.
  List<Certification> get certifications => _certifications.cast<Certification>();

  /// The city in which the person resides.
  external String? get city;

  /// The country in which the person resides.
  external String? get country;

  @JS('education')
  external List<dynamic> get _education;

  /// The different educations of the person.
  List<Education> get education => _education.cast<Education>();

  /// The education level of the person.
  external String? get educationLevel;

  /// The person's email address.
  external String? get email;

  /// The person's favorites.
  external Favorites get favorites;

  /// The person's first name.
  external String? get firstName;

  /// The amount of followers of this person.
  external int? get followersCount;

  /// The amount of people that this person is following.
  external int? get followingCount;

  /// The person's gender.
  external String? get gender;

  /// The person's home town.
  external String? get hometown;

  /// The person's honorary titles.
  external String? get honors;

  /// The industry in which this person is employed.
  external String? get industry;

  /// The person's interests.
  external String? get interests;

  /// The different languages that the person is proficient in.
  external String? get languages;

  /// The person's last name.
  external String? get lastName;

  @JS('likes')
  external List<dynamic> get _likes;

  /// The person's likes.
  List<Like> get likes => _likes.cast<Like>();

  /// The language locale of the person's primary language.
  external String? get locale;

  /// The person's full name.
  external String? get name;

  /// The person's nickname.
  external String? get nickname;

  @JS('patents')
  external List<dynamic> get _patents;

  /// The different patents that this person owns.
  List<Patent> get patents => _patents.cast<Patent>();

  @JS('phones')
  external List<dynamic> get _phones;

  /// The different phone numbers belonging to this person.
  List<Phone> get phones => _phones.cast<Phone>();

  /// The url to the person's photo.
  external String? get photoURL;

  /// The person's political view.
  external String? get politicalView;

  /// The person's professional headline.
  external String? get professionalHeadline;

  /// The url to the person's profile page.
  external String? get profileUrl;

  /// The person's proxy email address.
  external String? get proxyEmail;

  @JS('publications')
  external List<dynamic> get _publications;

  /// The list of publications belonging to this person.
  List<Publication> get publications => _publications.cast<Publication>();

  /// The person's relationship status.
  external String? get relationshipStatus;

  /// The person's religion.
  external String? get religion;

  @JS('skills')
  external List<dynamic> get _skills;

  /// The different skills of the person.
  List<Skill> get skills => _skills.cast<Skill>();

  /// The person's specialities.
  external String? get specialities;

  /// The state in which the person resides.
  external String? get state;

  /// The url to the person's thumbnail image.
  external String? get thumbnailUrl;

  /// The person's timezone.
  external String? get timezone;

  /// The person's username.
  external String? get username;

  /// The verified status of the person.
  external String? get verified;

  @JS('work')
  external List<dynamic> get _work;

  /// The person's career, divided into the different employments.
  List<Work> get work => _work.cast<Work>();

  /// The ZIP code of the person's address.
  external String? get zip;

  /// Convert this profile into a [Map].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'activities': activities,
      'address': address,
      'age': age,
      'bio': bio,
      'birthDay': birthDay,
      'birthMonth': birthMonth,
      'birthYear': birthYear,
      'certifications': certifications.map((Certification c) => c.toMap()).toList(),
      'city': city,
      'country': country,
      'education': education.map((Education e) => e.toMap()).toList(),
      'educationLevel': educationLevel,
      'email': email,
      'favorites': favorites.toMap(),
      'firstName': firstName,
      'followersCount': followersCount,
      'followingCount': followingCount,
      'gender': gender,
      'hometown': hometown,
      'honors': honors,
      'industry': industry,
      'interests': interests,
      'languages': languages,
      'lastName': lastName,
      'likes': likes.map((Like l) => l.toMap()).toList(),
      'locale': locale,
      'name': name,
      'nickname': nickname,
      'patents': patents.map((Patent p) => p.toMap()).toList(),
      'phones': phones.map((Phone p) => p.toMap()).toList(),
      'photoURL': photoURL,
      'politicalView': politicalView,
      'professionalHeadline': professionalHeadline,
      'proxyEmail': proxyEmail,
      'publications': publications.map((Publication p) => p.toMap()).toList(),
      'relationshipStatus': relationshipStatus,
      'religion': religion,
      'skills': skills.map((Skill s) => s.toMap()).toList(),
      'specialities': specialities,
      'state': state,
      'thumbnailURL': thumbnailUrl,
      'timezone': timezone,
      'username': username,
      'verified': verified,
      'work': work.map((Work w) => w.toMap()).toList(),
      'zip': zip,
    };
  }
}
