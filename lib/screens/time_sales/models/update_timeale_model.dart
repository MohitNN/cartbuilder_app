// To parse this JSON data, do
//
//     final updateTimeSellModel = updateTimeSellModelFromJson(jsonString);

import 'dart:convert';

import 'package:mint_bird_app/screens/time_sales/models/time_sell_detail_model.dart';

UpdateTimeSellModel updateTimeSellModelFromJson(String str) =>
    UpdateTimeSellModel.fromJson(json.decode(str));

String updateTimeSellModelToJson(UpdateTimeSellModel data) =>
    json.encode(data.toJson());

class UpdateTimeSellModel {
  UpdateTimeSellModel({
    this.id,
    this.sales,
    this.name,
  });

  String id;
  List<Sale> sales;
  String name;

  factory UpdateTimeSellModel.fromJson(Map<String, dynamic> json) =>
      UpdateTimeSellModel(
        id: json["_id"] == null ? null : json["_id"],
        sales: json["sales"] == null
            ? null
            : List<Sale>.from(json["sales"].map((x) => Sale.fromJson(x))),
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : "$id",
        "sales": sales == null
            ? null
            : List<dynamic>.from(sales.map((x) => x.toJson())),
        "name": name == null ? null : "$name",
      };
}
