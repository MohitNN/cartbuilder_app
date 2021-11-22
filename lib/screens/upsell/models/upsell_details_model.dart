// To parse this JSON data, do
//
//     final userUpsellDetailsModel = userUpsellDetailsModelFromJson(jsonString);

import 'dart:convert';

UserUpsellDetailsModel userUpsellDetailsModelFromJson(String str) =>
    UserUpsellDetailsModel.fromJson(json.decode(str));

String userUpsellDetailsModelToJson(UserUpsellDetailsModel data) =>
    json.encode(data.toJson());

class UserUpsellDetailsModel {
  UserUpsellDetailsModel({
    this.status,
    this.code,
    this.upsell,
  });

  final bool status;
  final int code;
  final Upsell upsell;

  factory UserUpsellDetailsModel.fromJson(Map<String, dynamic> json) =>
      UserUpsellDetailsModel(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : int.parse(json["code"].toString()),
        upsell: json["upsell"] == null ? null : Upsell.fromJson(json["upsell"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "upsell": upsell == null ? null : upsell.toJson(),
      };
}

class Upsell {
  Upsell({
    this.id,
    this.userId,
    this.upsellDetails,
    this.checkoutDesign,
    this.checkoutCount,
    this.thumbnailStatus,
    this.updatedAt,
    this.createdAt,
    this.membershipType,
    this.typeOfDelivery,
  });

  final String id;
  final String userId;
  final UpsellDetails upsellDetails;
  final CheckoutDesign checkoutDesign;
  final int checkoutCount;
  final int thumbnailStatus;
  final DateTime updatedAt;
  final DateTime createdAt;
  final String membershipType;
  final String typeOfDelivery;

  factory Upsell.fromJson(Map<String, dynamic> json) => Upsell(
        id: json["_id"] == null ? null : json["_id"].toString(),
        userId: json["user_id"] == null ? null : json["user_id"].toString(),
        upsellDetails: json["upsell_details"] == null
            ? null
            : UpsellDetails.fromJson(json["upsell_details"]),
        checkoutDesign: json["checkout_design"] == null
            ? null
            : CheckoutDesign.fromJson(json["checkout_design"]),
        checkoutCount: json["checkout_count"] == null
            ? null
            : int.parse(json["checkout_count"].toString()),
        thumbnailStatus: json["thumbnail_status"] == null
            ? null
            : int.parse(json["thumbnail_status"].toString()),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        membershipType: json["membership_type"] == null
            ? null
            : json["membership_type"].toString(),
        typeOfDelivery: json["type_of_delivery"] == null
            ? null
            : json["type_of_delivery"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "upsell_details": upsellDetails == null ? null : upsellDetails.toJson(),
        "checkout_design":
            checkoutDesign == null ? null : checkoutDesign.toJson(),
        "checkout_count": checkoutCount == null ? null : checkoutCount,
        "thumbnail_status": thumbnailStatus == null ? null : thumbnailStatus,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
      };
}

class CheckoutDesign {
  CheckoutDesign({
    this.templateId,
  });

  final int templateId;

  factory CheckoutDesign.fromJson(Map<String, dynamic> json) => CheckoutDesign(
        templateId: json["template_id"] == null
            ? null
            : int.parse(json["template_id"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "template_id": templateId == null ? null : templateId,
      };
}

class UpsellDetails {
  UpsellDetails(
      {this.upsellName,
      this.upsellPrice,
      this.upsellDescription,
      this.upsellImage,
      this.upsellCustomUrl,
      this.upsellGroup,
      this.upsellGroupTag,
      this.productId,
      this.optionId,
      this.upsellTag});

  final String upsellName;
  final int upsellPrice;
  final String upsellDescription;
  final String upsellImage;
  final String upsellCustomUrl;
  final String upsellGroup;
  final String upsellGroupTag;
  final String productId;
  final int optionId;
  final String upsellTag;

  factory UpsellDetails.fromJson(Map<String, dynamic> json) => UpsellDetails(
        upsellName:
            json["upsell_name"] == null ? null : json["upsell_name"].toString(),
        upsellPrice: json["upsell_price"] == null
            ? null
            : int.parse(json["upsell_price"].toString()),
        upsellDescription: json["upsell_description"] == null
            ? null
            : json["upsell_description"].toString(),
        upsellImage: json["upsell_image"].toString(),
        upsellCustomUrl: json["upsell_custom_url"] == null
            ? null
            : json["upsell_custom_url"].toString(),
        upsellGroup: json["upsell_group"] == null
            ? null
            : json["upsell_group"].toString(),
        upsellGroupTag: json["upsell_group_tag"] == null
            ? null
            : json["upsell_group_tag"].toString(),
        productId: json["product_id"].toString(),
        upsellTag: json["upsell_tag"].toString(),
        optionId: json["optionId"] == null
            ? null
            : int.parse(json["optionId"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "upsell_name": upsellName == null ? null : upsellName,
        "upsell_price": upsellPrice == null ? null : upsellPrice,
        "upsell_description":
            upsellDescription == null ? null : upsellDescription,
        "upsell_image": upsellImage,
        "upsell_custom_url": upsellCustomUrl == null ? null : upsellCustomUrl,
        "upsell_group": upsellGroup == null ? null : upsellGroup,
        "upsell_group_tag": upsellGroupTag == null ? null : upsellGroupTag,
        "product_id": productId,
        "upsell_tag": upsellTag == null ? null : upsellTag,
        "optionId": optionId == null ? null : optionId,
      };
}
