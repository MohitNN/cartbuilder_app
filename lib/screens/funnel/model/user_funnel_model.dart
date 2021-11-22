// To parse this JSON data, do
//
//     final userFunnelModel = userFunnelModelFromJson(jsonString);

import 'dart:convert';

UserFunnelModel userFunnelModelFromJson(String str) =>
    UserFunnelModel.fromJson(json.decode(str));

String userFunnelModelToJson(UserFunnelModel data) =>
    json.encode(data.toJson());

class UserFunnelModel {
  UserFunnelModel({
    this.status,
    this.code,
    this.response,
    this.currentPage,
    this.lastPage,
  });

  bool status;
  int code;
  List<FunnelDatum> response;
  int currentPage;
  int lastPage;

  factory UserFunnelModel.fromJson(Map<String, dynamic> json) =>
      UserFunnelModel(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : int.parse(json["code"].toString()),
        response: json["response"] == null
            ? null
            : List<FunnelDatum>.from(
                json["response"].map((x) => FunnelDatum.fromJson(x))),
        currentPage: json["currentPage"] == null
            ? null
            : int.parse(json["currentPage"].toString()),
        lastPage: json["lastPage"] == null
            ? null
            : int.parse(json["lastPage"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "response": response == null
            ? null
            : List<dynamic>.from(response.map((x) => x.toJson())),
        "currentPage": currentPage == null ? null : currentPage,
        "lastPage": lastPage == null ? null : lastPage,
      };
}

class FunnelDatum {
  FunnelDatum({
    this.id,
    this.userId,
    this.funnelDetails,
    this.funnelGroupName,
    this.funnelPrice,
    this.checkoutPageUrl,
    this.thumbnailStatus,
    this.advancedOption,
    this.funnelsProduct,
    this.funnelImage,
    this.funnelUrl,
    this.views,
    this.totalSales,
    this.order,
    this.conv,
  });

  String id;
  String userId;
  FunnelDetails funnelDetails;
  String funnelGroupName;
  int funnelPrice;
  String checkoutPageUrl;
  String thumbnailStatus;
  String advancedOption;
  List<FunnelsProduct> funnelsProduct;
  String funnelImage;
  String funnelUrl;
  int views;
  int totalSales;
  int order;
  String conv;

  factory FunnelDatum.fromJson(Map<String, dynamic> json) => FunnelDatum(
        id: json["_id"] == null ? null : json["_id"].toString(),
        userId: json["user_id"] == null ? null : json["user_id"].toString(),
        funnelDetails: json["funnel_details"] == null
            ? null
            : FunnelDetails.fromJson(json["funnel_details"]),
        funnelGroupName: json["funnel_group_name"] == null
            ? null
            : json["funnel_group_name"].toString(),
        funnelPrice: json["funnel_price"] == null
            ? null
            : int.parse(json["funnel_price"].toString()),
        checkoutPageUrl: json["checkout_page_url"] == null
            ? null
            : json["checkout_page_url"].toString(),
        thumbnailStatus: json["thumbnail_status"].toString(),
        advancedOption: json["advanced_option"].toString(),
        funnelsProduct: json["funnels_product"] == null
            ? null
            : List<FunnelsProduct>.from(
                json["funnels_product"].map((x) => FunnelsProduct.fromJson(x))),
        funnelImage: json["funnel_image"].toString(),
        funnelUrl:
            json["funnel_url"] == null ? null : json["funnel_url"].toString(),
        views:
            json["views"] == null ? null : int.parse(json["views"].toString()),
        totalSales: json["total_sales"] == null
            ? null
            : int.parse(json["total_sales"].toString()),
        order:
            json["order"] == null ? null : int.parse(json["order"].toString()),
        conv: json["conv"] == null ? null : json["conv"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "funnel_details": funnelDetails == null ? null : funnelDetails.toJson(),
        "funnel_group_name": funnelGroupName == null ? null : funnelGroupName,
        "funnel_price": funnelPrice == null ? null : funnelPrice,
        "checkout_page_url": checkoutPageUrl == null ? null : checkoutPageUrl,
        "thumbnail_status": thumbnailStatus,
        "advanced_option": advancedOption,
        "funnels_product": funnelsProduct == null
            ? null
            : List<dynamic>.from(funnelsProduct.map((x) => x.toJson())),
        "funnel_image": funnelImage,
        "funnel_url": funnelUrl == null ? null : funnelUrl,
        "views": views == null ? null : views,
        "total_sales": totalSales == null ? null : totalSales,
        "order": order == null ? null : order,
        "conv": conv == null ? null : conv,
      };
}

class FunnelDetails {
  FunnelDetails({
    this.funnelName,
    this.funnelGroupTag,
    this.funnelTag,
  });

  String funnelName;
  String funnelGroupTag;
  String funnelTag;

  factory FunnelDetails.fromJson(Map<String, dynamic> json) => FunnelDetails(
        funnelName:
            json["funnel_name"] == null ? null : json["funnel_name"].toString(),
        funnelGroupTag: json["funnel_group_tag"] == null
            ? null
            : json["funnel_group_tag"].toString(),
        funnelTag:
            json["funnel_tag"] == null ? null : json["funnel_tag"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "funnel_name": funnelName == null ? null : funnelName,
        "funnel_group_tag": funnelGroupTag == null ? null : funnelGroupTag,
        "funnel_tag": funnelTag == null ? null : funnelTag,
      };
}

class FunnelsProduct {
  FunnelsProduct({
    this.upsell,
    this.upsellUrl,
    this.templateId,
    this.downsell,
    this.embedCode,
    this.customUrl,
  });

  String upsell;
  String upsellUrl;
  int templateId;
  List<Downsell> downsell;
  String embedCode;
  dynamic customUrl;

  factory FunnelsProduct.fromJson(Map<String, dynamic> json) => FunnelsProduct(
        upsell: json["upsell"] == null ? null : json["upsell"],
        upsellUrl: json["upsell_url"] == null ? null : json["upsell_url"],
        templateId: json["template_id"] == null ? null : json["template_id"],
        downsell: json["downsell"] == null
            ? null
            : List<Downsell>.from(
                json["downsell"].map((x) => Downsell.fromJson(x))),
        embedCode: json["embed_code"] == null ? null : json["embed_code"],
        customUrl: json["custom_url"],
      );

  Map<String, dynamic> toJson() => {
        "upsell": upsell == null ? null : upsell,
        "upsell_url": upsellUrl == null ? null : upsellUrl,
        "template_id": templateId == null ? null : templateId,
        "downsell": downsell == null
            ? null
            : List<dynamic>.from(downsell.map((x) => x.toJson())),
        "embed_code": embedCode == null ? null : embedCode,
        "custom_url": customUrl,
      };
}

class Downsell {
  Downsell({
    this.downsell,
    this.downsellUrl,
    this.templateId,
    this.customUrl,
    this.embedCode,
    this.isActive,
  });

  String downsell;
  String downsellUrl;
  int templateId;
  String customUrl;
  String embedCode;
  bool isActive;

  factory Downsell.fromJson(Map<String, dynamic> json) => Downsell(
        downsell: json["downsell"] == null ? null : json["downsell"].toString(),
        downsellUrl: json["downsell_url"] == null
            ? null
            : json["downsell_url"].toString(),
        templateId: json["template_id"] == null
            ? null
            : int.parse(json["template_id"].toString()),
        customUrl: json["custom_url"].toString(),
        embedCode:
            json["embed_code"] == null ? null : json["embed_code"].toString(),
        isActive: json["is_active"] == null ? null : json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "downsell": downsell == null ? null : downsell,
        "downsell_url": downsellUrl == null ? null : downsellUrl,
        "template_id": templateId == null ? null : templateId,
        "custom_url": customUrl,
        "embed_code": embedCode == null ? null : embedCode,
        "is_active": isActive == null ? null : isActive,
      };
}
