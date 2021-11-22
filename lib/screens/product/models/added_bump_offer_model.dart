// To parse this JSON data, do
//
//     final addedBumpOfferModel = addedBumpOfferModelFromJson(jsonString);

import 'dart:convert';

AddedBumpOfferModel addedBumpOfferModelFromJson(String str) => AddedBumpOfferModel.fromJson(json.decode(str));

String addedBumpOfferModelToJson(AddedBumpOfferModel data) => json.encode(data.toJson());

class AddedBumpOfferModel {
  AddedBumpOfferModel({
    this.status,
    this.code,
    this.response,
  });

  final bool status;
  final int code;
  final List<AddedBumpOffer> response;

  factory AddedBumpOfferModel.fromJson(Map<String, dynamic> json) => AddedBumpOfferModel(
    status: json["status"] == null ? null : json["status"],
    code: json["code"] == null ? null : json["code"],
    response: json["response"] == null ? null : List<AddedBumpOffer>.from(json["response"].map((x) => AddedBumpOffer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "code": code == null ? null : code,
    "response": response == null ? null : List<dynamic>.from(response.map((x) => x.toJson())),
  };
}

class AddedBumpOffer {
  AddedBumpOffer({
    this.id,
    this.offerName,
    this.offerPrice,
    this.group,
    this.userId,
    this.updatedAt,
    this.createdAt,
    this.typeOfDelivery,
    this.membershipType,
    this.templateCode,
    this.connectedAccountId,
    this.productId,
    this.bumpId,
  });

  final String id;
  final String offerName;
  final String offerPrice;
  final String group;
  final String userId;
  final DateTime updatedAt;
  final DateTime createdAt;
  final String typeOfDelivery;
  final String membershipType;
  final TemplateCode templateCode;
  final String connectedAccountId;
  final String productId;
  final String bumpId;

  factory AddedBumpOffer.fromJson(Map<String, dynamic> json) => AddedBumpOffer(
    id: json["_id"] == null ? null : json["_id"],
    offerName: json["offer_name"] == null ? null : json["offer_name"],
    offerPrice: json["offer_price"] == null ? null : json["offer_price"],
    group: json["group"] == null ? null : json["group"],
    userId: json["user_id"] == null ? null : json["user_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    typeOfDelivery: json["type_of_delivery"] == null ? null : json["type_of_delivery"],
    membershipType: json["membership_type"] == null ? null : json["membership_type"],
    templateCode: json["template_code"] == null ? null : TemplateCode.fromJson(json["template_code"]),
    connectedAccountId: json["connected_account_id"] == null ? null : json["connected_account_id"],
    productId: json["product_id"] == null ? null : json["product_id"],
    bumpId: json["bump_id"] == null ? null : json["bump_id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "offer_name": offerName == null ? null : offerName,
    "offer_price": offerPrice == null ? null : offerPrice,
    "group": group == null ? null : group,
    "user_id": userId == null ? null : userId,
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "type_of_delivery": typeOfDelivery == null ? null : typeOfDelivery,
    "membership_type": membershipType == null ? null : membershipType,
    "template_code": templateCode == null ? null : templateCode.toJson(),
    "connected_account_id": connectedAccountId == null ? null : connectedAccountId,
    "product_id": productId == null ? null : productId,
    "bump_id": bumpId == null ? null : bumpId,
  };
}

class TemplateCode {
  TemplateCode({
    this.headerTitle,
    this.headerDescription,
    this.footerText,
    this.buttonColor,
    this.borderColor,
    this.borderType,
    this.backgroundColor,
    this.headingtextColor,
    this.footertextColor,
    this.middletextColor,
  });

  final String headerTitle;
  final String headerDescription;
  final String footerText;
  final String buttonColor;
  final String borderColor;
  final String borderType;
  final String backgroundColor;
  final String headingtextColor;
  final String footertextColor;
  final String middletextColor;

  factory TemplateCode.fromJson(Map<String, dynamic> json) => TemplateCode(
    headerTitle: json["header_title"] == null ? null : json["header_title"],
    headerDescription: json["header_description"] == null ? null : json["header_description"],
    footerText: json["footer_text"] == null ? null : json["footer_text"],
    buttonColor: json["button_color"] == null ? null : json["button_color"],
    borderColor: json["border_color"] == null ? null : json["border_color"],
    borderType: json["border_type"] == null ? null : json["border_type"],
    backgroundColor: json["background_color"] == null ? null : json["background_color"],
    headingtextColor: json["headingtext_color"] == null ? null : json["headingtext_color"],
    footertextColor: json["footertext_color"] == null ? null : json["footertext_color"],
    middletextColor: json["middletext_color"] == null ? null : json["middletext_color"],
  );

  Map<String, dynamic> toJson() => {
    "header_title": headerTitle == null ? null : headerTitle,
    "header_description": headerDescription == null ? null : headerDescription,
    "footer_text": footerText == null ? null : footerText,
    "button_color": buttonColor == null ? null : buttonColor,
    "border_color": borderColor == null ? null : borderColor,
    "border_type": borderType == null ? null : borderType,
    "background_color": backgroundColor == null ? null : backgroundColor,
    "headingtext_color": headingtextColor == null ? null : headingtextColor,
    "footertext_color": footertextColor == null ? null : footertextColor,
    "middletext_color": middletextColor == null ? null : middletextColor,
  };
}
