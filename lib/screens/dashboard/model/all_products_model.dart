// To parse this JSON data, do
//
//     final allProductsModel = allProductsModelFromJson(jsonString);

import 'dart:convert';

AllProductsModel allProductsModelFromJson(String str) =>
    AllProductsModel.fromJson(json.decode(str));

String allProductsModelToJson(AllProductsModel data) =>
    json.encode(data.toJson());

class AllProductsModel {
  AllProductsModel({
    this.status,
    this.response,
    this.code,
  });

  String status;
  List<AllProduct> response;
  int code;

  factory AllProductsModel.fromJson(Map<String, dynamic> json) =>
      AllProductsModel(
        status: json["status"] == null ? null : json["status"],
        response: json["response"] == null
            ? null
            : List<AllProduct>.from(
                json["response"].map((x) => AllProduct.fromJson(x))),
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "response": response == null
            ? null
            : List<dynamic>.from(response.map((x) => x.toJson())),
        "code": code == null ? null : code,
      };
}

class AllProduct {
  AllProduct({
    this.productName,
    this.id,
  });

  String productName;
  String id;

  factory AllProduct.fromJson(Map<String, dynamic> json) => AllProduct(
        productName: json["product_name"] == null ? null : json["product_name"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "product_name": productName == null ? null : productName,
        "id": id == null ? null : id,
      };
}
