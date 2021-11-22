// To parse this JSON data, do
//
//     final bumpOfferModel = bumpOfferModelFromJson(jsonString);

import 'dart:convert';

BumpOfferModel bumpOfferModelFromJson(String str) =>
    BumpOfferModel.fromJson(json.decode(str));

String bumpOfferModelToJson(BumpOfferModel data) => json.encode(data.toJson());

class BumpOfferModel {
  BumpOfferModel({
    this.status,
    this.code,
    this.response,
  });

  bool status;
  int code;
  List<BumpOfferData> response;

  factory BumpOfferModel.fromJson(Map<String, dynamic> json) => BumpOfferModel(
        status: json["status"],
        code: json["code"],
        response: List<BumpOfferData>.from(
            json["response"].map((x) => BumpOfferData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class BumpOfferData {
  BumpOfferData({
    this.id,
    this.offerName,
    this.group,
  });

  String id;
  String offerName;
  String group;

  factory BumpOfferData.fromJson(Map<String, dynamic> json) => BumpOfferData(
        id: json["_id"],
        offerName: json["offer_name"],
        group: json["group"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "offer_name": offerName,
        "group": group,
      };
}
