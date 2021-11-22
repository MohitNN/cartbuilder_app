// To parse this JSON data, do
//
//     final userDownSellModel = userDownSellModelFromJson(jsonString);

import 'dart:convert';

UserDownSellModel userDownSellModelFromJson(String str) =>
    UserDownSellModel.fromJson(json.decode(str));

String userDownSellModelToJson(UserDownSellModel data) => json.encode(data.toJson());

class UserDownSellModel {
  UserDownSellModel({
    this.status,
    this.code,
    this.response,
    this.appDomain,
    this.currentPage,
    this.lastPage,
  });

  bool status;
  int code;
  List<DownSellDatum> response;
  String appDomain;
  int currentPage;
  int lastPage;

  factory UserDownSellModel.fromJson(Map<String, dynamic> json) => UserDownSellModel(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : int.parse(json["code"].toString()),
        response: json["response"] == null
            ? null
            : List<DownSellDatum>.from(json["response"].map((x) => DownSellDatum.fromJson(x))),
        appDomain: json["app_domain"] == null ? null : json["app_domain"].toString(),
        currentPage: json["currentPage"] == null ? null : int.parse(json["currentPage"].toString()),
        lastPage: json["lastPage"] == null ? null : int.parse(json["lastPage"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "response": response == null ? null : List<dynamic>.from(response.map((x) => x.toJson())),
        "app_domain": appDomain == null ? null : appDomain,
        "currentPage": currentPage == null ? null : currentPage,
        "lastPage": lastPage == null ? null : lastPage,
      };
}

class DownSellDatum {
  DownSellDatum({
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

  factory DownSellDatum.fromJson(Map<String, dynamic> json) => DownSellDatum(
        id: json["_id"] == null ? null : json["_id"].toString(),
        name: json["name"] == null ? null : json["name"].toString(),
        price: json["price"] == null ? null : json["price"].toString(),
        views: json["views"] == null ? null : json["views"].toString(),
        totalSales: json["total_sales"] == null ? null : json["total_sales"].toString(),
        order: json["order"] == null ? null : json["order"].toString(),
        conv: json["conv"] == null ? null : json["conv"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "price": price == null ? null : price,
        "views": views == null ? null : views,
        "total_sales": totalSales == null ? null : totalSales,
        "order": order == null ? null : order,
        "conv": conv == null ? null : conv,
      };
}
