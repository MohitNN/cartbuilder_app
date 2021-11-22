// To parse this JSON data, do
//
//     final dimeSellDetailModel = dimeSellDetailModelFromJson(jsonString);

import 'dart:convert';

DimeSellDetailModel dimeSellDetailModelFromJson(String str) =>
    DimeSellDetailModel.fromJson(json.decode(str));

String dimeSellDetailModelToJson(DimeSellDetailModel data) =>
    json.encode(data.toJson());

class DimeSellDetailModel {
  DimeSellDetailModel({
    this.status,
    this.code,
    this.response,
  });

  bool status;
  int code;
  DimeSellData response;

  factory DimeSellDetailModel.fromJson(Map<String, dynamic> json) =>
      DimeSellDetailModel(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : json["code"],
        response: json["response"] == null
            ? null
            : DimeSellData.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "response": response == null ? null : response.toJson(),
      };
}

class DimeSellData {
  DimeSellData({
    this.id,
    this.dimesaleName,
    this.dimesaleGroupTag,
    this.userId,
    this.sales,
    this.theme,
    this.topBarText,
    this.topBarBoldText,
    this.topBarRegularText,
    this.updatedAt,
    this.createdAt,
  });

  String id;
  String dimesaleName;
  String dimesaleGroupTag;
  String userId;
  List<DimeSaleSale> sales;
  Theme theme;
  String topBarText;
  String topBarBoldText;
  String topBarRegularText;
  DateTime updatedAt;
  DateTime createdAt;

  factory DimeSellData.fromJson(Map<String, dynamic> json) => DimeSellData(
        id: json["_id"] == null ? null : json["_id"],
        dimesaleName:
            json["dimesale_name"] == null ? null : json["dimesale_name"],
        dimesaleGroupTag: json["dimesale_group_tag"] == null
            ? null
            : json["dimesale_group_tag"],
        userId: json["user_id"] == null ? null : json["user_id"],
        sales: json["sales"] == null
            ? null
            : List<DimeSaleSale>.from(
                json["sales"].map((x) => DimeSaleSale.fromJson(x))),
        theme: json["theme"] == null ? null : Theme.fromJson(json["theme"]),
        topBarText: json["top_bar_text"] == null ? null : json["top_bar_text"],
        topBarBoldText: json["top_bar_bold_text"] == null
            ? null
            : json["top_bar_bold_text"],
        topBarRegularText: json["top_bar_regular_text"] == null
            ? null
            : json["top_bar_regular_text"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "dimesale_name": dimesaleName == null ? null : dimesaleName,
        "dimesale_group_tag":
            dimesaleGroupTag == null ? null : dimesaleGroupTag,
        "user_id": userId == null ? null : userId,
        "sales": sales == null
            ? null
            : List<dynamic>.from(sales.map((x) => x.toJson())),
        "theme": theme == null ? null : theme.toJson(),
        "top_bar_text": topBarText == null ? null : topBarText,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
      };
}

class DimeSaleSale {
  DimeSaleSale({
    this.active,
    this.timeset,
    this.totalOrder,
    this.auto,
    this.manual,
  });

  bool active;
  String timeset;
  int totalOrder;
  List<DimeSaleAuto> auto;
  List<DimeSaleManual> manual;

  factory DimeSaleSale.fromJson(Map<String, dynamic> json) => DimeSaleSale(
        active: json["active"] == null ? null : json["active"],
        timeset: json["timeset"] == null ? null : json["timeset"],
        totalOrder: json["total_order"] == null ? null : json["total_order"],
        auto: json["auto"] == null
            ? null
            : List<DimeSaleAuto>.from(
                json["auto"].map((x) => DimeSaleAuto.fromJson(x))),
        manual: json["manual"] == null
            ? null
            : List<DimeSaleManual>.from(
                json["manual"].map((x) => DimeSaleManual.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "active": active == null ? null : active,
        "timeset": timeset == null ? null : timeset,
        "total_order": totalOrder == null ? null : totalOrder,
        "auto": auto == null
            ? null
            : List<dynamic>.from(auto.map((x) => x.toJson())),
        "manual": manual == null
            ? null
            : List<dynamic>.from(manual.map((x) => x.toJson())),
      };
}

class DimeSaleAuto {
  DimeSaleAuto({
    this.gDimeDriectUpsell,
    this.sale,
    this.price,
    this.behavior,
  });

  bool gDimeDriectUpsell;
  dynamic sale;
  String price;
  int behavior;

  factory DimeSaleAuto.fromJson(Map<String, dynamic> json) => DimeSaleAuto(
        gDimeDriectUpsell: json["gDimeDriectUpsell"] == null
            ? null
            : json["gDimeDriectUpsell"],
        sale: json["sale"] == null ? null : json["sale"],
        price: json["price"] == null ? null : json["price"],
        behavior: json["behavior"] == null ? null : json["behavior"],
      );

  Map<String, dynamic> toJson() => {
        "gDimeDriectUpsell":
            gDimeDriectUpsell == null ? null : gDimeDriectUpsell,
        "sale": sale == null ? null : sale,
        "price": price == null ? null : price,
        "behavior": behavior == null ? null : behavior,
      };
}

class DimeSaleManual {
  DimeSaleManual({
    this.gDimeDriectUpsell,
    this.sale,
    this.price,
    this.behavior,
  });

  bool gDimeDriectUpsell;
  int sale;
  String price;
  int behavior;

  factory DimeSaleManual.fromJson(Map<String, dynamic> json) => DimeSaleManual(
        gDimeDriectUpsell: json["gDimeDriectUpsell"] == null
            ? null
            : json["gDimeDriectUpsell"],
        sale: json["sale"] == null ? null : json["sale"],
        price: json["price"] == null ? null : json["price"],
        behavior: json["behavior"] == null ? null : json["behavior"],
      );

  Map<String, dynamic> toJson() => {
        "gDimeDriectUpsell":
            gDimeDriectUpsell == null ? null : gDimeDriectUpsell,
        "sale": sale == null ? null : sale,
        "price": price == null ? null : price,
        "behavior": behavior == null ? null : behavior,
      };
}

class Theme {
  Theme({
    this.boldTextColor,
    this.buttonColor,
    this.buttonTextColor,
    this.textColor,
    this.timerColor,
    this.timerTextColor,
    this.topBarColor,
  });

  String boldTextColor;
  String buttonColor;
  String buttonTextColor;
  String textColor;
  String timerColor;
  String timerTextColor;
  String topBarColor;

  factory Theme.fromJson(Map<String, dynamic> json) => Theme(
        boldTextColor:
            json["bold_text_color"] == null ? null : json["bold_text_color"],
        buttonColor: json["button_color"] == null ? null : json["button_color"],
        buttonTextColor: json["button_text_color"] == null
            ? null
            : json["button_text_color"],
        textColor: json["text_color"] == null ? null : json["text_color"],
        timerColor: json["timer_color"] == null ? null : json["timer_color"],
        timerTextColor:
            json["timer_text_color"] == null ? null : json["timer_text_color"],
        topBarColor:
            json["top_bar_color"] == null ? null : json["top_bar_color"],
      );

  Map<String, dynamic> toJson() => {
        "bold_text_color": boldTextColor == null ? null : boldTextColor,
        "button_color": buttonColor == null ? null : buttonColor,
        "button_text_color": buttonTextColor == null ? null : buttonTextColor,
        "text_color": textColor == null ? null : textColor,
        "timer_color": timerColor == null ? null : timerColor,
        "timer_text_color": timerTextColor == null ? null : timerTextColor,
        "top_bar_color": topBarColor == null ? null : topBarColor,
      };
}
