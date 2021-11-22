// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

TransactionModel transactionModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) =>
    json.encode(data.toJson());

class TransactionModel {
  TransactionModel({
    this.status,
    this.code,
    this.data,
  });

  bool status;
  int code;
  Data data;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.orders,
    this.checkouts,
    this.revenue,
    this.records,
  });

  int orders;
  int checkouts;
  int revenue;
  Records records;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orders: json["orders"] == null ? null : json["orders"],
        checkouts: json["checkouts"] == null ? null : json["checkouts"],
        revenue: json["revenue"] == null ? null : json["revenue"],
        records:
            json["records"] == null ? null : Records.fromJson(json["records"]),
      );

  Map<String, dynamic> toJson() => {
        "orders": orders == null ? null : orders,
        "checkouts": checkouts == null ? null : checkouts,
        "revenue": revenue == null ? null : revenue,
        "records": records == null ? null : records.toJson(),
      };
}

class Records {
  Records({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Record> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Records.fromJson(Map<String, dynamic> json) => Records(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<Record>.from(json["data"].map((x) => Record.fromJson(x))),
        firstPageUrl:
            json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl:
            json["last_page_url"] == null ? null : json["last_page_url"],
        nextPageUrl:
            json["next_page_url"] == null ? null : json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage == null ? null : currentPage,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "last_page_url": lastPageUrl == null ? null : lastPageUrl,
        "next_page_url": nextPageUrl == null ? null : nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}

class Record {
  Record({
    this.id,
    this.userId,
    this.accountId,
    this.userDetails,
    this.productDetails,
    this.membershipDetails,
    this.type,
    this.status,
    this.orderId,
    this.totalAmount,
    this.refund,
    this.productId,
    this.updatedAt,
    this.createdAt,
  });

  String id;
  UserId userId;
  String accountId;
  UserDetails userDetails;
  List<ProductDetail> productDetails;
  MembershipDetails membershipDetails;
  String type;
  String status;
  String orderId;
  dynamic totalAmount;
  bool refund;
  ProductId productId;
  DateTime updatedAt;
  DateTime createdAt;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json["_id"] == null ? null : json["_id"],
        userId:
            json["user_id"] == null ? null : userIdValues.map[json["user_id"]],
        accountId: json["account_id"] == null ? null : json["account_id"],
        userDetails: json["user_details"] == null
            ? null
            : UserDetails.fromJson(json["user_details"]),
        productDetails: json["product_details"] == null
            ? null
            : List<ProductDetail>.from(
                json["product_details"].map((x) => ProductDetail.fromJson(x))),
        membershipDetails: json["membership_details"] == null
            ? null
            : MembershipDetails.fromJson(json["membership_details"]),
        type: json["type"] == null ? null : json["type"],
        status:
            json["status"] == null ? null : json["status"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        totalAmount: json["total_amount"],
        refund: json["refund"] == null ? null : json["refund"],
        productId: json["product_id"] == null
            ? null
            : productIdValues.map[json["product_id"]],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "user_id": userId == null ? null : userIdValues.reverse[userId],
        "account_id": accountId == null ? null : accountId,
        "user_details": userDetails == null ? null : userDetails.toJson(),
        "product_details": productDetails == null
            ? null
            : List<dynamic>.from(productDetails.map((x) => x.toJson())),
        "membership_details":
            membershipDetails == null ? null : membershipDetails.toJson(),
        "type": type == null ? null : type,
        "status": status == null ? null : statusValues.reverse[status],
        "order_id": orderId == null ? null : orderId,
        "total_amount": totalAmount,
        "refund": refund == null ? null : refund,
        "product_id":
            productId == null ? null : productIdValues.reverse[productId],
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
      };
}

class MembershipDetails {
  MembershipDetails({
    this.type,
    this.productMembershipId,
  });

  String type;
  String productMembershipId;

  factory MembershipDetails.fromJson(Map<String, dynamic> json) =>
      MembershipDetails(
        type: json["type"] == null ? null : json["type"],
        productMembershipId: json["product_membership_id"] == null
            ? null
            : json["product_membership_id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "product_membership_id":
            productMembershipId == null ? null : productMembershipId,
      };
}

class ProductDetail {
  ProductDetail({
    this.productId,
    this.price,
    this.type,
  });

  ProductId productId;
  String price;
  Type type;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        productId: json["product_id"] == null
            ? null
            : productIdValues.map[json["product_id"]],
        price: json["price"] == null ? null : json["price"],
        type: json["type"] == null ? null : typeValues.map[json["type"]],
      );

  Map<String, dynamic> toJson() => {
        "product_id":
            productId == null ? null : productIdValues.reverse[productId],
        "price": price == null ? null : price,
        "type": type == null ? null : typeValues.reverse[type],
      };
}

enum ProductId {
  THE_60_F5_F6_C32_A9_B2772_A56_ADFB2,
  THE_60_F83_C44_AEA9_FB05_DF005_CA3
}

final productIdValues = EnumValues({
  "60f5f6c32a9b2772a56adfb2": ProductId.THE_60_F5_F6_C32_A9_B2772_A56_ADFB2,
  "60f83c44aea9fb05df005ca3": ProductId.THE_60_F83_C44_AEA9_FB05_DF005_CA3
});

enum Type { PRODUCT }

final typeValues = EnumValues({"product": Type.PRODUCT});

enum Status { REFUNDED, EMPTY }

final statusValues =
    EnumValues({"": Status.EMPTY, "Refunded": Status.REFUNDED});

class UserDetails {
  UserDetails({
    this.fullName,
    this.email,
    this.phone,
    this.address,
    this.city,
    this.country,
    this.state,
    this.zipcode,
  });

  dynamic fullName;
  String email;
  dynamic phone;
  dynamic address;
  dynamic city;
  dynamic country;
  dynamic state;
  dynamic zipcode;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        fullName: json["full_name"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"],
        address: json["address"],
        city: json["city"],
        country: json["country"],
        state: json["state"],
        zipcode: json["zipcode"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "email": email == null ? null : email,
        "phone": phone,
        "address": address,
        "city": city,
        "country": country,
        "state": state,
        "zipcode": zipcode,
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
