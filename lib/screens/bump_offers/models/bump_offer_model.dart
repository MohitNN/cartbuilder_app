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
    this.bumpOffer,
    this.currentPage,
    this.lastPage,
  });

  bool status;
  int code;
  List<BumpOffer> bumpOffer;
  int currentPage;
  int lastPage;

  factory BumpOfferModel.fromJson(Map<String, dynamic> json) => BumpOfferModel(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : json["code"],
        bumpOffer: json["bump_offer"] == null
            ? null
            : List<BumpOffer>.from(
                json["bump_offer"].map((x) => BumpOffer.fromJson(x))),
        currentPage: json["currentPage"] == null ? null : json["currentPage"],
        lastPage: json["lastPage"] == null ? null : json["lastPage"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "bump_offer": bumpOffer == null
            ? null
            : List<dynamic>.from(bumpOffer.map((x) => x.toJson())),
        "currentPage": currentPage == null ? null : currentPage,
        "lastPage": lastPage == null ? null : lastPage,
      };
}

class BumpOffer {
  BumpOffer({
    this.id,
    this.bumpOfferName,
    this.bumpOfferPrice,
    this.groupName,
    this.totalSales,
    this.totalOrder,
    this.totalView,
  });

  String id;
  String bumpOfferName;
  String bumpOfferPrice;
  String groupName;
  int totalSales;
  int totalOrder;
  int totalView;

  factory BumpOffer.fromJson(Map<String, dynamic> json) => BumpOffer(
        id: json["id"] == null ? null : json["id"],
        bumpOfferName:
            json["bump_offer_name"] == null ? null : json["bump_offer_name"],
        bumpOfferPrice:
            json["bump_offer_price"] == null ? null : json["bump_offer_price"],
        groupName: json["group_name"] == null ? null : json["group_name"],
        totalSales: json["total_sales"] == null ? null : json["total_sales"],
        totalOrder: json["total_order"] == null ? null : json["total_order"],
        totalView: json["total_view"] == null ? null : json["total_view"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "bump_offer_name": bumpOfferName == null ? null : bumpOfferName,
        "bump_offer_price": bumpOfferPrice == null ? null : bumpOfferPrice,
        "group_name": groupName == null ? null : groupName,
        "total_sales": totalSales == null ? null : totalSales,
        "total_order": totalOrder == null ? null : totalOrder,
        "total_view": totalView == null ? null : totalView,
      };
}
