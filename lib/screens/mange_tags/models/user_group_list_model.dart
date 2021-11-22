// To parse this JSON data, do
//
//     final userGroupListDataModel = userGroupListDataModelFromJson(jsonString);

import 'dart:convert';

UserGroupListDataModel userGroupListDataModelFromJson(String str) =>
    UserGroupListDataModel.fromJson(json.decode(str));

String userGroupListDataModelToJson(UserGroupListDataModel data) =>
    json.encode(data.toJson());

class UserGroupListDataModel {
  UserGroupListDataModel({
    this.status,
    this.response,
    this.data,
  });

  String status;
  String response;
  List<UserGroup> data;

  factory UserGroupListDataModel.fromJson(Map<String, dynamic> json) =>
      UserGroupListDataModel(
        status: json["status"] == null ? null : json["status"].toString(),
        response: json["response"] == null ? null : json["response"].toString(),
        data: json["data"] == null
            ? null
            : List<UserGroup>.from(json["data"].map((x) => UserGroup.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "response": response == null ? null : response,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class UserGroup {
  UserGroup({
    this.id,
    this.groupName,
    this.userId,
    this.updatedAt,
    this.createdAt,
    this.isactive,
  });

  String id;
  String groupName;
  String userId;
  DateTime updatedAt;
  DateTime createdAt;
  int isactive;

  factory UserGroup.fromJson(Map<String, dynamic> json) => UserGroup(
        id: json["_id"] == null ? null : json["_id"].toString(),
        groupName:
            json["group_name"] == null ? null : json["group_name"].toString(),
        userId: json["user_id"] == null ? null : json["user_id"].toString(),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        isactive: json["isactive"] == null
            ? null
            : int.parse(json["isactive"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "group_name": groupName == null ? null : groupName,
        "user_id": userId == null ? null : userId,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "isactive": isactive == null ? null : isactive,
      };
}
