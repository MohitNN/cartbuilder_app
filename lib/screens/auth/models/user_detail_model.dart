// To parse this JSON data, do
//
//     final userDetailModel = userDetailModelFromJson(jsonString);

import 'dart:convert';

UserDetailModel userDetailModelFromJson(String str) =>
    UserDetailModel.fromJson(json.decode(str));

String userDetailModelToJson(UserDetailModel data) =>
    json.encode(data.toJson());

class UserDetailModel {
  UserDetailModel({
    this.status,
    this.code,
    this.data,
  });

  bool status;
  int code;
  Data data;

  factory UserDetailModel.fromJson(Map<String, dynamic> json) =>
      UserDetailModel(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : int.parse(json["code"].toString()),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.accountType,
    this.username,
    this.name,
    this.email,
    this.phone,
    this.updatedAt,
    this.createdAt,
    this.address,
    this.businessName,
    this.lastLoginDate,
    this.loginCount,
    this.profilePic,
    this.accessLevelId,
    this.accessLevelName,
    this.userTypeId,
    this.userTypeName,
    this.isgetstart,
  });

  String id;
  String accountType;
  String username;
  String name;
  String email;
  String phone;
  DateTime updatedAt;
  DateTime createdAt;
  String address;
  String businessName;
  DateTime lastLoginDate;
  int loginCount;
  String profilePic;
  String accessLevelId;
  String accessLevelName;
  String userTypeId;
  String userTypeName;
  int isgetstart;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"] == null ? null : json["_id"].toString(),
        accountType: json["account_type"] == null ? null : json["account_type"].toString(),
        username: json["username"] == null ? null : json["username"].toString(),
        name: json["name"] == null ? null : json["name"].toString(),
        email: json["email"] == null ? null : json["email"].toString(),
        phone: json["phone"] == null ? null : json["phone"].toString(),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        address: json["address"] == null ? null : json["address"].toString(),
        businessName:
            json["business_name"] == null ? null : json["business_name"].toString(),
        lastLoginDate: json["last_login_date"] == null
            ? null
            : DateTime.parse(json["last_login_date"]),
        loginCount: json["login_count"] == null ? null : int.parse(json["login_count"].toString()),
        profilePic: json["profile_pic"] == null ? null : json["profile_pic"].toString(),
        accessLevelId:
            json["access_level_id"] == null ? null : json["access_level_id"].toString(),
        accessLevelName: json["access_level_name"] == null
            ? null
            : json["access_level_name"].toString(),
        userTypeId: json["user_type_id"] == null ? null : json["user_type_id"].toString(),
        userTypeName:
            json["user_type_name"] == null ? null : json["user_type_name"].toString(),
        isgetstart: json["isgetstart"] == null ? null : int.parse(json["isgetstart"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "account_type": accountType == null ? null : accountType,
        "username": username == null ? null : username,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "address": address == null ? null : address,
        "business_name": businessName == null ? null : businessName,
        "last_login_date":
            lastLoginDate == null ? null : lastLoginDate.toIso8601String(),
        "login_count": loginCount == null ? null : loginCount,
        "profile_pic": profilePic == null ? null : profilePic,
        "access_level_id": accessLevelId == null ? null : accessLevelId,
        "access_level_name": accessLevelName == null ? null : accessLevelName,
        "user_type_id": userTypeId == null ? null : userTypeId,
        "user_type_name": userTypeName == null ? null : userTypeName,
        "isgetstart": isgetstart == null ? null : isgetstart,
      };
}
