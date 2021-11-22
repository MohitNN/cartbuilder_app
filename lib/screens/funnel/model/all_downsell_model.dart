// To parse this JSON data, do
//
//     final allDownsellModel = allDownsellModelFromJson(jsonString);

import 'dart:convert';

AllDownsellModel allDownsellModelFromJson(String str) =>
    AllDownsellModel.fromJson(json.decode(str));

String allDownsellModelToJson(AllDownsellModel data) =>
    json.encode(data.toJson());

class AllDownsellModel {
  AllDownsellModel({
    this.status,
    this.code,
    this.response,
  });

  bool status;
  int code;
  List<Response> response;

  factory AllDownsellModel.fromJson(Map<String, dynamic> json) =>
      AllDownsellModel(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : json["code"],
        response: json["response"] == null
            ? null
            : List<Response>.from(
                json["response"].map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "response": response == null
            ? null
            : List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class Response {
  Response({
    this.downsellId,
    this.downsellName,
    this.downsellPrice,
  });

  String downsellId;
  String downsellName;
  dynamic downsellPrice;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        downsellId: json["downsell_id"] == null ? null : json["downsell_id"],
        downsellName:
            json["downsell_name"] == null ? null : json["downsell_name"],
        downsellPrice: json["downsell_price"],
      );

  Map<String, dynamic> toJson() => {
        "downsell_id": downsellId == null ? null : downsellId,
        "downsell_name": downsellName == null ? null : downsellName,
        "downsell_price": downsellPrice,
      };
}
