import 'certification.dart';
import 'education.dart';
import 'favorite.dart';
import 'like.dart';
import 'location.dart';
import 'oidc_data.dart';
import 'patent.dart';
import 'phone.dart';
import 'publication.dart';
import 'skill.dart';
import 'work.dart';

/// This class represents an account profile.
class Profile {
  /// The private constructor.
  Profile._({
    this.activities,
    this.address,
    this.age,
    this.bio,
    this.birthDay,
    this.birthMonth,
    this.birthYear,
    this.certifications = const <Certification>[],
    this.city,
    this.country,
    this.education = const <Education>[],
    this.educationLevel,
    this.email,
    this.favorites = const <Favorite>[],
    this.firstName,
    this.followers,
    this.following,
    this.gender,
    this.hometown,
    this.honors,
    this.industry,
    this.interests,
    this.languages,
    this.lastLoginLocation,
    this.lastName,
    this.likes = const <Like>[],
    this.locale,
    this.name,
    this.nickname,
    this.oidcData,
    this.patents = const <Patent>[],
    this.phones = const <Phone>[],
    this.photoUrl,
    this.politicalView,
    this.professionalHeadline,
    this.profileUrl,
    this.proxyEmail,
    this.publications = const <Publication>[],
    this.relationshipStatus,
    this.religion,
    this.skills = const <Skill>[],
    this.specialities,
    this.state,
    this.thumbnailUrl,
    this.timezone,
    this.username,
    this.verified,
    this.work = const <Work>[],
    this.zip,
  });

  /// The default constructor.
  factory Profile.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? certs = json['certifications'] as List<dynamic>?;
    final List<dynamic>? education = json['education'] as List<dynamic>?;
    final List<dynamic>? favorites = json['favorites'] as List<dynamic>?;
    final Map<String, dynamic>? lastLoginLocation =
        json['lastLoginLocation'] as Map<String, dynamic>?;
    final List<dynamic>? likes = json['likes'] as List<dynamic>?;
    final Map<String, dynamic>? oidcStruct =
        json['oidcData'] as Map<String, dynamic>?;
    final List<dynamic>? patents = json['patents'] as List<dynamic>?;
    final List<dynamic>? phones = json['phones'] as List<dynamic>?;
    final List<dynamic>? publications = json['publications'] as List<dynamic>?;
    final List<dynamic>? skills = json['skills'] as List<dynamic>?;
    final List<dynamic>? work = json['work'] as List<dynamic>?;

    return Profile._(
      activities: json['activities'] as String?,
      address: json['address'] as String?,
      age: json['age'] as int?,
      bio: json['bio'] as String?,
      birthDay: json['birthDay'] as int?,
      birthMonth: json['birthMonth'] as int?,
      birthYear: json['birthYear'] as int?,
      certifications:
          _listFromJson<Certification>(certs, Certification.fromJson),
      city: json['city'] as String?,
      country: json['country'] as String?,
      education: _listFromJson<Education>(education, Education.fromJson),
      educationLevel: json['educationLevel'] as String?,
      email: json['email'] as String?,
      favorites: _listFromJson<Favorite>(favorites, Favorite.fromJson),
      firstName: json['firstName'] as String?,
      followers: json['followersCounts'] as int?,
      following: json['followingCount'] as int?,
      gender: json['gender'] as String?,
      hometown: json['hometown'] as String?,
      honors: json['honors'] as String?,
      industry: json['industry'] as String?,
      interests: json['interests'] as String?,
      languages: json['languages'] as String?,
      lastLoginLocation: lastLoginLocation == null
          ? null
          : Location.fromJson(lastLoginLocation),
      lastName: json['lastName'] as String?,
      likes: _listFromJson<Like>(likes, Like.fromJson),
      locale: json['locale'] as String?,
      name: json['name'] as String?,
      nickname: json['nickname'] as String?,
      oidcData: oidcStruct == null ? null : OidcData.fromJson(oidcStruct),
      patents: _listFromJson<Patent>(patents, Patent.fromJson),
      phones: _listFromJson<Phone>(phones, Phone.fromJson),
      photoUrl: json['photoURL'] as String?,
      politicalView: json['politicalView'] as String?,
      professionalHeadline: json['professionalHeadline'] as String?,
      profileUrl: json['profileURL'] as String?,
      proxyEmail: json['proxyEmail'] as String?,
      publications:
          _listFromJson<Publication>(publications, Publication.fromJson),
      relationshipStatus: json['relationshipStatus'] as String?,
      religion: json['religion'] as String?,
      skills: _listFromJson<Skill>(skills, Skill.fromJson),
      specialities: json['specialities'] as String?,
      state: json['state'] as String?,
      thumbnailUrl: json['thumbnailURL'] as String?,
      timezone: json['timezone'] as String?,
      username: json['username'] as String?,
      verified: json['verified'] as String?,
      work: _listFromJson<Work>(work, Work.fromJson),
      zip: json['zip'] as String?,
    );
  }

  /// The person's activities.
  final String? activities;

  /// The person's address.
  final String? address;

  /// The person's age.
  final int? age;

  /// The person's biography.
  final String? bio;

  /// The person's birth day.
  final int? birthDay;

  /// The person's birth month.
  final int? birthMonth;

  /// The person's birth year.
  final int? birthYear;

  /// The person's certifications.
  final List<Certification> certifications;

  /// The city in which the person resides.
  final String? city;

  /// The country in which the person resides.
  final String? country;

  /// The different educations of the person.
  final List<Education> education;

  /// The education level of the person.
  final String? educationLevel;

  /// The person's email address.
  final String? email;

  /// The person's favorites.
  final List<Favorite> favorites;

  /// The person's first name.
  final String? firstName;

  /// The amount of followers of this person.
  final int? followers;

  /// The amount of people that this person is following.
  final int? following;

  /// The person's gender.
  final String? gender;

  /// The person's home town.
  final String? hometown;

  /// The person's honorary titles.
  final String? honors;

  /// The industry in which this person is employed.
  final String? industry;

  /// The person's interests.
  final String? interests;

  /// The different languages that the person is proficient in.
  final String? languages;

  /// The last location where the user was logged in.
  final Location? lastLoginLocation;

  /// The person's last name.
  final String? lastName;

  /// The person's likes.
  final List<Like> likes;

  /// The language locale of the person's main language.
  final String? locale;

  /// The person's full name.
  final String? name;

  /// The person's nickname.
  final String? nickname;

  /// The OIDC data linked to this person.
  final OidcData? oidcData;

  /// The different patents that this person owns.
  final List<Patent> patents;

  /// The different phone numbers belonging to this person.
  final List<Phone> phones;

  /// The url to the person's photo.
  final String? photoUrl;

  /// The person's political view.
  final String? politicalView;

  /// The person's professional headline.
  final String? professionalHeadline;

  /// The url to the person's profile page.
  final String? profileUrl;

  /// The person's proxy email address,
  /// which is to be used when [email] is not directly available.
  final String? proxyEmail;

  /// The list of publications belonging to this person.
  final List<Publication> publications;

  /// The person's relationship status.
  final String? relationshipStatus;

  /// The person's religion.
  final String? religion;

  /// The different skills of the person.
  final List<Skill> skills;

  /// The person's specialities.
  final String? specialities;

  /// The state in which the person resides.
  final String? state;

  /// The url to the person's thumbnail image.
  final String? thumbnailUrl;

  /// The person's timezone.
  final String? timezone;

  /// The person's username.
  final String? username;

  /// The verified status of the person.
  final String? verified;

  /// The different careers of the person.
  final List<Work> work;

  /// The ZIP code of the person's address.
  final String? zip;

  static List<T> _listFromJson<T>(
    List<dynamic>? items,
    T Function(Map<String, dynamic> json) mapper,
  ) {
    if (items == null) {
      return <T>[];
    }

    return items.map((dynamic item) {
      return mapper(item as Map<String, dynamic>);
    }).toList();
  }

  /// Convert this object into a JSON object.
  Map<String, dynamic> toJson() {
    final Location? lastLogin = lastLoginLocation;
    final OidcData? oidcStruct = oidcData;

    return <String, dynamic>{
      'activities': activities,
      'address': address,
      'age': age,
      'bio': bio,
      'birthDay': birthDay,
      'birthMonth': birthMonth,
      'birthYear': birthYear,
      if (certifications.isNotEmpty)
        'certifications':
            certifications.map((Certification c) => c.toJson()).toList(),
      'city': city,
      'country': country,
      if (education.isNotEmpty)
        'education': education.map((Education e) => e.toJson()).toList(),
      'educationLevel': educationLevel,
      'email': email,
      if (favorites.isNotEmpty)
        'favorites': favorites.map((Favorite f) => f.toJson()).toList(),
      'firstName': firstName,
      'followersCounts': followers,
      'followingCount': following,
      'gender': gender,
      'hometown': hometown,
      'honors': honors,
      'industry': industry,
      'interests': interests,
      'languages': languages,
      if (lastLogin != null) 'lastLoginLocation': lastLogin.toJson(),
      'lastName': lastName,
      if (likes.isNotEmpty) 'likes': likes.map((Like l) => l.toJson()).toList(),
      'locale': locale,
      'name': name,
      'nickname': nickname,
      if (oidcStruct != null) 'oidcData': oidcStruct.toJson(),
      if (patents.isNotEmpty)
        'patents': patents.map((Patent p) => p.toJson()).toList(),
      if (phones.isNotEmpty)
        'phones': phones.map((Phone p) => p.toJson()).toList(),
      'photoURL': photoUrl,
      'politicalView': politicalView,
      'professionalHeadline': professionalHeadline,
      'profileURL': profileUrl,
      'proxyEmail': proxyEmail,
      if (publications.isNotEmpty)
        'publications':
            publications.map((Publication p) => p.toJson()).toList(),
      'relationshipStatus': relationshipStatus,
      'religion': religion,
      if (skills.isNotEmpty)
        'skills': skills.map((Skill s) => s.toJson()).toList(),
      'specialities': specialities,
      'state': state,
      'thumbnailURL': thumbnailUrl,
      'timezone': timezone,
      'username': username,
      'verified': verified,
      if (work.isNotEmpty) 'work': work.map((Work w) => w.toJson()).toList(),
      'zip': zip,
    };
  }
}
