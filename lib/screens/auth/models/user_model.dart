// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool status;
  int code;
  String message;
  Data data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.accountType,
    this.username,
    this.name,
    this.email,
    this.phone,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String accountType;
  String username;
  String name;
  String email;
  int phone;
  DateTime updatedAt;
  DateTime createdAt;
  String id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accountType: json["account_type"],
        username: json["username"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "account_type": accountType,
        "username": username,
        "name": name,
        "email": email,
        "phone": phone,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "_id": id,
      };
}
