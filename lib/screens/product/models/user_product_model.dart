// To parse this JSON data, do
//
//     final userProductModel = userProductModelFromJson(jsonString);

import 'dart:convert';

UserProductModel userProductModelFromJson(String str) =>
    UserProductModel.fromJson(json.decode(str));

String userProductModelToJson(UserProductModel data) => json.encode(data.toJson());

class UserProductModel {
  UserProductModel({
    this.status,
    this.code,
    this.products,
    this.currentPage,
    this.lastPage,
  });

  bool status;
  int code;
  List<ProductData> products;
  int currentPage;
  int lastPage;

  factory UserProductModel.fromJson(Map<String, dynamic> json) => UserProductModel(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : int.parse(json["code"].toString()),
        products: json["products"] == null
            ? null
            : List<ProductData>.from(json["products"].map((x) => ProductData.fromJson(x))),
        currentPage: json["currentPage"] == null ? null : int.parse(json["currentPage"].toString()),
        lastPage: json["lastPage"] == null ? null : int.parse(json["lastPage"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "products": products == null ? null : List<dynamic>.from(products.map((x) => x.toJson())),
        "currentPage": currentPage == null ? null : currentPage,
        "lastPage": lastPage == null ? null : lastPage,
      };
}

class ProductData {
  ProductData({
    this.id,
    this.name,
    this.price,
    this.revenue,
    this.order,
    this.views,
  });

  String id;
  String name;
  String price;
  String revenue;
  String order;
  String views;

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        id: json["_id"] == null ? null : json["_id"].toString(),
        name: json["name"] == null ? null : json["name"].toString(),
        price: json["price"] == null ? null : json["price"].toString(),
        revenue: json["revenue"] == null ? null : json["revenue"].toString(),
        order: json["order"] == null ? null : json["order"].toString(),
        views: json["views"] == null ? null : json["views"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "price": price == null ? null : price,
        "revenue": revenue == null ? null : revenue,
        "order": order == null ? null : order,
        "views": views == null ? null : views,
      };
}
