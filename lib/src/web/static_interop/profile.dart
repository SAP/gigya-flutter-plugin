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
class Profile {
  /// Construct a new [Profile] instance.
  external factory Profile({
    String? activities,
    String? address,
    int? age,
    String? bio,
    int? birthDay,
    int? birthMonth,
    int birthYear,
    List<Certification> certifications,
    String? city,
    String? country,
    List<Education> education,
    String? educationLevel,
    String? email,
    Favorites favorites,
    String? firstName,
    int? followers,
    int? following,
    String? gender,
    String? hometown,
    String? honors,
    String? industry,
    String? interests,
    String? languages,
    String? lastName,
    List<Like> likes,
    String? locale,
    String? name,
    String? nickname,
    List<Patent> patents,
    List<Phone> phones,
    String? photoUrl,
    String? politicalView,
    String? professionalHeadline,
    String? profileUrl,
    String? proxyEmail,
    List<Publication> publications,
    String? relationshipStatus,
    String? religion,
    List<Skill> skills,
    String? specialities,
    String? state,
    String? thumbnailUrl,
    String? timezone,
    String? username,
    String? verified,
    List<Work> work,
    String? zip,
  });

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

  /// The person's certifications.
  external List<Certification> get certifications;

  /// The city in which the person resides.
  external String? get city;

  /// The country in which the person resides.
  external String? get country;

  /// The different educations of the person.
  external List<Education> get education;

  /// The education level of the person.
  external String? get educationLevel;

  /// The person's email address.
  external String? get email;

  /// The person's favorites.
  external Favorites get favorites;

  /// The person's first name.
  external String? get firstName;

  /// The amount of followers of this person.
  external int? get followers;

  /// The amount of people that this person is following.
  external int? get following;

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

  /// The person's likes.
  external List<Like> get likes;

  /// The language locale of the person's primary language.
  external String? get locale;

  /// The person's full name.
  external String? get name;

  /// The person's nickname.
  external String? get nickname;

  /// The different patents that this person owns.
  external List<Patent> get patents;

  /// The different phone numbers belonging to this person.
  external List<Phone> get phones;

  /// The url to the person's photo.
  external String? get photoUrl;

  /// The person's political view.
  external String? get politicalView;

  /// The person's professional headline.
  external String? get professionalHeadline;

  /// The url to the person's profile page.
  external String? get profileUrl;

  /// The person's proxy email address.
  external String? get proxyEmail;

  /// The list of publications belonging to this person.
  external List<Publication> get publications;

  /// The person's relationship status.
  external String? get relationshipStatus;

  /// The person's religion.
  external String? get religion;

  /// The different skills of the person.
  external List<Skill> get skills;

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

  /// The person's career, divided into the different employments.
  external List<Work> get work;

  /// The ZIP code of the person's address.
  external String? get zip;

  /// Convert the given [profile] to a [Map].
  ///
  /// Since the [Profile] class is an anonymous JavaScript type,
  /// this has to be a static method instead of an instance method.
  static Map<String, dynamic> toMap(Profile profile) {
    final List<Map<String, dynamic>> certs = profile.certifications.map((Certification c) => c.toMap()).toList();
    final List<Map<String, dynamic>> education = profile.education.map((Education e) => e.toMap()).toList();
    final List<Map<String, dynamic>> likes = profile.likes.map((Like l) => l.toMap()).toList();
    final List<Map<String, dynamic>> patents = profile.patents.map((Patent p) => p.toMap()).toList();
    final List<Map<String, dynamic>> phones = profile.phones.map((Phone p) => p.toMap()).toList();
    final List<Map<String, dynamic>> publications = profile.publications.map((Publication p) => p.toMap()).toList();
    final List<Map<String, dynamic>> skills = profile.skills.map((Skill s) => s.toMap()).toList();
    final List<Map<String, dynamic>> work = profile.work.map(Work.toMap).toList();

    return <String, dynamic>{
      'activities': profile.activities,
      'address': profile.address,
      'age': profile.age,
      'bio': profile.bio,
      'birthDay': profile.birthDay,
      'birthMonth': profile.birthMonth,
      'birthYear': profile.birthYear,
      'certifications': certs,
      'city': profile.city,
      'country': profile.country,
      'education': education,
      'educationLevel': profile.educationLevel,
      'email': profile.email,
      'favorites': profile.favorites.toMap(),
      'firstName': profile.firstName,
      'followersCount': profile.followers,
      'followingCount': profile.following,
      'gender': profile.gender,
      'hometown': profile.hometown,
      'honors': profile.honors,
      'industry': profile.industry,
      'interests': profile.interests,
      'languages': profile.languages,
      'lastName': profile.lastName,
      'likes': likes,
      'locale': profile.locale,
      'name': profile.name,
      'nickname': profile.nickname,
      'patents': patents,
      'phones': phones,
      'photoURL': profile.photoUrl,
      'politicalView': profile.politicalView,
      'professionalHeadline': profile.professionalHeadline,
      'proxyEmail': profile.proxyEmail,
      'publications': publications,
      'relationshipStatus': profile.relationshipStatus,
      'religion': profile.religion,
      'skills': skills,
      'specialities': profile.specialities,
      'state': profile.state,
      'thumbnailURL': profile.thumbnailUrl,
      'timezone': profile.timezone,
      'username': profile.username,
      'verified': profile.verified,
      'work': work,
      'zip': profile.zip,
    };
  }
}
