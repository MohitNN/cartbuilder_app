// To parse this JSON data, do
//
//     final recentProductModel = recentProductModelFromJson(jsonString);

import 'dart:convert';

RecentProductModel recentProductModelFromJson(String str) =>
    RecentProductModel.fromJson(json.decode(str));

String recentProductModelToJson(RecentProductModel data) =>
    json.encode(data.toJson());

class RecentProductModel {
  RecentProductModel({
    this.status,
    this.code,
    this.response,
  });

  bool status;
  int code;
  List<RecentProducts> response;

  factory RecentProductModel.fromJson(Map<String, dynamic> json) =>
      RecentProductModel(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : json["code"],
        response: json["response"] == null
            ? null
            : List<RecentProducts>.from(
                json["response"].map((x) => RecentProducts.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "response": response == null
            ? null
            : List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class RecentProducts {
  RecentProducts({
    this.id,
    this.userId,
    this.productName,
    this.productDescription,
    this.productPrice,
    this.view,
  });

  String id;
  UserId userId;
  String productName;
  String productDescription;
  dynamic productPrice;
  int view;

  factory RecentProducts.fromJson(Map<String, dynamic> json) => RecentProducts(
        id: json["_id"] == null ? null : json["_id"],
        userId:
            json["user_id"] == null ? null : userIdValues.map[json["user_id"]],
        productName: json["product_name"] == null ? null : json["product_name"],
        productDescription: json["product_description"] == null
            ? null
            : json["product_description"],
        productPrice: json["product_price"],
        view: json["view"] == null ? null : json["view"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "user_id": userId == null ? null : userIdValues.reverse[userId],
        "product_name": productName == null ? null : productName,
        "product_description":
            productDescription == null ? null : productDescription,
        "product_price": productPrice,
        "view": view == null ? null : view,
      };
}

enum UserId { THE_5_F44_E160_BCBD6_F53011_EF502 }

final userIdValues = EnumValues(
    {"5f44e160bcbd6f53011ef502": UserId.THE_5_F44_E160_BCBD6_F53011_EF502});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
