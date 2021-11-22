// To parse this JSON data, do
//
//     final dimeSalesModel = dimeSalesModelFromJson(jsonString);

import 'dart:convert';

DimeSalesModel dimeSalesModelFromJson(String str) =>
    DimeSalesModel.fromJson(json.decode(str));

String dimeSalesModelToJson(DimeSalesModel data) => json.encode(data.toJson());

class DimeSalesModel {
  DimeSalesModel({
    this.status,
    this.code,
    this.upsells,
    this.appDomain,
    this.currentPage,
    this.lastPage,
  });

  bool status;
  int code;
  List<DimeSalesUpsell> upsells;
  String appDomain;
  int currentPage;
  int lastPage;

  factory DimeSalesModel.fromJson(Map<String, dynamic> json) => DimeSalesModel(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : json["code"],
        upsells: json["upsells"] == null
            ? null
            : List<DimeSalesUpsell>.from(
                json["upsells"].map((x) => DimeSalesUpsell.fromJson(x))),
        appDomain: json["app_domain"] == null ? null : json["app_domain"],
        currentPage: json["currentPage"] == null ? null : json["currentPage"],
        lastPage: json["lastPage"] == null ? null : json["lastPage"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "upsells": upsells == null
            ? null
            : List<dynamic>.from(upsells.map((x) => x.toJson())),
        "app_domain": appDomain == null ? null : appDomain,
        "currentPage": currentPage == null ? null : currentPage,
        "lastPage": lastPage == null ? null : lastPage,
      };
}

class DimeSalesUpsell {
  DimeSalesUpsell(
      {this.id,
      this.dimesaleName,
      this.groupName,
      this.view,
      this.sales,
      this.conv,
      this.msg});

  String id;
  String dimesaleName;
  String groupName;
  int view;
  int sales;
  int conv;
  String msg;

  factory DimeSalesUpsell.fromJson(Map<String, dynamic> json) =>
      DimeSalesUpsell(
          id: json["id"] == null ? null : json["id"],
          dimesaleName:
              json["dimesale_name"] == null ? null : json["dimesale_name"],
          groupName: json["group_name"] == null ? null : json["group_name"],
          view: json["view"] == null ? null : json["view"],
          sales: json["sales"] == null ? null : json["sales"],
          conv: json["conv"] == null ? null : json["conv"],
          msg: json["msg"] == null ? null : json["msg"]);

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "dimesale_name": dimesaleName == null ? null : dimesaleName,
        "group_name": groupName == null ? null : groupName,
        "view": view == null ? null : view,
        "sales": sales == null ? null : sales,
        "conv": conv == null ? null : conv,
      };
}
