// To parse this JSON data, do
//
//     final timeSellDetailModel = timeSellDetailModelFromJson(jsonString);

import 'dart:convert';

TimeSellDetailModel timeSellDetailModelFromJson(String str) =>
    TimeSellDetailModel.fromJson(json.decode(str));

String timeSellDetailModelToJson(TimeSellDetailModel data) =>
    json.encode(data.toJson());

class TimeSellDetailModel {
  TimeSellDetailModel({
    this.status,
    this.code,
    this.response,
  });

  bool status;
  int code;
  TimeSellData response;

  factory TimeSellDetailModel.fromJson(Map<String, dynamic> json) =>
      TimeSellDetailModel(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : json["code"],
        response: json["response"] == null
            ? null
            : TimeSellData.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "response": response == null ? null : response.toJson(),
      };
}

class TimeSellData {
  TimeSellData({
    this.id,
    this.timesaleName,
    this.timesaleGroupTag,
    this.userId,
    this.sales,
    this.theme,
    this.topBarText,
    this.topBarBoldText,
    this.topBarRegularText,
    this.isOrderSummaryTimer,
    this.orderSummaryTimerText,
    this.updatedAt,
    this.createdAt,
  });

  String id;
  String timesaleName;
  String timesaleGroupTag;
  String userId;
  List<Sale> sales;
  Theme theme;
  String topBarText;
  String topBarBoldText;
  String topBarRegularText;
  String isOrderSummaryTimer;
  String orderSummaryTimerText;
  DateTime updatedAt;
  DateTime createdAt;

  factory TimeSellData.fromJson(Map<String, dynamic> json) => TimeSellData(
        id: json["_id"] == null ? null : json["_id"],
        timesaleName:
            json["timesale_name"] == null ? null : json["timesale_name"],
        timesaleGroupTag: json["timesale_group_tag"] == null
            ? null
            : json["timesale_group_tag"],
        userId: json["user_id"] == null ? null : json["user_id"],
        sales: json["sales"] == null
            ? null
            : List<Sale>.from(json["sales"].map((x) => Sale.fromJson(x))),
        theme: json["theme"] == null ? null : Theme.fromJson(json["theme"]),
        topBarText: json["top_bar_text"] == null ? null : json["top_bar_text"],
        topBarBoldText: json["top_bar_bold_text"] == null
            ? null
            : json["top_bar_bold_text"],
        topBarRegularText: json["top_bar_regular_text"] == null
            ? null
            : json["top_bar_regular_text"],
        isOrderSummaryTimer: json["is_order_summary_timer"] == null
            ? null
            : json["is_order_summary_timer"],
        orderSummaryTimerText: json["order_summary_timer_text"] == null
            ? null
            : json["order_summary_timer_text"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "timesale_name": timesaleName == null ? null : timesaleName,
        "timesale_group_tag":
            timesaleGroupTag == null ? null : timesaleGroupTag,
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

class Sale {
  Sale({
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

  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
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

class TimeSaleAuto {
  TimeSaleAuto({
    this.gDimeDriectUpsell,
    this.sale,
    this.price,
    this.behavior,
    this.hourDay,
  });

  bool gDimeDriectUpsell;
  dynamic sale;
  String price;
  int behavior;
  dynamic hourDay;

  factory TimeSaleAuto.fromJson(Map<String, dynamic> json) => TimeSaleAuto(
        gDimeDriectUpsell: json["gDimeDriectUpsell"] == null
            ? null
            : json["gDimeDriectUpsell"],
        sale: json["sale"] == null ? null : json["sale"],
        price: json["price"] == null ? null : json["price"],
        behavior: json["behavior"] == null ? null : json["behavior"],
        hourDay: json["hour_day"] == null ? null : json["hour_day"],
      );

  Map<String, dynamic> toJson() => {
        "gDimeDriectUpsell":
            gDimeDriectUpsell == null ? null : gDimeDriectUpsell,
        "sale": sale == null ? null : sale,
        "price": price == null ? null : price,
        "behavior": behavior == null ? null : behavior,
        "hour_day": hourDay == null ? null : hourDay,
      };
}

class TimeSellManual {
  TimeSellManual({
    this.gDimeDriectUpsell,
    this.sale,
    this.price,
    this.behavior,
    this.hourDay,
  });

  bool gDimeDriectUpsell;
  int sale;
  String price;
  int behavior;
  dynamic hourDay;

  factory TimeSellManual.fromJson(Map<String, dynamic> json) => TimeSellManual(
        gDimeDriectUpsell: json["gDimeDriectUpsell"] == null
            ? null
            : json["gDimeDriectUpsell"],
        sale: json["sale"] == null ? null : json["sale"],
        price: json["price"] == null ? null : json["price"],
        behavior: json["behavior"] == null ? null : json["behavior"],
        hourDay: json["hour_day"] == null ? null : json["hour_day"],
      );

  Map<String, dynamic> toJson() => {
        "gDimeDriectUpsell":
            gDimeDriectUpsell == null ? null : gDimeDriectUpsell,
        "sale": sale == null ? null : sale,
        "price": price == null ? null : price,
        "behavior": behavior == null ? null : behavior,
        "hour_day": hourDay == null ? null : hourDay,
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
