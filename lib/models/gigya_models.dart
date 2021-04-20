import 'dart:io';

/// Available interruptions.
enum Interruption {
  pendingRegistration,
  pendingVerification,
  conflictingAccounts,
}

/// General response structure.
class GigyaResponse {
  String callId;
  int statusCode = 200;
  int errorCode = 0;
  String errorDetails;
  String statusReason;
  int apiVersion;
  String regToken;
  dynamic mapped;

  Interruption getInterruption() {
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
      : callId = json['callId'],
        statusCode = json['statusCode'],
        errorCode = json['errorCode'],
        errorDetails = json['errorDetails'],
        statusReason = json['statusReason'],
        apiVersion = json['apiVersion'],
        regToken = json['regToken'],
        mapped = json;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['callID'] = callId;
    data['statusCode'] = statusCode;
    data['errorCode'] = errorCode;
    data['errorDetails'] = errorDetails;
    data['statusReason'] = statusReason;
    data['apiVersion'] = apiVersion;
    data['regToken'] = regToken;
    data['mapped'] = mapped;
    return data;
  }
}

/// Account schema object.
class Account extends GigyaResponse {
  String uid;
  String uidSignature;
  String created;
  dynamic createdTimestamp;
  Emails emails;
  bool isActive;
  bool isRegistered;
  bool isVerified;
  String lastLogin;
  dynamic lastLoginTimestamp;
  String lastUpdated;
  dynamic lastUpdatedTimestamp;
  String loginProvider;
  String oldestDataUpdated;
  dynamic oldestDataUpdatedTimestamp;
  Profile profile;
  String registered;
  dynamic registeredTimestamp;
  SessionInfo sessionInfo;
  dynamic signatureTimestamp;
  String socialProviders;
  String verified;
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
      sessionInfo = SessionInfo.fromJson(json['sessionInfo'].cast<String, dynamic>());
    }
    signatureTimestamp = json['signatureTimestamp'];
    socialProviders = json['socialProviders'];
    verified = json['verified'];
    verifiedTimestamp = json['verifiedTimestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['UID'] = this.uid;
    data['UIDSignature'] = this.uidSignature;
    data['created'] = this.created;
    data['createdTimestamp'] = this.createdTimestamp;
    data['emails'] = this.emails.toJson();
    data['isActive'] = this.isActive;
    data['isRegistered'] = this.isRegistered;
    data['isVerified'] = this.isVerified;
    data['lastLogin'] = this.lastLogin;
    data['lastLoginTimestamp'] = this.lastLoginTimestamp;
    data['lastUpdated'] = this.lastUpdated;
    data['loginProvider'] = this.loginProvider;
    data['oldestDataUpdated'] = this.oldestDataUpdated;
    data['lastUpdatedTimestamp'] = this.lastUpdatedTimestamp;
    data['oldestDataUpdatedTimestamp'] = this.oldestDataUpdatedTimestamp;
    if (this.profile != null) {
      data['profile'] = this.profile.toJson();
    }
    data['registered'] = this.registered;
    data['registeredTimestamp'] = this.registeredTimestamp;
    if (this.sessionInfo != null) {
      data['sessionInfo'] = this.sessionInfo.toJson();
    }
    data['signatureTimestamp'] = this.signatureTimestamp;
    data['socialProviders'] = this.socialProviders;
    data['verified'] = this.verified;
    data['verifiedTimestamp'] = this.verifiedTimestamp;
    return data;
  }
}

class SessionInfo {
  String sessionToken;
  String sessionSecret;
  dynamic expiresIn;

  SessionInfo.fromJson(Map<String, dynamic> json) {
    sessionToken = json['sessionToken'];
    sessionSecret = json['sessionSecret'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['sessionToken'] = this.sessionToken;
    data['sessionSecret'] = this.sessionSecret;
    data['expires_in'] = this.expirationTime;
    return data;
  }

  double get expirationTime => Platform.isIOS ? double.parse(expiresIn) : expiresIn;
}

/// Account profile schema object.
class Profile {
  String activities;
  String address;
  int age;
  String bio;
  int birthDay;
  int birthMonth;
  int birthYear;
  List<Certification> certifications;
  String city;
  String country;
  List<Education> education;
  String educationLevel;
  String email;
  List<Favorites> favorites;
  String firstName;
  String lastName;
  double followersCounts;
  double followingCount;
  String gender;
  String hometown;
  String honors;
  String industry;
  String interestedIn;
  String interests;
  String languages;
  Location lastLoginLocation;
  List<Like> likes;
  String locale;
  String name;
  String nickname;
  OidcData oidcData;
  List<Patent> patents;
  List<Phone> phones;
  String photoURL;
  String thumbnailURL;
  String profileURL;
  String politicalView;
  String professionalHeadline;
  String proxyEmail;
  List<Publication> publications;
  String relationshipStatus;
  String religion;
  List<Skill> skills;
  String specialities;
  String state;
  String timezone;
  String username;
  String verified;
  List<Work> work;
  String zip;

  Profile.fromJson(Map<String, dynamic> json) {
    activities = json['activities'];
    address = json['address'];
    age = json['age'];
    bio = json['bio'];
    birthDay = json['birthDay'];
    birthMonth = json['birthMonth'];
    birthYear = json['birthYear'];
    if (json['certifications'] != null) {
      certifications = List<Certification>();
      json['certifications'].forEach((j) {
        certifications.add(Certification.fromJson(j));
      });
    }
    if (json['education'] != null) {
      education = List<Education>();
      json['education'].forEach((j) {
        education.add(Education.fromJson(j));
      });
    }
    educationLevel = json['educationLevel'];
    city = json['city'];
    country = json['country'];
    email = json['email'];
    if (json['favorites'] != null) {
      favorites = List<Favorites>();
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
    if (json['likes'] != null) {
      likes = List<Like>();
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
    if (json['patents'] != null) {
      patents = List<Patent>();
      json['patents'].forEach((j) {
        patents.add(Patent.fromJson(j));
      });
    }
    if (json['phones'] != null) {
      phones = List<Phone>();
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
    if (json['publications'] != null) {
      publications = List<Publication>();
      json['publications'].forEach((j) {
        publications.add(Publication.fromJson(j));
      });
    }
    relationshipStatus = json['relationshipStatus'];
    religion = json['religion'];
    if (json['skills'] != null) {
      skills = List<Skill>();
      json['skills'].forEach((j) {
        skills.add(Skill.fromJson(j));
      });
    }
    specialities = json['specialities'];
    state = json['state'];
    timezone = json['timezone'];
    username = json['username'];
    verified = json['verified'];
    if (json['work'] != null) {
      work = List<Work>();
      json['work'].forEach((j) {
        work.add(Work.fromJson(j));
      });
    }
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['activities'] = this.activities;
    data['address'] = this.address;
    data['age'] = this.age;
    data['bio'] = this.bio;
    data['birthDay'] = this.birthDay;
    data['birthMonth'] = this.birthMonth;
    data['birthYear'] = this.birthYear;
    if (this.certifications != null) {
      data['configurations'] = this.certifications.map((j) => j.toJson()).toList();
    }
    if (this.education != null) {
      data['education'] = this.education.map((j) => j.toJson()).toList();
    }
    data['educationLevel'] = this.educationLevel;
    data['city'] = this.city;
    data['country'] = this.country;
    data['email'] = this.email;
    if (this.favorites != null) {
      data['favorites'] = this.favorites.map((j) => j.toJson()).toList();
    }
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['followersCounts'] = this.followersCounts;
    data['followingCount'] = this.followingCount;
    data['gender'] = this.gender;
    data['hometown'] = this.hometown;
    data['honors'] = this.honors;
    data['industry'] = this.industry;
    data['interestedIn'] = this.interestedIn;
    data['interests'] = this.interests;
    data['languages'] = this.languages;
    if (this.lastLoginLocation != null) {
      data['lastLoginLocation'] = this.lastLoginLocation.toJson();
    }
    if (this.likes != null) {
      data['likes'] = this.likes.map((j) => j.toJson()).toList();
    }
    data['locale'] = this.locale;
    data['name'] = this.name;
    data['nickname'] = this.nickname;
    if (this.oidcData != null) {
      data['oidcData'] = this.oidcData.toJson();
    }
    if (this.patents != null) {
      data['patents'] = this.patents.map((j) => j.toJson()).toList();
    }
    if (this.phones != null) {
      data['phones'] = this.phones.map((j) => j.toJson()).toList();
    }
    data['photoURL'] = this.photoURL;
    data['thumbnailURL'] = this.thumbnailURL;
    data['profileURL'] = this.profileURL;
    data['politicalView'] = this.politicalView;
    data['professionalHeadline'] = this.professionalHeadline;
    data['proxyEmail'] = this.proxyEmail;
    if (this.publications != null) {
      data['publications'] = this.publications.map((j) => j.toJson()).toList();
    }
    data['relationshipStatus'] = this.relationshipStatus;
    data['religion'] = this.religion;
    if (this.skills != null) {
      data['skills'] = this.skills.map((j) => j.toJson()).toList();
    }
    data['specialities'] = this.specialities;
    data['state'] = this.state;
    data['timezone'] = this.timezone;
    data['username'] = this.username;
    data['verified'] = this.verified;
    if (this.work != null) {
      data['work'] = this.work.map((j) => j.toJson()).toList();
    }
    data['zip'] = this.zip;
    return data;
  }
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['unverified'] = this.unverified ?? [];
    data['verified'] = this.verified ?? [];
    return data;
  }
}

class Certification {
  String authority;
  String endDate;
  String name;
  String number;
  String startDate;

  Certification.fromJson(Map<String, dynamic> json) {
    authority = json['authority'];
    endDate = json['endDate'];
    name = json['name'];
    number = json['number'];
    startDate = json['startDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['authority'] = this.authority;
    data['endDate'] = this.endDate;
    data['name'] = this.name;
    data['number'] = this.number;
    data['startDate'] = this.startDate;
    return data;
  }
}

class Education {
  String degree;
  String endYear;
  String fieldOfStudy;
  String school;
  String schoolType;
  String startYear;

  Education.fromJson(Map<String, dynamic> json) {
    degree = json['degree'];
    endYear = json['endYear'];
    fieldOfStudy = json['fieldOfStudy'];
    school = json['school'];
    schoolType = json['schoolType'];
    startYear = json['startYear'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['degree'] = this.degree;
    data['endYear'] = this.endYear;
    data['fieldOfStudy'] = this.fieldOfStudy;
    data['school'] = this.school;
    data['schoolType'] = this.schoolType;
    data['startYear'] = this.startYear;
    return data;
  }
}

class Favorites {
  List<Favorite> activities;
  List<Favorite> books;
  List<Favorite> interests;
  List<Favorite> movies;
  List<Favorite> music;
  List<Favorite> television;

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['activities'] = this.activities ?? [];
    data['books'] = this.books ?? [];
    data['interests'] = this.interests ?? [];
    data['movies'] = this.movies ?? [];
    data['television'] = this.television ?? [];
    return data;
  }
}

class Favorite {
  String id;
  String name;
  String category;

  Favorite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['name'] = this.name;
    data['category'] = this.category;
    return data;
  }
}

class Location {
  String city;
  String country;
  String state;
  Coordinates coordinates;

  Location.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    country = json['country'];
    state = json['state'];
    if (json['coordinates'] != null) {
      coordinates = Coordinates.fromJson(json['coordinates'].cast<String, dynamic>());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['city'] = this.city;
    data['country'] = this.country;
    data['state'] = this.state;
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates.toJson();
    }
    return data;
  }
}

class Coordinates {
  double lat;
  double lon;

  Coordinates.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}

class Like {
  String category;
  String id;
  String name;
  String time;
  double timestamp;

  Like.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    id = json['id'];
    name = json['name'];
    time = json['time'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['category'] = this.category;
    data['id'] = this.id;
    data['name'] = this.name;
    data['time'] = this.time;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class OidcData {
  Address address;
  String emailVerified;
  String locale;
  String middleName;
  String name;
  String phoneNumber;
  String phoneNumberVerified;
  String updatedAt;
  String website;
  String zoneinfo;

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['email_verified'] = this.emailVerified;
    data['locale'] = this.locale;
    data['middle_name'] = this.middleName;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['phone_number_verified'] = this.phoneNumberVerified;
    data['updated_at'] = this.updatedAt;
    data['website'] = this.website;
    data['zoneinfo'] = this.zoneinfo;
    return data;
  }
}

class Address {
  String country;
  String formatted;
  String locality;
  String postalCode;
  String region;
  String streetAddress;

  Address.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    formatted = json['formatted'];
    locality = json['locality'];
    postalCode = json['postal_code'];
    region = json['region'];
    streetAddress = json['street_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['country'] = this.country;
    data['formatted'] = this.formatted;
    data['locality'] = this.locality;
    data['postal_code'] = this.postalCode;
    data['region'] = this.region;
    data['street_address'] = this.streetAddress;
    return data;
  }
}

class Patent {
  String date;
  String number;
  String office;
  String status;
  String summary;
  String title;
  String url;

  Patent.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    number = json['number'];
    office = json['office'];
    status = json['status'];
    summary = json['summary'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['date'] = this.date;
    data['number'] = this.number;
    data['office'] = this.office;
    data['status'] = this.status;
    data['summary'] = this.summary;
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}

class Phone {
  String _default;
  String number;
  String type;

  String get defaultNumber => this._default;

  Phone.fromJson(Map<String, dynamic> json) {
    _default = json['default'];
    number = json['number'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['default'] = this._default;
    data['number'] = this.number;
    data['type'] = this.type;
    return data;
  }
}

class Publication {
  String date;
  String publisher;
  String summary;
  String title;
  String url;

  Publication.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    publisher = json['publisher'];
    summary = json['summary'];
    title = json['publisher'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['date'] = this.date;
    data['publisher'] = this.publisher;
    data['summary'] = this.summary;
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}

class Skill {
  String level;
  String skill;
  int years;

  Skill.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    skill = json['skill'];
    years = json['years'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['level'] = this.level;
    data['skill'] = this.skill;
    data['years'] = this.years;
    return data;
  }
}

class Work {
  String company;
  String companyID;
  double companySize;
  String description;
  String endDate;
  String industry;
  bool isCurrent;
  String location;
  String startDate;
  String title;

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['company'] = this.company;
    data['companyID'] = this.companyID;
    data['companySize'] = this.companySize;
    data['description'] = this.description;
    data['endDate'] = this.endDate;
    data['industry'] = this.industry;
    data['isCurrent'] = this.isCurrent;
    data['location'] = this.location;
    data['startDate'] = this.startDate;
    data['title'] = this.title;
    return data;
  }
}

/// Conflicting accounts model used for resolving a link account interruption flow.
class ConflictingAccounts {
  String loginID;
  List<String> loginProviders;

  ConflictingAccounts.fromJson(Map<String, dynamic> json) {
    loginID = json['loginID'];
    loginProviders = json['loginProviders'].cast<String>();
  }
}
