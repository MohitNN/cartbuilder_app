// To parse this JSON data, do
//
//     final userUpsellModel = userUpsellModelFromJson(jsonString);

import 'dart:convert';

UserUpsellModel userUpsellModelFromJson(String str) => UserUpsellModel.fromJson(json.decode(str));

String userUpsellModelToJson(UserUpsellModel data) => json.encode(data.toJson());

class UserUpsellModel {
  UserUpsellModel({
    this.status,
    this.code,
    this.upsells,
    this.appDomain,
    this.currentPage,
    this.lastPage,
  });

  bool status;
  int code;
  List<UpSellDatum> upsells;
  String appDomain;
  int currentPage;
  int lastPage;

  factory UserUpsellModel.fromJson(Map<String, dynamic> json) => UserUpsellModel(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : int.parse(json["code"].toString()),
        upsells: json["upsells"] == null
            ? null
            : List<UpSellDatum>.from(json["upsells"].map((x) => UpSellDatum.fromJson(x))),
        appDomain: json["app_domain"] == null ? null : json["app_domain"].toString(),
        currentPage: json["currentPage"] == null ? null : int.parse(json["currentPage"].toString()),
        lastPage: json["lastPage"] == null ? null : int.parse(json["lastPage"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "upsells": upsells == null ? null : List<dynamic>.from(upsells.map((x) => x.toJson())),
        "app_domain": appDomain == null ? null : appDomain,
        "currentPage": currentPage == null ? null : currentPage,
        "lastPage": lastPage == null ? null : lastPage,
      };
}

class UpSellDatum {
  UpSellDatum({
    this.id,
    this.name,
    this.price,
    this.views,
    this.totalSales,
    this.order,
    this.conv,
  });

  String id;
  String name;
  String price;
  String views;
  String totalSales;
  String order;
  String conv;

  factory UpSellDatum.fromJson(Map<String, dynamic> json) => UpSellDatum(
        id: json["_id"] == null ? null : json["_id"].toString(),
        name: json["name"] == null ? null : json["name"].toString(),
        price: json["price"].toString(),
        views: json["views"] == null ? null : json["views"].toString(),
        totalSales: json["total_sales"] == null ? null : json["total_sales"].toString(),
        order: json["order"] == null ? null : json["order"].toString(),
        conv: json["conv"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "price": price,
        "views": views == null ? null : views,
        "total_sales": totalSales == null ? null : totalSales,
        "order": order == null ? null : order,
        "conv": conv,
      };
}
