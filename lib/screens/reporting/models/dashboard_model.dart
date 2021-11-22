// To parse this JSON data, do
//
//     final dashBoardModel = dashBoardModelFromJson(jsonString);

import 'dart:convert';

DashBoardModel dashBoardModelFromJson(String str) =>
    DashBoardModel.fromJson(json.decode(str));

String dashBoardModelToJson(DashBoardModel data) => json.encode(data.toJson());

class DashBoardModel {
  DashBoardModel({
    this.status,
    this.dashBoardData,
    this.code,
  });

  String status;
  DashBoardData dashBoardData;
  int code;

  factory DashBoardModel.fromJson(Map<String, dynamic> json) => DashBoardModel(
        status: json["status"] == null ? null : json["status"],
        dashBoardData: json["response"] == null
            ? null
            : DashBoardData.fromJson(json["response"]),
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "response": dashBoardData == null ? null : dashBoardData.toJson(),
        "code": code == null ? null : code,
      };
}

class DashBoardData {
  DashBoardData({
    this.grossRevenue,
    this.grossRefund,
    this.netRevenue,
    this.order,
    this.totalTransactions,
    this.refund,
    this.refundRate,
    this.commission,
  });

  dynamic grossRevenue;
  dynamic grossRefund;
  dynamic netRevenue;
  dynamic order;
  dynamic totalTransactions;
  dynamic refund;
  dynamic refundRate;
  dynamic commission;

  factory DashBoardData.fromJson(Map<String, dynamic> json) => DashBoardData(
        grossRevenue:
            json["grossRevenue"] == null ? null : json["grossRevenue"],
        grossRefund: json["grossRefund"] == null ? null : json["grossRefund"],
        netRevenue: json["netRevenue"] == null ? null : json["netRevenue"],
        order: json["order"] == null ? null : json["order"],
        totalTransactions: json["totalTransactions"] == null
            ? null
            : json["totalTransactions"],
        refund: json["refund"] == null ? null : json["refund"],
        refundRate:
            json["refundRate"] == null ? null : json["refundRate"].toDouble(),
        commission: json["commission"] == null ? null : json["commission"],
      );

  Map<String, dynamic> toJson() => {
        "grossRevenue": grossRevenue == null ? null : grossRevenue,
        "grossRefund": grossRefund == null ? null : grossRefund,
        "netRevenue": netRevenue == null ? null : netRevenue,
        "order": order == null ? null : order,
        "totalTransactions":
            totalTransactions == null ? null : totalTransactions,
        "refund": refund == null ? null : refund,
        "refundRate": refundRate == null ? null : refundRate,
        "commission": commission == null ? null : commission,
      };
}
