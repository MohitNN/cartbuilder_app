// To parse this JSON data, do
//
//     final bumpOfferDetailDataModel = bumpOfferDetailDataModelFromJson(jsonString);

import 'dart:convert';

BumpOfferDetailDataModel bumpOfferDetailDataModelFromJson(String str) => BumpOfferDetailDataModel.fromJson(json.decode(str));

String bumpOfferDetailDataModelToJson(BumpOfferDetailDataModel data) => json.encode(data.toJson());

class BumpOfferDetailDataModel {
  BumpOfferDetailDataModel({
    this.status,
    this.code,
    this.response,
  });

  bool status;
  int code;
  Response response;

  factory BumpOfferDetailDataModel.fromJson(Map<String, dynamic> json) => BumpOfferDetailDataModel(
    status: json["status"] == null ? null : json["status"],
    code: json["code"] == null ? null : int.parse(json["code"].toString()),
    response: json["response"] == null ? null : Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "code": code == null ? null : code,
    "response": response == null ? null : response.toJson(),
  };
}

class Response {
  Response({
    this.id,
    this.offerName,
    this.offerPrice,
    this.group,
    this.userId,
    this.updatedAt,
    this.createdAt,
    this.offerTag,
    this.templateCode,
  });

  String id;
  String offerName;
  String offerPrice;
  String group;
  String userId;
  DateTime updatedAt;
  DateTime createdAt;
  String offerTag;
  TemplateCode templateCode;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    id: json["_id"] == null ? null : json["_id"].toString(),
    offerName: json["offer_name"] == null ? null : json["offer_name"].toString(),
    offerPrice: json["offer_price"] == null ? null : json["offer_price"].toString(),
    group: json["group"] == null ? null : json["group"].toString(),
    userId: json["user_id"] == null ? null : json["user_id"].toString(),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    offerTag: json["offer_tag"] == null ? null : json["offer_tag"].toString(),
    templateCode: json["template_code"] == null ? null : TemplateCode.fromJson(json["template_code"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "offer_name": offerName == null ? null : offerName,
    "offer_price": offerPrice == null ? null : offerPrice,
    "group": group == null ? null : group,
    "user_id": userId == null ? null : userId,
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "offer_tag": offerTag == null ? null : offerTag,
    "template_code": templateCode == null ? null : templateCode.toJson(),
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

  String headerTitle;
  String headerDescription;
  String footerText;
  String buttonColor;
  String borderColor;
  String borderType;
  String backgroundColor;
  String headingtextColor;
  String footertextColor;
  String middletextColor;

  factory TemplateCode.fromJson(Map<String, dynamic> json) => TemplateCode(
    headerTitle: json["header_title"] == null ? null : json["header_title"].toString(),
    headerDescription: json["header_description"] == null ? null : json["header_description"].toString(),
    footerText: json["footer_text"] == null ? null : json["footer_text"].toString(),
    buttonColor: json["button_color"] == null ? null : json["button_color"].toString(),
    borderColor: json["border_color"] == null ? null : json["border_color"].toString(),
    borderType: json["border_type"] == null ? null : json["border_type"].toString(),
    backgroundColor: json["background_color"] == null ? null : json["background_color"].toString(),
    headingtextColor: json["headingtext_color"] == null ? null : json["headingtext_color"].toString(),
    footertextColor: json["footertext_color"] == null ? null : json["footertext_color"].toString(),
    middletextColor: json["middletext_color"] == null ? null : json["middletext_color"].toString(),
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
