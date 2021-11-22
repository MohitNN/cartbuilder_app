// To parse this JSON data, do
//
//     final userTagListDataModel = userTagListDataModelFromJson(jsonString);

import 'dart:convert';

UserTagListDataModel userTagListDataModelFromJson(String str) => UserTagListDataModel.fromJson(json.decode(str));

String userTagListDataModelToJson(UserTagListDataModel data) => json.encode(data.toJson());

class UserTagListDataModel {
  UserTagListDataModel({
    this.status,
    this.response,
    this.data,
  });

  String status;
  String response;
  List<UserTag> data;

  factory UserTagListDataModel.fromJson(Map<String, dynamic> json) => UserTagListDataModel(
    status: json["status"] == null ? null : json["status"].toString(),
    response: json["response"] == null ? null : json["response"].toString(),
    data: json["data"] == null ? null : List<UserTag>.from(json["data"].map((x) => UserTag.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "response": response == null ? null : response,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UserTag {
  UserTag({
    this.id,
    this.tagName,
    this.groupId,
    this.groupName,
    this.createdAt,
    this.tagCount,
  });

  String id;
  String tagName;
  String groupId;
  String groupName;
  DateTime createdAt;
  int tagCount;

  factory UserTag.fromJson(Map<String, dynamic> json) => UserTag(
    id: json["id"] == null ? null : json["id"].toString(),
    tagName: json["Tag_name"] == null ? null : json["Tag_name"].toString(),
    groupId: json["group_id"] == null ? null : json["group_id"].toString(),
    groupName: json["group_name"] == null ? null : json["group_name"].toString(),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    tagCount: json["tag_count"] == null ? null : int.parse(json["tag_count"].toString()),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "Tag_name": tagName == null ? null : tagName,
    "group_id": groupId == null ? null : groupId,
    "group_name": groupName == null ? null : groupName,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "tag_count": tagCount == null ? null : tagCount,
  };
}
