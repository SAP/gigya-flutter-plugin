import 'dart:convert';

/// General response structure.
class GigyaResponse {
  String callId;
  int statusCode = 200;
  int errorCode = 0;
  String errorDetails;
  String statusReason;

  GigyaResponse.fromJson(dynamic json) {
    callId = json['callId'];
    statusCode = json['statusCode'];
    errorCode = json['errorCode'];
    errorDetails = json['errorDetails'];
    statusReason = json['statusReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['callID'] = callId;
    data['statusCode'] = statusCode;
    data['errorCode'] = errorCode;
    data['errorDetails'] = errorDetails;
    data['statusReason'] = statusReason;
    return data;
  }
}

/// Account schema object.
class Account extends GigyaResponse {
  String uid;
  Profile profile;

  Account.fromJson(dynamic json) : super.fromJson(json) {
    uid = json["UID"];
    profile = Profile.fromJson(json["profile"].cast<String, dynamic>());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UID'] = this.uid;
    data['profile'] = this.profile.toJson();
    return data;
  }

  Map<String, dynamic> toJsonEncoded() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UID'] = this.uid;
    data['profile'] = jsonEncode(this.profile.toJson());
    return data;
  }
}

/// Account profile schema object.
class Profile {
  String email;
  String firstName;
  String lastName;
  String photoURL;
  String thumbnailURL;
  String zip;

  Profile({this.email, this.firstName, this.lastName, this.photoURL, this.thumbnailURL, this.zip});

  Profile.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    photoURL = json['photoURL'];
    thumbnailURL = json['thumbnailURL'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['photoURL'] = this.photoURL;
    data['thumbnailURL'] = this.thumbnailURL;
    data['zip'] = this.zip;
    return data;
  }
}
