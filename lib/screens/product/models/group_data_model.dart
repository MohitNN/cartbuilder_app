// To parse this JSON data, do
//
//     final groupDataModel = groupDataModelFromJson(jsonString);

import 'dart:convert';

GroupDataModel groupDataModelFromJson(String str) => GroupDataModel.fromJson(json.decode(str));

String groupDataModelToJson(GroupDataModel data) => json.encode(data.toJson());

class GroupDataModel {
  GroupDataModel({
    this.status,
    this.code,
    this.response,
  });

  final bool status;
  final int code;
  final List<Groups> response;

  factory GroupDataModel.fromJson(Map<String, dynamic> json) => GroupDataModel(
    status: json["status"] == null ? null : json["status"],
    code: json["code"] == null ? null : json["code"],
    response: json["response"] == null ? null : List<Groups>.from(json["response"].map((x) => Groups.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "code": code == null ? null : code,
    "response": response == null ? null : List<dynamic>.from(response.map((x) => x.toJson())),
  };
}

class Groups {
  Groups({
    this.id,
    this.name,
    this.userId,
    this.updatedAt,
    this.createdAt,
  });

  final String id;
  final String name;
  final UserId userId;
  final DateTime updatedAt;
  final DateTime createdAt;

  factory Groups.fromJson(Map<String, dynamic> json) => Groups(
    id: json["_id"] == null ? null : json["_id"],
    name: json["name"] == null ? null : json["name"],
    userId: json["user_id"] == null ? null : userIdValues.map[json["user_id"]],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "name": name == null ? null : name,
    "user_id": userId == null ? null : userIdValues.reverse[userId],
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
  };
}

enum UserId { THE_5_F44_E160_BCBD6_F53011_EF502 }

final userIdValues = EnumValues({
  "5f44e160bcbd6f53011ef502": UserId.THE_5_F44_E160_BCBD6_F53011_EF502
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) =>  MapEntry(v, k));
    }
    return reverseMap;
  }
}
