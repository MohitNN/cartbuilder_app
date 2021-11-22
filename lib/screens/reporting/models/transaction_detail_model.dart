// To parse this JSON data, do
//
//     final transactionDetailModel = transactionDetailModelFromJson(jsonString);

import 'dart:convert';

TransactionDetailModel transactionDetailModelFromJson(String str) =>
    TransactionDetailModel.fromJson(json.decode(str));

String transactionDetailModelToJson(TransactionDetailModel data) =>
    json.encode(data.toJson());

class TransactionDetailModel {
  TransactionDetailModel({
    this.status,
    this.data,
    this.code,
  });

  bool status;
  Data data;
  int code;

  factory TransactionDetailModel.fromJson(Map<String, dynamic> json) =>
      TransactionDetailModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : data.toJson(),
        "code": code == null ? null : code,
      };
}

class Data {
  Data({
    this.transaction,
    this.products,
    this.user,
  });

  Transaction transaction;
  List<Product> products;
  User user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        transaction: json["transaction"] == null
            ? null
            : Transaction.fromJson(json["transaction"]),
        products: json["products"] == null
            ? null
            : List<Product>.from(
                json["products"].map((x) => Product.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "transaction": transaction == null ? null : transaction.toJson(),
        "products": products == null
            ? null
            : List<dynamic>.from(products.map((x) => x.toJson())),
        "user": user == null ? null : user.toJson(),
      };
}

class Product {
  Product({
    this.id,
    this.userId,
    this.productDetails,
    this.paymentOptions,
    this.checkoutDesign,
    this.checkoutPageUrl,
    this.ckeckoutCount,
    this.addToFunnel,
    this.thumbnailStatus,
    this.shippingStatus,
    this.twoStepForm,
    this.requireName,
    this.requirePhone,
    this.isFunnel,
    this.totalOrder,
    this.updatedAt,
    this.createdAt,
    this.totalAmount,
    this.typeOfDelivery,
    this.successDesign,
    this.advanceSettings,
    this.productUrl,
    this.pricingOptions,
    this.orders,
  });

  String id;
  String userId;
  ProductDetails productDetails;
  List<String> paymentOptions;
  Design checkoutDesign;
  String checkoutPageUrl;
  int ckeckoutCount;
  dynamic addToFunnel;
  int thumbnailStatus;
  int shippingStatus;
  int twoStepForm;
  int requireName;
  int requirePhone;
  bool isFunnel;
  int totalOrder;
  DateTime updatedAt;
  DateTime createdAt;
  int totalAmount;
  dynamic typeOfDelivery;
  Design successDesign;
  AdvanceSettings advanceSettings;
  String productUrl;
  List<PricingOptionElement> pricingOptions;
  int orders;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"] == null ? null : json["_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        productDetails: json["product_details"] == null
            ? null
            : ProductDetails.fromJson(json["product_details"]),
        paymentOptions: json["payment_options"] == null
            ? null
            : List<String>.from(json["payment_options"].map((x) => x)),
        checkoutDesign: json["checkout_design"] == null
            ? null
            : Design.fromJson(json["checkout_design"]),
        checkoutPageUrl: json["checkout_page_url"] == null
            ? null
            : json["checkout_page_url"],
        ckeckoutCount:
            json["ckeckout_count"] == null ? null : json["ckeckout_count"],
        addToFunnel: json["add_to_funnel"],
        thumbnailStatus:
            json["thumbnail_status"] == null ? null : json["thumbnail_status"],
        shippingStatus:
            json["shipping_status"] == null ? null : json["shipping_status"],
        twoStepForm:
            json["two_step_form"] == null ? null : json["two_step_form"],
        requireName: json["require_name"] == null ? null : json["require_name"],
        requirePhone:
            json["require_phone"] == null ? null : json["require_phone"],
        isFunnel: json["is_funnel"] == null ? null : json["is_funnel"],
        totalOrder: json["total_order"] == null ? null : json["total_order"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        totalAmount: json["total_amount"] == null ? null : json["total_amount"],
        typeOfDelivery: json["type_of_delivery"],
        successDesign: json["success_design"] == null
            ? null
            : Design.fromJson(json["success_design"]),
        advanceSettings: json["advance_settings"] == null
            ? null
            : AdvanceSettings.fromJson(json["advance_settings"]),
        productUrl: json["product_url"] == null ? null : json["product_url"],
        pricingOptions: json["pricing_options"] == null
            ? null
            : List<PricingOptionElement>.from(json["pricing_options"]
                .map((x) => PricingOptionElement.fromJson(x))),
        orders: json["orders"] == null ? null : json["orders"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "product_details":
            productDetails == null ? null : productDetails.toJson(),
        "payment_options": paymentOptions == null
            ? null
            : List<dynamic>.from(paymentOptions.map((x) => x)),
        "checkout_design":
            checkoutDesign == null ? null : checkoutDesign.toJson(),
        "checkout_page_url": checkoutPageUrl == null ? null : checkoutPageUrl,
        "ckeckout_count": ckeckoutCount == null ? null : ckeckoutCount,
        "add_to_funnel": addToFunnel,
        "thumbnail_status": thumbnailStatus == null ? null : thumbnailStatus,
        "shipping_status": shippingStatus == null ? null : shippingStatus,
        "two_step_form": twoStepForm == null ? null : twoStepForm,
        "require_name": requireName == null ? null : requireName,
        "require_phone": requirePhone == null ? null : requirePhone,
        "is_funnel": isFunnel == null ? null : isFunnel,
        "total_order": totalOrder == null ? null : totalOrder,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "total_amount": totalAmount == null ? null : totalAmount,
        "type_of_delivery": typeOfDelivery,
        "success_design": successDesign == null ? null : successDesign.toJson(),
        "advance_settings":
            advanceSettings == null ? null : advanceSettings.toJson(),
        "product_url": productUrl == null ? null : productUrl,
        "pricing_options": pricingOptions == null
            ? null
            : List<dynamic>.from(pricingOptions.map((x) => x.toJson())),
        "orders": orders == null ? null : orders,
      };
}

class AdvanceSettings {
  AdvanceSettings({
    this.headerScripts,
    this.footerScripts,
    this.pixelFooterScripts,
  });

  String headerScripts;
  String footerScripts;
  String pixelFooterScripts;

  factory AdvanceSettings.fromJson(Map<String, dynamic> json) =>
      AdvanceSettings(
        headerScripts:
            json["header_scripts"] == null ? null : json["header_scripts"],
        footerScripts:
            json["footer_scripts"] == null ? null : json["footer_scripts"],
        pixelFooterScripts: json["pixel_footer_scripts"] == null
            ? null
            : json["pixel_footer_scripts"],
      );

  Map<String, dynamic> toJson() => {
        "header_scripts": headerScripts == null ? null : headerScripts,
        "footer_scripts": footerScripts == null ? null : footerScripts,
        "pixel_footer_scripts":
            pixelFooterScripts == null ? null : pixelFooterScripts,
      };
}

class Design {
  Design({
    this.templateId,
  });

  int templateId;

  factory Design.fromJson(Map<String, dynamic> json) => Design(
        templateId: json["template_id"] == null ? null : json["template_id"],
      );

  Map<String, dynamic> toJson() => {
        "template_id": templateId == null ? null : templateId,
      };
}

class PricingOptionElement {
  PricingOptionElement({
    this.id,
    this.pricingOption,
    this.productId,
    this.isActive,
    this.updatedAt,
    this.createdAt,
  });

  String id;
  PricingOptionPricingOption pricingOption;
  String productId;
  int isActive;
  DateTime updatedAt;
  DateTime createdAt;

  factory PricingOptionElement.fromJson(Map<String, dynamic> json) =>
      PricingOptionElement(
        id: json["_id"] == null ? null : json["_id"],
        pricingOption: json["pricing_option"] == null
            ? null
            : PricingOptionPricingOption.fromJson(json["pricing_option"]),
        productId: json["product_id"] == null ? null : json["product_id"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "pricing_option": pricingOption == null ? null : pricingOption.toJson(),
        "product_id": productId == null ? null : productId,
        "is_active": isActive == null ? null : isActive,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
      };
}

class PricingOptionPricingOption {
  PricingOptionPricingOption({
    this.type,
    this.price,
    this.trailPeriod,
  });

  String type;
  String price;
  int trailPeriod;

  factory PricingOptionPricingOption.fromJson(Map<String, dynamic> json) =>
      PricingOptionPricingOption(
        type: json["type"] == null ? null : json["type"],
        price: json["price"] == null ? null : json["price"],
        trailPeriod: json["trail_period"] == null ? null : json["trail_period"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "price": price == null ? null : price,
        "trail_period": trailPeriod == null ? null : trailPeriod,
      };
}

class ProductDetails {
  ProductDetails({
    this.productName,
    this.productPrice,
    this.productDescription,
    this.productStatus,
    this.addCouponCode,
    this.productImage,
    this.productGroupTag,
  });

  String productName;
  int productPrice;
  String productDescription;
  int productStatus;
  int addCouponCode;
  String productImage;
  String productGroupTag;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        productName: json["product_name"] == null ? null : json["product_name"],
        productPrice:
            json["product_price"] == null ? null : json["product_price"],
        productDescription: json["product_description"] == null
            ? null
            : json["product_description"],
        productStatus:
            json["product_status"] == null ? null : json["product_status"],
        addCouponCode:
            json["add_coupon_code"] == null ? null : json["add_coupon_code"],
        productImage:
            json["product_image"] == null ? null : json["product_image"],
        productGroupTag: json["product_group_tag"] == null
            ? null
            : json["product_group_tag"],
      );

  Map<String, dynamic> toJson() => {
        "product_name": productName == null ? null : productName,
        "product_price": productPrice == null ? null : productPrice,
        "product_description":
            productDescription == null ? null : productDescription,
        "product_status": productStatus == null ? null : productStatus,
        "add_coupon_code": addCouponCode == null ? null : addCouponCode,
        "product_image": productImage == null ? null : productImage,
        "product_group_tag": productGroupTag == null ? null : productGroupTag,
      };
}

class Transaction {
  Transaction({
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
  DateTime updatedAt;
  DateTime createdAt;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["_id"] == null ? null : json["_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
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
        status: json["status"] == null ? null : json["status"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        totalAmount: json["total_amount"] == null ? null : json["total_amount"],
        refund: json["refund"] == null ? null : json["refund"],
        productId: json["product_id"] == null ? null : json["product_id"],
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

  String productId;
  String price;
  String type;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        productId: json["product_id"] == null ? null : json["product_id"],
        price: json["price"] == null ? null : json["price"],
        type: json["type"] == null ? null : json["type"],
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

class User {
  User({
    this.id,
    this.accountType,
    this.username,
    this.name,
    this.email,
    this.phone,
    this.updatedAt,
    this.createdAt,
    this.address,
    this.businessName,
    this.lastLoginDate,
    this.loginCount,
    this.profilePic,
    this.accessLevelId,
    this.accessLevelName,
    this.userTypeId,
    this.userTypeName,
    this.isgetstart,
  });

  String id;
  String accountType;
  String username;
  String name;
  String email;
  int phone;
  DateTime updatedAt;
  DateTime createdAt;
  String address;
  String businessName;
  DateTime lastLoginDate;
  int loginCount;
  String profilePic;
  String accessLevelId;
  String accessLevelName;
  String userTypeId;
  String userTypeName;
  int isgetstart;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"] == null ? null : json["_id"],
        accountType: json["account_type"] == null ? null : json["account_type"],
        username: json["username"] == null ? null : json["username"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        address: json["address"] == null ? null : json["address"],
        businessName:
            json["business_name"] == null ? null : json["business_name"],
        lastLoginDate: json["last_login_date"] == null
            ? null
            : DateTime.parse(json["last_login_date"]),
        loginCount: json["login_count"] == null ? null : json["login_count"],
        profilePic: json["profile_pic"] == null ? null : json["profile_pic"],
        accessLevelId:
            json["access_level_id"] == null ? null : json["access_level_id"],
        accessLevelName: json["access_level_name"] == null
            ? null
            : json["access_level_name"],
        userTypeId: json["user_type_id"] == null ? null : json["user_type_id"],
        userTypeName:
            json["user_type_name"] == null ? null : json["user_type_name"],
        isgetstart: json["isgetstart"] == null ? null : json["isgetstart"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "account_type": accountType == null ? null : accountType,
        "username": username == null ? null : username,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "address": address == null ? null : address,
        "business_name": businessName == null ? null : businessName,
        "last_login_date":
            lastLoginDate == null ? null : lastLoginDate.toIso8601String(),
        "login_count": loginCount == null ? null : loginCount,
        "profile_pic": profilePic == null ? null : profilePic,
        "access_level_id": accessLevelId == null ? null : accessLevelId,
        "access_level_name": accessLevelName == null ? null : accessLevelName,
        "user_type_id": userTypeId == null ? null : userTypeId,
        "user_type_name": userTypeName == null ? null : userTypeName,
        "isgetstart": isgetstart == null ? null : isgetstart,
      };
}
