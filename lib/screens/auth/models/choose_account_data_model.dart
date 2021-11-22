// To parse this JSON data, do
//
//     final userDetailDataModel = userDetailDataModelFromJson(jsonString);

import 'dart:convert';

class UserDetailDataModel {
  UserDetailDataModel({
    this.status,
    this.code,
    this.response,
  });

  bool status;
  int code;
  List<ChooseAccount> response;

  factory UserDetailDataModel.fromRawJson(String str) => UserDetailDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserDetailDataModel.fromJson(Map<String, dynamic> json) => UserDetailDataModel(
    status: json["status"] == null ? null : json["status"],
    code: json["code"] == null ? null : json["code"],
    response: json["response"] == null ? null : List<ChooseAccount>.from(json["response"].map((x) => ChooseAccount.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "code": code == null ? null : code,
    "response": response == null ? null : List<dynamic>.from(response.map((x) => x.toJson())),
  };
}

class ChooseAccount {
  ChooseAccount({
    this.id,
    this.userId,
    this.account,
    this.updatedAt,
    this.createdAt,
  });

  String id;
  String userId;
  Account account;
  DateTime updatedAt;
  DateTime createdAt;

  factory ChooseAccount.fromRawJson(String str) => ChooseAccount.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChooseAccount.fromJson(Map<String, dynamic> json) => ChooseAccount(
    id: json["_id"] == null ? null : json["_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    account: json["account"] == null ? null : Account.fromJson(json["account"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "account": account == null ? null : account.toJson(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
  };
}

class Account {
  Account({
    this.type,
    this.membershipName,
    this.apiKey,
    this.secretKey,
  });

  String type;
  String membershipName;
  String apiKey;
  String secretKey;

  factory Account.fromRawJson(String str) => Account.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    type: json["type"] == null ? null : json["type"],
    membershipName: json["membership_name"] == null ? null : json["membership_name"],
    apiKey: json["api_key"] == null ? null : json["api_key"],
    secretKey: json["secret_key"] == null ? null : json["secret_key"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "membership_name": membershipName == null ? null : membershipName,
    "api_key": apiKey == null ? null : apiKey,
    "secret_key": secretKey == null ? null : secretKey,
  };
}
