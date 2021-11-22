// To parse this JSON data, do
//
//     final scarcityProductsModel = scarcityProductsModelFromJson(jsonString);

import 'dart:convert';

import 'package:mint_bird_app/screens/dime_sales/models/dime_sell_detail_model.dart';
import 'package:mint_bird_app/screens/time_sales/models/time_sell_detail_model.dart';

ScarcityProductsModel scarcityProductsModelFromJson(String str) =>
    ScarcityProductsModel.fromJson(json.decode(str));

String scarcityProductsModelToJson(ScarcityProductsModel data) =>
    json.encode(data.toJson());

class ScarcityProductsModel {
  ScarcityProductsModel({
    this.status,
    this.response,
    this.message,
    this.data,
  });

  String status;
  int response;
  String message;
  Data data;

  factory ScarcityProductsModel.fromJson(Map<String, dynamic> json) =>
      ScarcityProductsModel(
        status: json["status"] == null ? null : json["status"],
        response: json["response"] == null ? null : json["response"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "response": response == null ? null : response,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({this.dimesale, this.timesale, this.timeSaleName, this.dimeSaleName});

  ScarDimesale dimesale;
  ScarTimesale timesale;
  String dimeSaleName;
  String timeSaleName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      dimesale: json["dimesale"] == null
          ? null
          : ScarDimesale.fromJson(json["dimesale"]),
      timesale: json["timesale"] == null
          ? null
          : ScarTimesale.fromJson(json["timesale"]),
      timeSaleName:
          json["Timesale_name"] == null ? null : json["Timesale_name"],
      dimeSaleName:
          json["Dimesale_name"] == null ? null : json["Dimesale_name"]);

  Map<String, dynamic> toJson() => {
        "dimesale": dimesale == null ? null : dimesale.toJson(),
        "timesale": timesale == null ? null : timesale.toJson(),
      };
}

class ScarDimesale {
  ScarDimesale({
    this.id,
    this.sales,
    this.dimeSaleName,
    this.theme,
    this.topBarText,
    this.topBarBoldText,
    this.topBarRegularText,
    this.saleId,
    this.type,
    this.userId,
    this.productId,
    this.updatedAt,
    this.createdAt,
    this.countViews,
  });

  String id;
  List<DimesaleSale> sales;
  Theme theme;
  String dimeSaleName;
  String topBarText;
  String topBarBoldText;
  String topBarRegularText;
  String saleId;
  String type;
  String userId;
  String productId;
  DateTime updatedAt;
  DateTime createdAt;
  int countViews;

  factory ScarDimesale.fromJson(Map<String, dynamic> json) => ScarDimesale(
        id: json["_id"] == null ? null : json["_id"],
        dimeSaleName:
            json["dimesale_name"] == null ? null : json["dimesale_name"],
        sales: json["sales"] == null
            ? null
            : List<DimesaleSale>.from(
                json["sales"].map((x) => DimesaleSale.fromJson(x))),
        theme: json["theme"] == null ? null : Theme.fromJson(json["theme"]),
        topBarText: json["top_bar_text"] == null ? null : json["top_bar_text"],
        topBarBoldText: json["top_bar_bold_text"] == null
            ? null
            : json["top_bar_bold_text"],
        topBarRegularText: json["top_bar_regular_text"] == null
            ? null
            : json["top_bar_regular_text"],
        saleId: json["sale_id"] == null ? null : json["sale_id"],
        type: json["type"] == null ? null : json["type"],
        userId: json["user_id"] == null ? null : json["user_id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        countViews: json["count_views"] == null ? null : json["count_views"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "sales": sales == null
            ? null
            : List<dynamic>.from(sales.map((x) => x.toJson())),
        "theme": theme == null ? null : theme.toJson(),
        "top_bar_text": topBarText == null ? null : topBarText,
        "sale_id": saleId == null ? null : saleId,
        "type": type == null ? null : type,
        "user_id": userId == null ? null : userId,
        "product_id": productId == null ? null : productId,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "count_views": countViews == null ? null : countViews,
      };
}

class DimesaleSale {
  DimesaleSale({
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

  factory DimesaleSale.fromJson(Map<String, dynamic> json) => DimesaleSale(
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

class Theme {
  Theme({
    this.topBarColor,
    this.buttonTextColor,
    this.buttonColor,
    this.timerTextColor,
    this.timerColor,
    this.boldTextColor,
    this.textColor,
  });

  String topBarColor;
  String buttonTextColor;
  String buttonColor;
  String timerTextColor;
  String timerColor;
  String boldTextColor;
  String textColor;

  factory Theme.fromJson(Map<String, dynamic> json) => Theme(
        topBarColor:
            json["top_bar_color"] == null ? null : json["top_bar_color"],
        buttonTextColor: json["button_text_color"] == null
            ? null
            : json["button_text_color"],
        buttonColor: json["button_color"] == null ? null : json["button_color"],
        timerTextColor:
            json["timer_text_color"] == null ? null : json["timer_text_color"],
        timerColor: json["timer_color"] == null ? null : json["timer_color"],
        boldTextColor:
            json["bold_text_color"] == null ? null : json["bold_text_color"],
        textColor: json["text_color"] == null ? null : json["text_color"],
      );

  Map<String, dynamic> toJson() => {
        "top_bar_color": topBarColor == null ? null : topBarColor,
        "button_text_color": buttonTextColor == null ? null : buttonTextColor,
        "button_color": buttonColor == null ? null : buttonColor,
        "timer_text_color": timerTextColor == null ? null : timerTextColor,
        "timer_color": timerColor == null ? null : timerColor,
        "bold_text_color": boldTextColor == null ? null : boldTextColor,
        "text_color": textColor == null ? null : textColor,
      };
}

class ScarTimesale {
  ScarTimesale({
    this.id,
    this.sales,
    this.theme,
    this.topBarText,
    this.topBarBoldText,
    this.topBarRegularText,
    this.type,
    this.saleId,
    this.userId,
    this.productId,
    this.updatedAt,
    this.createdAt,
    this.countViews,
    this.isOrderSummaryTimer,
    this.orderSummaryTimerText,
  });

  String id;
  List<TimesaleSale> sales;
  Theme theme;
  String topBarText;
  String topBarBoldText;
  String topBarRegularText;
  String type;
  String saleId;
  String userId;
  String productId;
  DateTime updatedAt;
  DateTime createdAt;
  String isOrderSummaryTimer;
  String orderSummaryTimerText;
  int countViews;

  factory ScarTimesale.fromJson(Map<String, dynamic> json) => ScarTimesale(
        id: json["_id"] == null ? null : json["_id"],
        sales: json["sales"] == null
            ? null
            : List<TimesaleSale>.from(
                json["sales"].map((x) => TimesaleSale.fromJson(x))),
        theme: json["theme"] == null ? null : Theme.fromJson(json["theme"]),
        topBarText: json["top_bar_text"] == null ? null : json["top_bar_text"],
        topBarBoldText: json["top_bar_bold_text"] == null
            ? null
            : json["top_bar_bold_text"],
        isOrderSummaryTimer: json["is_order_summary_timer"] == null
            ? null
            : json["is_order_summary_timer"],
        orderSummaryTimerText: json["order_summary_timer_text"] == null
            ? null
            : json["order_summary_timer_text"],
        topBarRegularText: json["top_bar_regular_text"] == null
            ? null
            : json["top_bar_regular_text"],
        type: json["type"] == null ? null : json["type"],
        saleId: json["sale_id"] == null ? null : json["sale_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        countViews: json["count_views"] == null ? null : json["count_views"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "sales": sales == null
            ? null
            : List<dynamic>.from(sales.map((x) => x.toJson())),
        "theme": theme == null ? null : theme.toJson(),
        "top_bar_text": topBarText == null ? null : topBarText,
        "type": type == null ? null : type,
        "sale_id": saleId == null ? null : saleId,
        "user_id": userId == null ? null : userId,
        "product_id": productId == null ? null : productId,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "count_views": countViews == null ? null : countViews,
      };
}

class TimesaleSale {
  TimesaleSale({
    this.active,
    this.timesettime,
    this.auto,
    this.manual,
    this.time,
    this.manualTime,
    this.updateManualTime,
  });

  bool active;
  String timesettime;
  List<TimeSaleAuto> auto;
  List<TimeSellManual> manual;
  DateTime time;
  DateTime manualTime;
  DateTime updateManualTime;

  factory TimesaleSale.fromJson(Map<String, dynamic> json) => TimesaleSale(
        active: json["active"] == null ? null : json["active"],
        timesettime: json["timesettime"] == null ? null : json["timesettime"],
        auto: json["auto"] == null
            ? null
            : List<TimeSaleAuto>.from(
                json["auto"].map((x) => TimeSaleAuto.fromJson(x))),
        manual: json["manual"] == null
            ? null
            : List<TimeSellManual>.from(
                json["manual"].map((x) => TimeSellManual.fromJson(x))),
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        manualTime: json["manual_time"] == null
            ? null
            : DateTime.parse(json["manual_time"]),
        updateManualTime: json["update_manual_time"] == null
            ? null
            : DateTime.parse(json["update_manual_time"]),
      );

  Map<String, dynamic> toJson() => {
        "active": active == null ? null : active,
        "timesettime": timesettime == null ? null : timesettime,
        "auto": auto == null
            ? null
            : List<dynamic>.from(auto.map((x) => x.toJson())),
        "manual": manual == null
            ? null
            : List<dynamic>.from(manual.map((x) => x.toJson())),
        "time": time == null ? null : time.toIso8601String(),
        "manual_time": manualTime == null ? null : manualTime.toIso8601String(),
        "update_manual_time": updateManualTime == null
            ? null
            : updateManualTime.toIso8601String(),
      };
}
