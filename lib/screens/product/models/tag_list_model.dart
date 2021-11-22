import 'dart:convert';

TagListModel tagListModelFromJson(String str) =>
    TagListModel.fromJson(json.decode(str));

String tagListModelToJson(TagListModel data) => json.encode(data.toJson());

class TagListModel {
  TagListModel({
    this.status,
    this.code,
    this.response,
  });

  bool status;
  int code;
  List<Tags> response;

  factory TagListModel.fromJson(Map<String, dynamic> json) => TagListModel(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : json["code"],
        response: json["response"] == null
            ? null
            : List<Tags>.from(json["response"].map((x) => Tags.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "response": response == null
            ? null
            : List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class Tags {
  Tags({
    this.tagId,
    this.tagName,
  });

  String tagId;
  String tagName;

  factory Tags.fromJson(Map<String, dynamic> json) => Tags(
        tagId: json["tag_id"] == null ? null : json["tag_id"],
        tagName: json["tag_name"] == null ? null : json["tag_name"],
      );

  Map<String, dynamic> toJson() => {
        "tag_id": tagId == null ? null : tagId,
        "tag_name": tagName == null ? null : tagName,
      };
}
