// To parse this JSON data, do
//
//     final dashboardChart = dashboardChartFromJson(jsonString);

import 'dart:convert';

DashboardChart dashboardChartFromJson(String str) =>
    DashboardChart.fromJson(json.decode(str));

String dashboardChartToJson(DashboardChart data) => json.encode(data.toJson());

class DashboardChart {
  DashboardChart({
    this.status,
    this.response,
    this.maxValue,
    this.code,
    this.xPoints,
  });

  String status;
  Map<String, dynamic> response;
  int maxValue;
  int code;
  Map<String, dynamic> xPoints;

  factory DashboardChart.fromJson(Map<String, dynamic> json) => DashboardChart(
        status: json["status"] == null ? null : json["status"],
        response:
            json["response"] == null || json["response"].toString() == "[]"
                ? null
                : Map.from(json["response"])
                    .map((k, v) => MapEntry<String, dynamic>(k, v)),
        maxValue: json["Max_Value"] == null ? null : json["Max_Value"],
        code: json["code"] == null ? null : json["code"],
        xPoints: json["x_points"] == null
            ? null
            : Map.from(json["x_points"])
                .map((k, v) => MapEntry<String, int>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "response": response == null
            ? null
            : Map.from(response).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "Max_Value": maxValue == null ? null : maxValue,
        "code": code == null ? null : code,
        "x_points": xPoints == null
            ? null
            : Map.from(xPoints).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
