// To parse this JSON data, do
//
//     final userDownSellDetailsModel = userDownSellDetailsModelFromJson(jsonString);

import 'dart:convert';

UserDownSellDetailsModel userDownSellDetailsModelFromJson(String str) =>
    UserDownSellDetailsModel.fromJson(json.decode(str));

String userDownSellDetailsModelToJson(UserDownSellDetailsModel data) =>
    json.encode(data.toJson());

class UserDownSellDetailsModel {
  UserDownSellDetailsModel({
    this.status,
    this.code,
    this.downsell,
  });

  bool status;
  int code;
  Downsell downsell;

  factory UserDownSellDetailsModel.fromJson(Map<String, dynamic> json) =>
      UserDownSellDetailsModel(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : int.parse(json["code"].toString()),
        downsell:
            json["upsell"] == null ? null : Downsell.fromJson(json["upsell"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "upsell": downsell == null ? null : downsell.toJson(),
      };
}

class Downsell {
  Downsell({
    this.id,
    this.userId,
    this.downsellDetails,
    this.checkoutDesign,
    this.thumbnailStatus,
    this.updatedAt,
    this.createdAt,
    this.typeOfDelivery,
    this.membershipType,
  });

  String id;
  String userId;
  DownsellDetails downsellDetails;
  CheckoutDesign checkoutDesign;
  String thumbnailStatus;
  DateTime updatedAt;
  DateTime createdAt;
  String typeOfDelivery;
  String membershipType;

  factory Downsell.fromJson(Map<String, dynamic> json) => Downsell(
        id: json["_id"] == null ? null : json["_id"].toString(),
        userId: json["user_id"] == null ? null : json["user_id"].toString(),
        downsellDetails: json["downsell_details"] == null
            ? null
            : DownsellDetails.fromJson(json["downsell_details"]),
        checkoutDesign: json["checkout_design"] == null
            ? null
            : CheckoutDesign.fromJson(json["checkout_design"]),
        thumbnailStatus: json["thumbnail_status"] == null
            ? null
            : json["thumbnail_status"].toString(),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        typeOfDelivery: json["type_of_delivery"] == null
            ? null
            : json["type_of_delivery"].toString(),
        membershipType: json["membership_type"] == null
            ? null
            : json["membership_type"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "downsell_details":
            downsellDetails == null ? null : downsellDetails.toJson(),
        "checkout_design":
            checkoutDesign == null ? null : checkoutDesign.toJson(),
        "thumbnail_status": thumbnailStatus == null ? null : thumbnailStatus,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "type_of_delivery": typeOfDelivery == null ? null : typeOfDelivery,
        "membership_type": membershipType == null ? null : membershipType,
      };
}

class CheckoutDesign {
  CheckoutDesign({
    this.templateId,
  });

  int templateId;

  factory CheckoutDesign.fromJson(Map<String, dynamic> json) => CheckoutDesign(
        templateId: json["template_id"] == null
            ? null
            : int.parse(json["template_id"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "template_id": templateId == null ? null : templateId,
      };
}

class DownsellDetails {
  DownsellDetails(
      {this.downsellName,
      this.downsellPrice,
      this.downsellDescription,
      this.downsellImage,
      this.downsellCustomUrl,
      this.downsellGroup,
      this.downsellGroupTag,
      this.productId,
      this.optionId,
      this.downsellTag});

  String downsellName;
  String downsellPrice;
  String downsellDescription;
  String downsellImage;
  String downsellCustomUrl;
  String downsellGroup;
  String downsellGroupTag;
  String productId;
  String downsellTag;
  int optionId;

  factory DownsellDetails.fromJson(Map<String, dynamic> json) =>
      DownsellDetails(
        downsellName: json["downsell_name"] == null
            ? null
            : json["downsell_name"].toString(),
        downsellPrice: json["downsell_price"] == null
            ? null
            : json["downsell_price"].toString(),
        downsellDescription: json["downsell_description"] == null
            ? null
            : json["downsell_description"].toString(),
        downsellImage: json["downsell_image"] == null
            ? null
            : json["downsell_image"].toString(),
        downsellCustomUrl: json["downsell_custom_url"] == null
            ? null
            : json["downsell_custom_url"].toString(),
        downsellGroup: json["downsell_group"] == null
            ? null
            : json["downsell_group"].toString(),
        downsellGroupTag: json["downsell_group_tag"] == null
            ? null
            : json["downsell_group_tag"].toString(),
        downsellTag: json["downsell_tag"] == null
            ? null
            : json["downsell_tag"].toString(),
        productId: json["product_id"].toString(),
        optionId: json["optionId"] == null
            ? null
            : int.parse(json["optionId"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "downsell_name": downsellName == null ? null : downsellName,
        "downsell_price": downsellPrice == null ? null : downsellPrice,
        "downsell_description":
            downsellDescription == null ? null : downsellDescription,
        "downsell_image": downsellImage == null ? null : downsellImage,
        "downsell_custom_url":
            downsellCustomUrl == null ? null : downsellCustomUrl,
        "downsell_group": downsellGroup == null ? null : downsellGroup,
        "downsell_tag": downsellTag == null ? null : downsellTag,
        "product_id": productId,
        "optionId": optionId == null ? null : optionId,
      };
}
