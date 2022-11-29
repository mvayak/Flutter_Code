// To parse this JSON data, do
//
//     final teamModel = teamModelFromJson(jsonString);

import 'dart:convert';

TeamModel teamModelFromJson(String str) => TeamModel.fromJson(json.decode(str));

String teamModelToJson(TeamModel data) => json.encode(data.toJson());

class TeamModel {
  TeamModel({
    this.errorFlag,
    this.message,
    this.data,
  });

  String? errorFlag;
  String? message;
  Data? data;

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
    errorFlag: json["error_flag"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error_flag": errorFlag,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.contacts,
    this.invites,
  });

  List<Contact>? contacts;
  List<Invite>? invites;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    contacts: List<Contact>.from(json["contacts"].map((x) => Contact.fromJson(x))),
    invites: List<Invite>.from(json["invites"].map((x) => Invite.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "contacts": List<dynamic>.from(contacts?.map((x) => x.toJson()) ?? []),
    "invites": List<dynamic>.from(invites?.map((x) => x.toJson()) ?? []),
  };
}

class Contact {
  Contact({
    this.contactId,
    this.email,
    this.firstname,
    this.lastname,
    this.mobile,
    this.dob,
    this.contactAddressLine1,
    this.contactAddressLine2,
    this.city,
    this.countyId,
    this.countryId,
    this.isactive,
    this.role,
    this.roleName,
  });

  String? contactId;
  String? email;
  String? firstname;
  String? lastname;
  String? mobile;
  DateTime? dob;
  String? contactAddressLine1;
  String? contactAddressLine2;
  String? city;
  dynamic countyId;
  dynamic countryId;
  bool? isactive;
  int? role;
  String? roleName;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    contactId: json["contact_id"],
    email: json["email"],
    firstname: json["firstname"] == null ? null : json["firstname"],
    lastname: json["lastname"] == null ? null : json["lastname"],
    mobile: json["mobile"] == null ? null : json["mobile"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    contactAddressLine1: json["contact_address_line_1"] == null ? null : json["contact_address_line_1"],
    contactAddressLine2: json["contact_address_line_2"] == null ? null : json["contact_address_line_2"],
    city: json["city"] == null ? null : json["city"],
    countyId: json["county_id"],
    countryId: json["country_id"],
    isactive: json["isactive"],
    role: json["role"],
    roleName: json["role_name"],
  );

  Map<String, dynamic> toJson() => {
    "contact_id": contactId,
    "email": email,
    "firstname": firstname == null ? null : firstname,
    "lastname": lastname == null ? null : lastname,
    "mobile": mobile == null ? null : mobile,
    "dob": dob == null ? null : dob?.toIso8601String(),
    "contact_address_line_1": contactAddressLine1 == null ? null : contactAddressLine1,
    "contact_address_line_2": contactAddressLine2 == null ? null : contactAddressLine2,
    "city": city == null ? null : city,
    "county_id": countyId,
    "country_id": countryId,
    "isactive": isactive,
    "role": role,
    "role_name": roleName,
  };
}

class Invite {
  Invite({
    this.inviteId,
    this.email,
    this.configName,
  });

  String? inviteId;
  String? email;
  String? configName;

  factory Invite.fromJson(Map<String, dynamic> json) => Invite(
    inviteId: json["invite_id"],
    email: json["email"],
    configName: json["config_name"],
  );

  Map<String, dynamic> toJson() => {
    "invite_id": inviteId,
    "email": email,
    "config_name": configName,
  };
}
