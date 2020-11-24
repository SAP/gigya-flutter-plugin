import 'dart:convert';

/// General response structure.
class GigyaResponse {
  String callId;
  int statusCode = 200;
  int errorCode = 0;
  String errorDetails;
  String statusReason;
  int apiVersion;

  GigyaResponse.fromJson(dynamic json) {
    callId = json['callId'];
    statusCode = json['statusCode'];
    errorCode = json['errorCode'];
    errorDetails = json['errorDetails'];
    statusReason = json['statusReason'];
    apiVersion = json['apiVersion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['callID'] = callId;
    data['statusCode'] = statusCode;
    data['errorCode'] = errorCode;
    data['errorDetails'] = errorDetails;
    data['statusReason'] = statusReason;
    data['apiVersion'] = apiVersion;
    return data;
  }
}

/// Account schema object.
class Account extends GigyaResponse {
  String uid;
  String uidSignature;
  String created;
  double createdTimestamp;
  Emails emails;
  bool isActive;
  bool isRegistered;
  bool isVerified;
  String lastLogin;
  double lastLoginTimestamp;
  String lastUpdated;
  double lastUpdatedTimestamp;
  String loginProvider;
  String oldestDataUpdated;
  double oldestDataUpdatedTimestamp;
  Profile profile;
  String registered;
  double registeredTimestamp;
  SessionInfo sessionInfo;
  double signatureTimestamp;
  String socialProviders;
  String verified;
  double verifiedTimestamp;

  Account.fromJson(dynamic json) : super.fromJson(json) {
    uid = json['UID'];
    uidSignature = json['UIDSignature'];
    created = json['created'];
    createdTimestamp = json['createdTimestamp'];
    emails = Emails.fromJson(json['emails'].cast<String, dynamic>());
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
    profile = Profile.fromJson(json['profile'].cast<String, dynamic>());
    registered = json['registered'];
    registeredTimestamp = json['registeredTimestamp'];
    sessionInfo = SessionInfo.fromJson(json['sessionInfo'].cast<String, dynamic>());
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
    data['profile'] = this.profile.toJson();
    data['registered'] = this.registered;
    data['registeredTimestamp'] = this.registeredTimestamp;
    data['sessionInfo'] = this.sessionInfo.toJson();
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
  double expirationTime;

  SessionInfo.fromJson(Map<String, dynamic> json) {
    sessionToken = json['sessionToken'];
    sessionSecret = json['sessionSecret'];
    expirationTime = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['sessionToken'] = this.sessionToken;
    data['sessionSecret'] = this.sessionSecret;
    data['expires_in'] = this.expirationTime;
    return data;
  }
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
  String email;
  String firstName;
  String lastName;
  String photoURL;
  String thumbnailURL;
  String zip;

  Profile.fromJson(Map<String, dynamic> json) {
    activities = json['activities'];
    address = json['address'];
    age = json['age'];
    bio = json['bio'];
    birthDay = json['birthDay'];
    birthMonth = json['birthMonth'];
    birthYear = json['birthYear'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    photoURL = json['photoURL'];
    thumbnailURL = json['thumbnailURL'];
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
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['photoURL'] = this.photoURL;
    data['thumbnailURL'] = this.thumbnailURL;
    data['zip'] = this.zip;
    return data;
  }
}

class Emails {
  List<String> unverified = [];
  List<String> verified = [];

  Emails.fromJson(Map<String, dynamic> json) {
    unverified = json['unverified'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['unverified'] = this.unverified;
    data['verified'] = this.verified;
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
