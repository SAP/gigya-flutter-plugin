import 'dart:io';

/// Available interruptions.
enum Interruption {
  pendingRegistration,
  pendingVerification,
  conflictingAccounts,
}

/// General response structure.
class GigyaResponse {
  String? callId;
  int? statusCode = 200;
  int? errorCode = 0;
  String? errorDetails;
  String? statusReason;
  int? apiVersion;
  String? regToken;
  dynamic mapped;

  Interruption? getInterruption() {
    switch (errorCode) {
      case 403043:
        return Interruption.conflictingAccounts;
      case 206001:
        return Interruption.pendingRegistration;
      case 206002:
        return Interruption.pendingVerification;
      default:
        return null;
    }
  }

  GigyaResponse.fromJson(dynamic json)
      : callId = json['callId']?.toString(),
        statusCode = json['statusCode'],
        errorCode = json['errorCode'],
        errorDetails = json['errorDetails'] != null
            ? json['errorDetails']
            : json['localizedMessage'] != null
                ? json['localizedMessage']
                : null,
        statusReason = json['statusReason'],
        apiVersion = json['apiVersion'],
        regToken = json['regToken'],
        mapped = json;

  Map<String, dynamic> toJson() => {
        'callID': callId,
        'statusCode': statusCode,
        'errorCode': errorCode,
        'errorDetails': errorDetails,
        'statusReason': statusReason,
        'apiVersion': apiVersion,
        'regToken': regToken,
        'mapped': mapped,
      };
}

/// Account schema object.
class Account extends GigyaResponse {
  String? uid;
  String? uidSignature;
  String? created;
  dynamic createdTimestamp;
  late Emails emails;
  bool? isActive;
  bool? isRegistered;
  bool? isVerified;
  String? lastLogin;
  dynamic lastLoginTimestamp;
  String? lastUpdated;
  dynamic lastUpdatedTimestamp;
  String? loginProvider;
  String? oldestDataUpdated;
  dynamic oldestDataUpdatedTimestamp;
  Profile? profile;
  String? registered;
  dynamic registeredTimestamp;
  SessionInfo? sessionInfo;
  dynamic signatureTimestamp;
  String? socialProviders;
  String? verified;
  dynamic verifiedTimestamp;

  Account.fromJson(dynamic json) : super.fromJson(json) {
    uid = json['UID'];
    uidSignature = json['UIDSignature'];
    created = json['created'];
    createdTimestamp = json['createdTimestamp'];
    if (json['emails'] != null) {
      emails = Emails.fromJson(json['emails'].cast<String, dynamic>());
    }
    isActive = json['isActive'];
    isRegistered = json['isRegistered'];
    isVerified = json['isVerified'];
    lastLogin = json['lastLogin'];
    lastLoginTimestamp = json['lastLoginTimestamp'];
    lastUpdated = json['lastUpdated'];
    lastUpdatedTimestamp = json['lastUpdatedTimestamp'];
    loginProvider = json['loginProvider'];
    oldestDataUpdated = json['oldestDataUpdated'];
    oldestDataUpdatedTimestamp = json['oldestDataUpdatedTimestamp'];
    if (json['profile'] != null) {
      profile = Profile.fromJson(json['profile'].cast<String, dynamic>());
    }
    registered = json['registered'];
    registeredTimestamp = json['registeredTimestamp'];
    if (json['sessionInfo'] != null) {
      sessionInfo =
          SessionInfo.fromJson(json['sessionInfo'].cast<String, dynamic>());
    }
    signatureTimestamp = json['signatureTimestamp'];
    socialProviders = json['socialProviders'];
    verified = json['verified'];
    verifiedTimestamp = json['verifiedTimestamp'];
  }

  Map<String, dynamic> toJson() => {
        'UID': this.uid,
        'UIDSignature': this.uidSignature,
        'created': this.created,
        'createdTimestamp': this.createdTimestamp,
        'emails': this.emails.toJson(),
        'isActive': this.isActive,
        'isRegistered': this.isRegistered,
        'isVerified': this.isVerified,
        'lastLogin': this.lastLogin,
        'lastLoginTimestamp': this.lastLoginTimestamp,
        'lastUpdated': this.lastUpdated,
        'loginProvider': this.loginProvider,
        'oldestDataUpdated': this.oldestDataUpdated,
        'lastUpdatedTimestamp': this.lastUpdatedTimestamp,
        'oldestDataUpdatedTimestamp': this.oldestDataUpdatedTimestamp,
        if (this.profile != null) 'profile': this.profile!.toJson(),
        'registered': this.registered,
        'registeredTimestamp': this.registeredTimestamp,
        if (this.sessionInfo != null) 'sessionInfo': this.sessionInfo!.toJson(),
        'signatureTimestamp': this.signatureTimestamp,
        'socialProviders': this.socialProviders,
        'verified': this.verified,
        'verifiedTimestamp': this.verifiedTimestamp,
      };
}

class SessionInfo {
  String? sessionToken;
  String? sessionSecret;
  dynamic expiresIn;

  SessionInfo.fromJson(Map<String, dynamic> json) {
    sessionToken = json['sessionToken'];
    sessionSecret = json['sessionSecret'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() => {
        'sessionToken': this.sessionToken,
        'sessionSecret': this.sessionSecret,
        'expires_in': this.expirationTime,
      };

  double get expirationTime =>
      Platform.isIOS ? double.parse(expiresIn) : expiresIn;
}

/// Account profile schema object.
class Profile {
  String? activities;
  String? address;
  int? age;
  String? bio;
  int? birthDay;
  int? birthMonth;
  int? birthYear;
  late List<Certification> certifications;
  String? city;
  String? country;
  late List<Education> education;
  String? educationLevel;
  String? email;
  late List<Favorites> favorites;
  String? firstName;
  String? lastName;
  double? followersCounts;
  double? followingCount;
  String? gender;
  String? hometown;
  String? honors;
  String? industry;
  String? interestedIn;
  String? interests;
  String? languages;
  Location? lastLoginLocation;
  late List<Like> likes;
  String? locale;
  String? name;
  String? nickname;
  OidcData? oidcData;
  late List<Patent> patents;
  late List<Phone> phones;
  String? photoURL;
  String? thumbnailURL;
  String? profileURL;
  String? politicalView;
  String? professionalHeadline;
  String? proxyEmail;
  late List<Publication> publications;
  String? relationshipStatus;
  String? religion;
  late List<Skill> skills;
  String? specialities;
  String? state;
  String? timezone;
  String? username;
  String? verified;
  late List<Work> work;
  String? zip;

  Profile.fromJson(Map<String, dynamic> json) {
    activities = json['activities'];
    address = json['address'];
    age = json['age'];
    bio = json['bio'];
    birthDay = json['birthDay'];
    birthMonth = json['birthMonth'];
    birthYear = json['birthYear'];
    certifications = [];
    if (json['certifications'] != null) {
      json['certifications'].forEach((j) {
        certifications.add(Certification.fromJson(j));
      });
    }
    education = [];
    if (json['education'] != null) {
      json['education'].forEach((j) {
        education.add(Education.fromJson(j));
      });
    }
    educationLevel = json['educationLevel'];
    city = json['city'];
    country = json['country'];
    email = json['email'];
    favorites = [];
    if (json['favorites'] != null) {
      json['favorites'].forEach((j) {
        favorites.add(Favorites.fromJson(j));
      });
    }
    firstName = json['firstName'];
    lastName = json['lastName'];
    followersCounts = json['followersCounts'];
    followingCount = json['followingCount'];
    gender = json['gender'];
    hometown = json['hometown'];
    honors = json['honors'];
    industry = json['industry'];
    interestedIn = json['interestedIn'];
    interests = json['interests'];
    languages = json['languages'];
    if (json['lastLoginLocation'] != null) {
      lastLoginLocation = Location.fromJson(json['lastLoginLocation']);
    }
    likes = [];
    if (json['likes'] != null) {
      json['likes'].forEach((j) {
        likes.add(Like.fromJson(j));
      });
    }
    locale = json['locale'];
    name = json['name'];
    nickname = json['nickname'];
    if (json['oidcData'] != null) {
      oidcData = OidcData.fromJson(json['oidcData'].cast<String, dynamic>());
    }
    patents = [];
    if (json['patents'] != null) {
      json['patents'].forEach((j) {
        patents.add(Patent.fromJson(j));
      });
    }
    phones = [];
    if (json['phones'] != null) {
      json['phones'].forEach((j) {
        phones.add(Phone.fromJson(j));
      });
    }
    photoURL = json['photoURL'];
    thumbnailURL = json['thumbnailURL'];
    profileURL = json['profileURL'];
    politicalView = json['politicalView'];
    professionalHeadline = json['professionalHeadline'];
    proxyEmail = json['proxyEmail'];
    publications = [];
    if (json['publications'] != null) {
      json['publications'].forEach((j) {
        publications.add(Publication.fromJson(j));
      });
    }
    relationshipStatus = json['relationshipStatus'];
    religion = json['religion'];
    skills = [];
    if (json['skills'] != null) {
      json['skills'].forEach((j) {
        skills.add(Skill.fromJson(j));
      });
    }
    specialities = json['specialities'];
    state = json['state'];
    timezone = json['timezone'];
    username = json['username'];
    verified = json['verified'];
    work = [];
    if (json['work'] != null) {
      json['work'].forEach((j) {
        work.add(Work.fromJson(j));
      });
    }
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() => {
        'activities': this.activities,
        'address': this.address,
        'age': this.age,
        'bio': this.bio,
        'birthDay': this.birthDay,
        'birthMonth': this.birthMonth,
        'birthYear': this.birthYear,
        if (this.certifications.isNotEmpty)
          'configurations': this.certifications.map((j) => j.toJson()).toList(),
        if (this.education.isNotEmpty)
          'education': this.education.map((j) => j.toJson()).toList(),
        'educationLevel': this.educationLevel,
        'city': this.city,
        'country': this.country,
        'email': this.email,
        if (this.favorites.isNotEmpty)
          'favorites': this.favorites.map((j) => j.toJson()).toList(),
        'firstName': this.firstName,
        'lastName': this.lastName,
        'followersCounts': this.followersCounts,
        'followingCount': this.followingCount,
        'gender': this.gender,
        'hometown': this.hometown,
        'honors': this.honors,
        'industry': this.industry,
        'interestedIn': this.interestedIn,
        'interests': this.interests,
        'languages': this.languages,
        if (this.lastLoginLocation != null)
          'lastLoginLocation': this.lastLoginLocation!.toJson(),
        if (this.likes.isNotEmpty)
          'likes': this.likes.map((j) => j.toJson()).toList(),
        'locale': this.locale,
        'name': this.name,
        'nickname': this.nickname,
        if (this.oidcData != null) 'oidcData': this.oidcData!.toJson(),
        if (this.patents.isNotEmpty)
          'patents': this.patents.map((j) => j.toJson()).toList(),
        if (this.phones.isNotEmpty)
          'phones': this.phones.map((j) => j.toJson()).toList(),
        'photoURL': this.photoURL,
        'thumbnailURL': this.thumbnailURL,
        'profileURL': this.profileURL,
        'politicalView': this.politicalView,
        'professionalHeadline': this.professionalHeadline,
        'proxyEmail': this.proxyEmail,
        if (this.publications.isNotEmpty)
          'publications': this.publications.map((j) => j.toJson()).toList(),
        'relationshipStatus': this.relationshipStatus,
        'religion': this.religion,
        if (this.skills.isNotEmpty)
          'skills': this.skills.map((j) => j.toJson()).toList(),
        'specialities': this.specialities,
        'state': this.state,
        'timezone': this.timezone,
        'username': this.username,
        'verified': this.verified,
        if (this.work.isNotEmpty)
          'work': this.work.map((j) => j.toJson()).toList(),
        'zip': this.zip,
      };
}

class Emails {
  List<String> unverified = [];
  List<String> verified = [];

  Emails.fromJson(Map<String, dynamic> json) {
    if (json['unverified'] != null) {
      unverified = json['unverified'].cast<String>();
    }
    if (json['verified'] != null) {
      verified = json['verified'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() => {
        'unverified': this.unverified,
        'verified': this.verified,
      };
}

class Certification {
  String? authority;
  String? endDate;
  String? name;
  String? number;
  String? startDate;

  Certification.fromJson(Map<String, dynamic> json) {
    authority = json['authority'];
    endDate = json['endDate'];
    name = json['name'];
    number = json['number'];
    startDate = json['startDate'];
  }

  Map<String, dynamic> toJson() => {
        'authority': this.authority,
        'endDate': this.endDate,
        'name': this.name,
        'number': this.number,
        'startDate': this.startDate,
      };
}

class Education {
  String? degree;
  String? endYear;
  String? fieldOfStudy;
  String? school;
  String? schoolType;
  String? startYear;

  Education.fromJson(Map<String, dynamic> json) {
    degree = json['degree'];
    endYear = json['endYear'];
    fieldOfStudy = json['fieldOfStudy'];
    school = json['school'];
    schoolType = json['schoolType'];
    startYear = json['startYear'];
  }

  Map<String, dynamic> toJson() => {
        'degree': this.degree,
        'endYear': this.endYear,
        'fieldOfStudy': this.fieldOfStudy,
        'school': this.school,
        'schoolType': this.schoolType,
        'startYear': this.startYear,
      };
}

class Favorites {
  late List<Favorite> activities = [];
  late List<Favorite> books = [];
  late List<Favorite> interests = [];
  late List<Favorite> movies = [];
  late List<Favorite> music = [];
  late List<Favorite> television = [];

  Favorites.fromJson(Map<String, dynamic> json) {
    if (json['activities'] != null) {
      activities = json['activities'].cast<String>();
    }
    if (json['books'] != null) {
      books = json['books'].cast<String>();
    }
    if (json['interests'] != null) {
      interests = json['interests'].cast<String>();
    }
    if (json['movies'] != null) {
      movies = json['movies'].cast<String>();
    }
    if (json['television'] != null) {
      television = json['television'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() => {
        'activities': this.activities,
        'books': this.books,
        'interests': this.interests,
        'movies': this.movies,
        'television': this.television,
      };
}

class Favorite {
  String? id;
  String? name;
  String? category;

  Favorite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'name': this.name,
        'category': this.category,
      };
}

class Location {
  String? city;
  String? country;
  String? state;
  Coordinates? coordinates;

  Location.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    country = json['country'];
    state = json['state'];
    if (json['coordinates'] != null) {
      coordinates =
          Coordinates.fromJson(json['coordinates'].cast<String, dynamic>());
    }
  }

  Map<String, dynamic> toJson() => {
        'city': this.city,
        'country': this.country,
        'state': this.state,
        if (this.coordinates != null) 'coordinates': this.coordinates!.toJson(),
      };
}

class Coordinates {
  double? lat;
  double? lon;

  Coordinates.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() => {
        'lat': this.lat,
        'lon': this.lon,
      };
}

class Like {
  String? category;
  String? id;
  String? name;
  String? time;
  double? timestamp;

  Like.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    id = json['id'];
    name = json['name'];
    time = json['time'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() => {
        'category': this.category,
        'id': this.id,
        'name': this.name,
        'time': this.time,
        'timestamp': this.timestamp,
      };
}

class OidcData {
  Address? address;
  String? emailVerified;
  String? locale;
  String? middleName;
  String? name;
  String? phoneNumber;
  String? phoneNumberVerified;
  String? updatedAt;
  String? website;
  String? zoneinfo;

  OidcData.fromJson(Map<String, dynamic> json) {
    if (json['address'] != null) {
      address = Address.fromJson(json['address'].cast<String, dynamic>());
    }
    emailVerified = json['email_verified'];
    locale = json['locale'];
    middleName = json['middle_name'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    phoneNumberVerified = json['phone_number_verified'];
    updatedAt = json['updated_at'];
    website = json['website'];
    zoneinfo = json['zoneinfo'];
  }

  Map<String, dynamic> toJson() => {
        if (this.address != null) 'address': this.address!.toJson(),
        'email_verified': this.emailVerified,
        'locale': this.locale,
        'middle_name': this.middleName,
        'name': this.name,
        'phone_number': this.phoneNumber,
        'phone_number_verified': this.phoneNumberVerified,
        'updated_at': this.updatedAt,
        'website': this.website,
        'zoneinfo': this.zoneinfo,
      };
}

class Address {
  String? country;
  String? formatted;
  String? locality;
  String? postalCode;
  String? region;
  String? streetAddress;

  Address.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    formatted = json['formatted'];
    locality = json['locality'];
    postalCode = json['postal_code'];
    region = json['region'];
    streetAddress = json['street_address'];
  }

  Map<String, dynamic> toJson() => {
        'country': this.country,
        'formatted': this.formatted,
        'locality': this.locality,
        'postal_code': this.postalCode,
        'region': this.region,
        'street_address': this.streetAddress,
      };
}

class Patent {
  String? date;
  String? number;
  String? office;
  String? status;
  String? summary;
  String? title;
  String? url;

  Patent.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    number = json['number'];
    office = json['office'];
    status = json['status'];
    summary = json['summary'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() => {
        'date': this.date,
        'number': this.number,
        'office': this.office,
        'status': this.status,
        'summary': this.summary,
        'title': this.title,
        'url': this.url,
      };
}

class Phone {
  String? _default;
  String? number;
  String? type;

  String? get defaultNumber => this._default;

  Phone.fromJson(Map<String, dynamic> json) {
    _default = json['default'];
    number = json['number'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() => {
        'default': this._default,
        'number': this.number,
        'type': this.type,
      };
}

class Publication {
  String? date;
  String? publisher;
  String? summary;
  String? title;
  String? url;

  Publication.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    publisher = json['publisher'];
    summary = json['summary'];
    title = json['publisher'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() => {
        'date': this.date,
        'publisher': this.publisher,
        'summary': this.summary,
        'title': this.title,
        'url': this.url,
      };
}

class Skill {
  String? level;
  String? skill;
  int? years;

  Skill.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    skill = json['skill'];
    years = json['years'];
  }

  Map<String, dynamic> toJson() => {
        'level': this.level,
        'skill': this.skill,
        'years': this.years,
      };
}

class Work {
  String? company;
  String? companyID;
  double? companySize;
  String? description;
  String? endDate;
  String? industry;
  bool? isCurrent;
  String? location;
  String? startDate;
  String? title;

  Work.fromJson(Map<String, dynamic> json) {
    company = json['company'];
    companyID = json['companyID'];
    companySize = json['companySize'];
    description = json['description'];
    endDate = json['endDate'];
    industry = json['industry'];
    isCurrent = json['isCurrent'];
    location = json['location'];
    startDate = json['startDate'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() => {
        'company': this.company,
        'companyID': this.companyID,
        'companySize': this.companySize,
        'description': this.description,
        'endDate': this.endDate,
        'industry': this.industry,
        'isCurrent': this.isCurrent,
        'location': this.location,
        'startDate': this.startDate,
        'title': this.title,
      };
}

/// Conflicting accounts model used for resolving a link account interruption flow.
class ConflictingAccounts {
  String? loginID;
  late List<String> loginProviders = [];

  ConflictingAccounts.fromJson(Map<String, dynamic> json) {
    loginID = json['loginID'];
    if (json['loginProviders'] != null) {
      loginProviders = json['loginProviders'].cast<String>();
    }
  }
}
