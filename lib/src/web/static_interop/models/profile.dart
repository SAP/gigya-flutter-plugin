import 'dart:js_interop';

import 'certification.dart';
import 'education.dart';
import 'favorites.dart';
import 'like.dart';
import 'patent.dart';
import 'phone.dart';
import 'publication.dart';
import 'skill.dart';
import 'work.dart';

/// The extension type for the `Profile` object.
@JS()
@anonymous
@staticInterop
extension type Profile._(JSObject _) {
  /// Construct a new [Profile] instance.
  external factory Profile({
    String? activities,
    String? address,
    int? age,
    String? bio,
    int? birthDay,
    int? birthMonth,
    int birthYear,
    JSArray certifications,
    String? city,
    String? country,
    JSArray education,
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
    JSArray likes,
    String? locale,
    String? name,
    String? nickname,
    JSArray patents,
    JSArray phones,
    String? photoUrl,
    String? politicalView,
    String? professionalHeadline,
    String? profileUrl,
    String? proxyEmail,
    JSArray publications,
    String? relationshipStatus,
    String? religion,
    JSArray skills,
    String? specialities,
    String? state,
    String? thumbnailUrl,
    String? timezone,
    String? username,
    String? verified,
    JSArray work,
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

  @JS('certifications')
  external JSArray? get _certifications;

  /// The person's certifications.
  List<Certification> get certifications {
    return _certifications?.toDart.cast<Certification>() ?? const <Certification>[];
  }

  /// The city in which the person resides.
  external String? get city;

  /// The country in which the person resides.
  external String? get country;

  @JS('education')
  external JSArray? get _education;

  /// The different educations of the person.
  List<Education> get education {
    return _education?.toDart.cast<Education>() ?? const <Education>[];
  }

  /// The education level of the person.
  external String? get educationLevel;

  /// The person's email address.
  external String? get email;

  /// The person's favorites.
  external Favorites? get favorites;

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

  /// Indicates whether the user is connected to any available provider.
  external bool? get isConnected;

  /// Indicates whether the user is a user of the site.
  external bool? get isSiteUser;

  /// The different languages that the person is proficient in.
  external String? get languages;

  /// The person's last name.
  external String? get lastName;

  @JS('likes')
  external JSArray? get _likes;

  /// The person's likes.
  List<Like> get likes => _likes?.toDart.cast<Like>() ?? const <Like>[];

  /// The language locale of the person's primary language.
  external String? get locale;

  /// The name of the provider that the user used in order to log in.
  /// If the user logged in using your site login mechanism, then `site` is used.
  external String? get loginProvider;

  /// The user's id from the given [loginProvider].
  external String? get loginProviderUID;

  /// The person's full name.
  external String? get name;

  /// The person's nickname.
  external String? get nickname;

  @JS('patents')
  external JSArray? get _patents;

  /// The different patents that this person owns.
  List<Patent> get patents {
    return _patents?.toDart.cast<Patent>() ?? const <Patent>[];
  }

  @JS('phones')
  external JSArray? get _phones;

  /// The different phone numbers belonging to this person.
  List<Phone> get phones => _phones?.toDart.cast<Phone>() ?? const <Phone>[];

  /// The url to the person's photo.
  external String? get photoURL;

  /// The person's political view.
  external String? get politicalView;

  /// The person's professional headline.
  external String? get professionalHeadline;

  /// The url to the person's profile page.
  external String? get profileURL;

  @JS('providers')
  external JSArray? get _providers;

  /// The names of the providers to which the user is connected/logged in.
  List<String> get providers {
    return _providers?.toDart.cast<String>() ?? const <String>[];
  }

  /// The person's proxy email address.
  external String? get proxyEmail;

  @JS('publications')
  external JSArray? get _publications;

  /// The list of publications belonging to this person.
  List<Publication> get publications {
    return _publications?.toDart.cast<Publication>() ?? const <Publication>[];
  }

  /// The person's relationship status.
  external String? get relationshipStatus;

  /// The person's religion.
  external String? get religion;

  @JS('skills')
  external JSArray? get _skills;

  /// The different skills of the person.
  List<Skill> get skills => _skills?.toDart.cast<Skill>() ?? const <Skill>[];

  /// The person's specialities.
  external String? get specialities;

  /// The state in which the person resides.
  external String? get state;

  /// The url to the person's thumbnail image.
  external String? get thumbnailURL;

  /// The person's timezone.
  external String? get timezone;

  /// The person's username.
  external String? get username;

  /// The verified status of the person.
  external String? get verified;

  @JS('work')
  external JSArray? get _work;

  /// The person's career, divided into the different employments.
  List<Work> get work => _work?.toDart.cast<Work>() ?? const <Work>[];

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
      'favorites': favorites?.toMap(),
      'firstName': firstName,
      'followersCount': followersCount,
      'followingCount': followingCount,
      'gender': gender,
      'hometown': hometown,
      'honors': honors,
      'industry': industry,
      'interests': interests,
      'isConnected': isConnected,
      'isSiteUser': isSiteUser,
      'languages': languages,
      'lastName': lastName,
      'likes': likes.map((Like l) => l.toMap()).toList(),
      'locale': locale,
      'loginProvider': loginProvider,
      'loginProviderUID': loginProviderUID,
      'name': name,
      'nickname': nickname,
      'patents': patents.map((Patent p) => p.toMap()).toList(),
      'phones': phones.map((Phone p) => p.toMap()).toList(),
      'photoURL': photoURL,
      'politicalView': politicalView,
      'professionalHeadline': professionalHeadline,
      'profileURL': profileURL,
      'providers': providers,
      'proxyEmail': proxyEmail,
      'publications': publications.map((Publication p) => p.toMap()).toList(),
      'relationshipStatus': relationshipStatus,
      'religion': religion,
      'skills': skills.map((Skill s) => s.toMap()).toList(),
      'specialities': specialities,
      'state': state,
      'thumbnailURL': thumbnailURL,
      'timezone': timezone,
      'username': username,
      'verified': verified,
      'work': work.map((Work w) => w.toMap()).toList(),
      'zip': zip,
    };
  }
}
