// To parse this JSON data, do
//
//     final timeSalesModel = timeSalesModelFromJson(jsonString);

import 'dart:convert';

TimeSalesModel timeSalesModelFromJson(String str) =>
    TimeSalesModel.fromJson(json.decode(str));

String timeSalesModelToJson(TimeSalesModel data) => json.encode(data.toJson());

class TimeSalesModel {
  TimeSalesModel({
    this.status,
    this.code,
    this.upsells,
    this.appDomain,
    this.currentPage,
    this.lastPage,
  });

  bool status;
  int code;
  List<TimesellUpsell> upsells;
  String appDomain;
  int currentPage;
  int lastPage;

  factory TimeSalesModel.fromJson(Map<String, dynamic> json) => TimeSalesModel(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : json["code"],
        upsells: json["upsells"] == null
            ? null
            : List<TimesellUpsell>.from(
                json["upsells"].map((x) => TimesellUpsell.fromJson(x))),
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

class TimesellUpsell {
  TimesellUpsell(
      {this.id,
      this.timesaleName,
      this.groupName,
      this.view,
      this.sales,
      this.conv,
      this.msg});

  String id;
  String timesaleName;
  String groupName;
  int view;
  int sales;
  int conv;
  String msg;

  factory TimesellUpsell.fromJson(Map<String, dynamic> json) => TimesellUpsell(
      id: json["id"] == null ? null : json["id"],
      timesaleName:
          json["timesale_name"] == null ? null : json["timesale_name"],
      groupName: json["group_name"] == null ? null : json["group_name"],
      view: json["view"] == null ? null : json["view"],
      sales: json["sales"] == null ? null : json["sales"],
      conv: json["conv"] == null ? null : json["conv"],
      msg: json["msg"] == null ? null : json["msg"]);

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "timesale_name": timesaleName == null ? null : timesaleName,
        "group_name": groupName == null ? null : groupName,
        "view": view == null ? null : view,
        "sales": sales == null ? null : sales,
        "conv": conv == null ? null : conv,
      };
}
