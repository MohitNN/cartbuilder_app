// To parse this JSON data, do
//
//     final subscriptionsListDataModel = subscriptionsListDataModelFromJson(jsonString);

import 'dart:convert';

SubscriptionsListDataModel subscriptionsListDataModelFromJson(String str) =>
    SubscriptionsListDataModel.fromJson(json.decode(str));

String subscriptionsListDataModelToJson(SubscriptionsListDataModel data) =>
    json.encode(data.toJson());

class SubscriptionsListDataModel {
  SubscriptionsListDataModel({
    this.status,
    this.response,
    this.code,
  });

  String status;
  Response response;
  int code;

  factory SubscriptionsListDataModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionsListDataModel(
        status: json["status"] == null ? null : json["status"].toString(),
        response: json["response"] == null
            ? null
            : Response.fromJson(json["response"]),
        code: json["code"] == null ? null : int.parse(json["code"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "response": response == null ? null : response.toJson(),
        "code": code == null ? null : code,
      };
}

class Response {
  Response({
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
  List<SubscriptionDetail> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;
  int total;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        currentPage: json["current_page"] == null
            ? null
            : int.parse(json["current_page"].toString()),
        data: json["data"] == null
            ? null
            : List<SubscriptionDetail>.from(
                json["data"].map((x) => SubscriptionDetail.fromJson(x))),
        firstPageUrl: json["first_page_url"] == null
            ? null
            : json["first_page_url"].toString(),
        from: json["from"] == null ? null : int.parse(json["from"].toString()),
        lastPage: json["last_page"] == null
            ? null
            : int.parse(json["last_page"].toString()),
        lastPageUrl: json["last_page_url"] == null
            ? null
            : json["last_page_url"].toString(),
        nextPageUrl: json["next_page_url"] == null
            ? null
            : json["next_page_url"].toString(),
        path: json["path"] == null ? null : json["path"].toString(),
        perPage: json["per_page"] == null
            ? null
            : int.parse(json["per_page"].toString()),
        prevPageUrl: json["prev_page_url"].toString(),
        to: json["to"] == null ? null : int.parse(json["to"].toString()),
        total:
            json["total"] == null ? null : int.parse(json["total"].toString()),
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

class SubscriptionDetail {
  SubscriptionDetail({
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
    this.isSubscription,
    this.subscriptionId,
    this.isCancelled,
    this.updatedAt,
    this.createdAt,
  });

  String id;
  String userId;
  String accountId;
  UserDetails userDetails;
  List<ProductDetail> productDetails;
  MembershipDetails membershipDetails;
  String type;
  String status;
  String orderId;
  int totalAmount;
  bool refund;
  String productId;
  int isSubscription;
  String subscriptionId;
  int isCancelled;
  DateTime updatedAt;
  DateTime createdAt;

  factory SubscriptionDetail.fromJson(Map<String, dynamic> json) =>
      SubscriptionDetail(
        id: json["_id"] == null ? null : json["_id"].toString(),
        userId: json["user_id"] == null ? null : json["user_id"].toString(),
        accountId:
            json["account_id"] == null ? null : json["account_id"].toString(),
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
        type: json["type"] == null ? null : json["type"].toString(),
        status: json["status"] == null ? null : json["status"].toString(),
        orderId: json["order_id"] == null ? null : json["order_id"].toString(),
        totalAmount: json["total_amount"] == null
            ? null
            : int.parse(json["total_amount"].toString()),
        refund: json["refund"] == null ? null : json["refund"],
        productId:
            json["product_id"] == null ? null : json["product_id"].toString(),
        isSubscription: json["isSubscription"] == null
            ? null
            : int.parse(json["isSubscription"].toString()),
        subscriptionId: json["subscription_id"] == null
            ? null
            : json["subscription_id"].toString(),
        isCancelled: json["isCancelled"] == null
            ? null
            : int.parse(json["isCancelled"].toString()),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "account_id": accountId == null ? null : accountId,
        "user_details": userDetails == null ? null : userDetails.toJson(),
        "product_details": productDetails == null
            ? null
            : List<dynamic>.from(productDetails.map((x) => x.toJson())),
        "membership_details":
            membershipDetails == null ? null : membershipDetails.toJson(),
        "type": type == null ? null : type,
        "status": status == null ? null : status,
        "order_id": orderId == null ? null : orderId,
        "total_amount": totalAmount == null ? null : totalAmount,
        "refund": refund == null ? null : refund,
        "product_id": productId == null ? null : productId,
        "isSubscription": isSubscription == null ? null : isSubscription,
        "subscription_id": subscriptionId == null ? null : subscriptionId,
        "isCancelled": isCancelled == null ? null : isCancelled,
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
        type: json["type"] == null ? null : json["type"].toString(),
        productMembershipId: json["product_membership_id"] == null
            ? null
            : json["product_membership_id"].toString(),
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

  String productId;
  String price;
  String type;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        productId:
            json["product_id"] == null ? null : json["product_id"].toString(),
        price: json["price"] == null ? null : json["price"].toString(),
        type: json["type"] == null ? null : json["type"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId == null ? null : productId,
        "price": price == null ? null : price,
        "type": type == null ? null : type,
      };
}

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

  String fullName;
  String email;
  String phone;
  String address;
  String city;
  String country;
  String state;
  String zipcode;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        fullName:
            json["full_name"] == null ? null : json["full_name"].toString(),
        email: json["email"] == null ? null : json["email"].toString(),
        phone: json["phone"].toString(),
        address: json["address"] == null ? null : json["address"].toString(),
        city: json["city"] == null ? null : json["city"].toString(),
        country: json["country"] == null ? null : json["country"].toString(),
        state: json["state"] == null ? null : json["state"].toString(),
        zipcode: json["zipcode"] == null ? null : json["zipcode"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName == null ? null : fullName,
        "email": email == null ? null : email,
        "phone": phone,
        "address": address == null ? null : address,
        "city": city == null ? null : city,
        "country": country == null ? null : country,
        "state": state == null ? null : state,
        "zipcode": zipcode == null ? null : zipcode,
      };
}
