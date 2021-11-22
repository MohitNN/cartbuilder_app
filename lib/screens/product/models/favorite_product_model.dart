// To parse this JSON data, do
//
//     final favoriteProductModel = favoriteProductModelFromJson(jsonString);

import 'dart:convert';

FavoriteProductModel favoriteProductModelFromJson(String str) =>
    FavoriteProductModel.fromJson(json.decode(str));

String favoriteProductModelToJson(FavoriteProductModel data) => json.encode(data.toJson());

class FavoriteProductModel {
  FavoriteProductModel({
    this.status,
    this.code,
    this.response,
  });

  bool status;
  int code;
  List<FavoriteProduct> response;

  factory FavoriteProductModel.fromJson(Map<String, dynamic> json) => FavoriteProductModel(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : int.parse(json["code"].toString()),
        response: json["response"] == null
            ? null
            : List<FavoriteProduct>.from(json["response"].map((x) => FavoriteProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "response": response == null ? null : List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class FavoriteProduct {
  FavoriteProduct({
    this.name,
    this.price,
    this.checkoutView,
    this.order,
    this.revenue,
    this.group,
    this.templateImage,
  });

  String name;
  String price;
  String checkoutView;
  String order;
  String revenue;
  String group;
  String templateImage;

  factory FavoriteProduct.fromJson(Map<String, dynamic> json) => FavoriteProduct(
      name: json["name"] == null ? null : json["name"].toString(),
      price: json["price"] == null ? null : json["price"].toString(),
      checkoutView:
          json["checkout_view"] == null ? null : json["checkout_view"].toString(),
      order: json["order"] == null ? null : json["order"].toString(),
      revenue: json["revenue"] == null ? null : json["revenue"].toString(),
      group: json["group"] == null ? null : json["group"].toString(),
      templateImage: json["template_image"] == null ? null : json["template_image"].toString());

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "price": price == null ? null : price,
        "checkout_view": checkoutView == null ? null : checkoutView,
        "order": order == null ? null : order,
        "revenue": revenue == null ? null : revenue,
        "group": group == null ? null : group,
        "template_image": templateImage == null ? null : templateImage,
      };
}
