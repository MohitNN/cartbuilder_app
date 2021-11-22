// // To parse this JSON data, do
// //
// //     final userProductDetailsModel = userProductDetailsModelFromJson(jsonString);
//
// import 'dart:convert';
//
// UserProductDetailsModel userProductDetailsModelFromJson(String str) =>
//     UserProductDetailsModel.fromJson(json.decode(str));
//
// String userProductDetailsModelToJson(UserProductDetailsModel data) =>
//     json.encode(data.toJson());
//
// class UserProductDetailsModel {
//   UserProductDetailsModel({
//     this.status,
//     this.code,
//     this.product,
//   });
//
//   bool status;
//   int code;
//   Product product;
//
//   factory UserProductDetailsModel.fromJson(Map<String, dynamic> json) =>
//       UserProductDetailsModel(
//         status: json["status"] == null ? null : json["status"],
//         code: json["code"] == null ? null : int.parse(json["code"].toString()),
//         product:
//             json["product"] == null ? null : Product.fromJson(json["product"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status == null ? null : status,
//         "code": code == null ? null : code,
//         "product": product == null ? null : product.toJson(),
//       };
// }
//
// class Product {
//   Product({
//     this.id,
//     this.userId,
//     this.productDetails,
//     this.paymentOptions,
//     this.checkoutDesign,
//     this.checkoutPageUrl,
//     this.ckeckoutCount,
//     this.thumbnailStatus,
//     this.shippingStatus,
//     this.successDesign,
//     this.membershipType,
//     this.advancedPricing,
//   });
//
//   Id id;
//   String userId;
//   ProductDetails productDetails;
//   List<String> paymentOptions;
//   Design checkoutDesign;
//   String checkoutPageUrl;
//   int ckeckoutCount;
//   int thumbnailStatus;
//   int shippingStatus;
//   Design successDesign;
//   String membershipType;
//   String advancedPricing;
//
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["_id"] == null ? null : Id.fromJson(json["_id"]),
//         userId: json["user_id"] == null ? null : json["user_id"].toString(),
//         productDetails: json["product_details"] == null
//             ? null
//             : ProductDetails.fromJson(json["product_details"]),
//         paymentOptions: json["payment_options"] == null
//             ? null
//             : List<String>.from(json["payment_options"].map((x) => x)),
//         checkoutDesign: json["checkout_design"] == null
//             ? null
//             : Design.fromJson(json["checkout_design"]),
//         checkoutPageUrl: json["checkout_page_url"] == null
//             ? null
//             : json["checkout_page_url"].toString(),
//         ckeckoutCount: json["ckeckout_count"] == null
//             ? null
//             : int.parse(json["ckeckout_count"].toString()),
//         thumbnailStatus: json["thumbnail_status"] == null
//             ? null
//             : int.parse(json["thumbnail_status"].toString()),
//         shippingStatus: json["shipping_status"] == null
//             ? null
//             : int.parse(json["shipping_status"].toString()),
//         successDesign: json["success_design"] == null
//             ? null
//             : Design.fromJson(json["success_design"]),
//         membershipType: json["membership_type"] == null
//             ? null
//             : json["membership_type"].toString(),
//         advancedPricing: json["advanced_pricing"].toString(),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "_id": id == null ? null : id.toJson(),
//         "user_id": userId == null ? null : userId,
//         "product_details":
//             productDetails == null ? null : productDetails.toJson(),
//         "payment_options": paymentOptions == null
//             ? null
//             : List<dynamic>.from(paymentOptions.map((x) => x)),
//         "checkout_design":
//             checkoutDesign == null ? null : checkoutDesign.toJson(),
//         "checkout_page_url": checkoutPageUrl == null ? null : checkoutPageUrl,
//         "ckeckout_count": ckeckoutCount == null ? null : ckeckoutCount,
//         "thumbnail_status": thumbnailStatus == null ? null : thumbnailStatus,
//         "shipping_status": shippingStatus == null ? null : shippingStatus,
//         "success_design": successDesign == null ? null : successDesign.toJson(),
//         "membership_type": membershipType == null ? null : membershipType,
//         "advanced_pricing": advancedPricing,
//       };
// }
//
// class Design {
//   Design({
//     this.templateId,
//   });
//
//   int templateId;
//
//   factory Design.fromJson(Map<String, dynamic> json) => Design(
//         templateId: json["template_id"] == null
//             ? null
//             : int.parse(json["template_id"].toString()),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "template_id": templateId == null ? null : templateId,
//       };
// }
//
// class Id {
//   Id({
//     this.oid,
//   });
//
//   String oid;
//
//   factory Id.fromJson(Map<String, dynamic> json) => Id(
//         oid: json["\u0024oid"] == null ? null : json["\u0024oid"].toString(),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "\u0024oid": oid == null ? null : oid,
//       };
// }
//
// class ProductDetails {
//   ProductDetails({
//     this.productName,
//     this.productPrice,
//     this.productDescription,
//     this.addCouponCode,
//     this.productGroupTag,
//   });
//
//   String productName;
//   int productPrice;
//   String productDescription;
//   int addCouponCode;
//   String productGroupTag;
//
//   factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
//         productName: json["product_name"] == null
//             ? null
//             : json["product_name"].toString(),
//         productPrice: json["product_price"] == null
//             ? null
//             : int.parse(json["product_price"].toString()),
//         productDescription: json["product_description"] == null
//             ? null
//             : json["product_description"].toString(),
//         addCouponCode: json["add_coupon_code"] == null
//             ? null
//             : int.parse(json["add_coupon_code"].toString()),
//         productGroupTag: json["product_group_tag"] == null
//             ? null
//             : json["product_group_tag"].toString(),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "product_name": productName == null ? null : productName,
//         "product_price": productPrice == null ? null : productPrice,
//         "product_description":
//             productDescription == null ? null : productDescription,
//         "add_coupon_code": addCouponCode == null ? null : addCouponCode,
//         "product_group_tag": productGroupTag == null ? null : productGroupTag,
//       };
// }
//

// To parse this JSON data, do
//
//     final userProductDetailsModel = userProductDetailsModelFromJson(jsonString);

import 'dart:convert';

UserProductDetailsModel userProductDetailsModelFromJson(String str) =>
    UserProductDetailsModel.fromJson(json.decode(str));

String userProductDetailsModelToJson(UserProductDetailsModel data) =>
    json.encode(data.toJson());

class UserProductDetailsModel {
  UserProductDetailsModel({
    this.status,
    this.code,
    this.product,
  });

  bool status;
  int code;
  Product product;

  factory UserProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      UserProductDetailsModel(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : int.parse(json["code"].toString()),
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "product": product == null ? null : product.toJson(),
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
    this.activeShippingBilling,
    this.isFunnel,
    this.totalOrder,
    this.updatedAt,
    this.createdAt,
    this.membershipType,
    this.typeOfDelivery,
    this.advancedPricing,
    this.successDesign,
    this.originalPrice,
    this.originalPriceStatus,
    this.productUrl,
    this.pricingOptions,
    this.orders,
  });

  String id;
  String userId;
  ProductDetails productDetails;
  List<String> paymentOptions;
  CheckoutDesign checkoutDesign;
  String checkoutPageUrl;
  int ckeckoutCount;
  String addToFunnel;
  int thumbnailStatus;
  int shippingStatus;
  int twoStepForm;
  int requireName;
  int requirePhone;
  int activeShippingBilling;
  bool isFunnel;
  int totalOrder;
  DateTime updatedAt;
  DateTime createdAt;
  String membershipType;
  String typeOfDelivery;
  String advancedPricing;
  CheckoutDesign successDesign;
  String originalPrice;
  String originalPriceStatus;
  String productUrl;
  List<PricingOptionElement> pricingOptions;
  int orders;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"] == null ? null : json["_id"].toString(),
        userId: json["user_id"] == null ? null : json["user_id"].toString(),
        productDetails: json["product_details"] == null
            ? null
            : ProductDetails.fromJson(json["product_details"]),
        paymentOptions: json["payment_options"] == null
            ? null
            : List<String>.from(json["payment_options"].map((x) => x)),
        checkoutDesign: json["checkout_design"] == null
            ? null
            : CheckoutDesign.fromJson(json["checkout_design"]),
        checkoutPageUrl: json["checkout_page_url"] == null
            ? null
            : json["checkout_page_url"].toString(),
        ckeckoutCount: json["ckeckout_count"] == null
            ? null
            : int.parse(json["ckeckout_count"].toString()),
        addToFunnel: json["add_to_funnel"].toString(),
        thumbnailStatus: json["thumbnail_status"] == null
            ? null
            : int.parse(json["thumbnail_status"].toString()),
        shippingStatus: json["shipping_status"] == null
            ? null
            : int.parse(json["shipping_status"].toString()),
        twoStepForm: json["two_step_form"] == null
            ? null
            : int.parse(json["two_step_form"].toString()),
        requireName: json["require_name"] == null
            ? null
            : int.parse(json["require_name"].toString()),
        requirePhone: json["require_phone"] == null
            ? null
            : int.parse(json["require_phone"].toString()),
        activeShippingBilling: json["active_shipping_billing"] == null
            ? null
            : int.parse(json["active_shipping_billing"].toString()),
        isFunnel: json["is_funnel"] == null ? null : json["is_funnel"],
        totalOrder: json["total_order"] == null ? null : json["total_order"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        membershipType: json["membership_type"].toString(),
        typeOfDelivery: json["type_of_delivery"] == null
            ? null
            : json["type_of_delivery"].toString(),
        advancedPricing: json["advanced_pricing"].toString(),
        successDesign: json["success_design"] == null
            ? null
            : CheckoutDesign.fromJson(json["success_design"]),
        productUrl:
            json["product_url"] == null ? null : json["product_url"].toString(),
        originalPrice: json["original_price"] == null
            ? null
            : json["original_price"].toString(),
        originalPriceStatus: json["original_price_status"] == null
            ? null
            : json["original_price_status"].toString(),
        pricingOptions: json["pricing_options"] == null
            ? null
            : List<PricingOptionElement>.from(json["pricing_options"]
                .map((x) => PricingOptionElement.fromJson(x))),
        orders: json["orders"] == null
            ? null
            : int.parse(json["orders"].toString()),
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
        "active_shipping_billing":
            activeShippingBilling == null ? null : activeShippingBilling,
        "is_funnel": isFunnel == null ? null : isFunnel,
        "total_order": totalOrder == null ? null : totalOrder,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "membership_type": membershipType,
        "advanced_pricing": advancedPricing,
        "success_design": successDesign.toJson(),
        "product_url": productUrl == null ? null : productUrl,
        "original_price": originalPrice == null ? null : originalPrice,
        "original_price_status":
            originalPriceStatus == null ? null : originalPriceStatus,
        "pricing_options": pricingOptions == null
            ? null
            : List<dynamic>.from(pricingOptions.map((x) => x.toJson())),
        "orders": orders == null ? null : orders,
      };
}

class CheckoutDesign {
  CheckoutDesign({
    this.templateId,
  });

  int templateId;

  factory CheckoutDesign.fromJson(Map<String, dynamic> json) => CheckoutDesign(
        templateId: json["template_id"] == null
            ? null
            : int.parse(json["template_id"].toString()),
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
  PricingOptionDetails pricingOption;
  String productId;
  int isActive;
  DateTime updatedAt;
  DateTime createdAt;

  factory PricingOptionElement.fromJson(Map<String, dynamic> json) =>
      PricingOptionElement(
        id: json["_id"] == null ? null : json["_id"].toString(),
        pricingOption: json["pricing_option"] == null
            ? null
            : PricingOptionDetails.fromJson(json["pricing_option"]),
        productId:
            json["product_id"] == null ? null : json["product_id"].toString(),
        isActive: json["is_active"] == null
            ? null
            : int.parse(json["is_active"].toString()),
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

class PricingOptionDetails {
  PricingOptionDetails({
    this.type,
    this.price,
    this.trailPeriod,
    this.billingFrequency,
    this.billingFrequencyPrice,
    this.todaysPrice,
    this.pricingName,
    this.trailNumPayments,
    this.processorType,
    this.noOfSplits,
    this.totalPrice,
  });

  String type;
  String price;
  String pricingName;
  int trailPeriod;
  String billingFrequency;
  int billingFrequencyPrice;
  int todaysPrice;
  String trailNumPayments;
  String processorType;
  int noOfSplits;
  int totalPrice;

  factory PricingOptionDetails.fromJson(Map<String, dynamic> json) =>
      PricingOptionDetails(
        type: json["type"] == null ? null : json["type"].toString(),
        price: json["price"].toString(),
        trailPeriod: json["trail_period"] == null
            ? null
            : int.parse(json["trail_period"].toString()),
        pricingName: json["pricing_name"] == null
            ? null
            : json["pricing_name"].toString(),
        billingFrequency: json["billing_frequency"] == null
            ? null
            : json["billing_frequency"].toString(),
        billingFrequencyPrice: json["billing_frequency_price"] == null
            ? null
            : int.parse(json["billing_frequency_price"].toString()),
        todaysPrice: json["todays_price"] == null
            ? null
            : int.parse(json["todays_price"].toString()),
        trailNumPayments: json["trail_num_payments"].toString(),
        processorType: json["processor_type"].toString(),
        noOfSplits: json["no_of_splits"] == null
            ? null
            : int.parse(json["no_of_splits"].toString()),
        totalPrice: json["total_price"] == null
            ? null
            : int.parse(json["total_price"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "price": price,
        "trail_period": trailPeriod == null ? null : trailPeriod,
        "pricing_name": trailPeriod == null ? null : pricingName,
        "billing_frequency": billingFrequency == null ? null : billingFrequency,
        "billing_frequency_price":
            billingFrequencyPrice == null ? null : billingFrequencyPrice,
        "todays_price": todaysPrice == null ? null : todaysPrice,
        "trail_num_payments": trailNumPayments,
        "processor_type": processorType,
        "no_of_splits": noOfSplits == null ? null : noOfSplits,
        "total_price": totalPrice == null ? null : totalPrice,
      };
}

class ProductDetails {
  ProductDetails(
      {this.productName,
      this.productPrice,
      this.productDescription,
      this.productStatus,
      this.addCouponCode,
      this.productImage,
      this.productGroupTag,
      this.productTag});

  String productName;
  String productPrice;
  String productDescription;
  int productStatus;
  int addCouponCode;
  String productImage;
  String productGroupTag;
  String productTag;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        productName: json["product_name"] == null
            ? null
            : json["product_name"].toString(),
        productPrice: json["product_price"] == null
            ? null
            : json["product_price"].toString(),
        productDescription: json["product_description"] == null
            ? null
            : json["product_description"].toString(),
        productStatus: json["product_status"] == null
            ? null
            : int.parse(json["product_status"].toString()),
        addCouponCode: json["add_coupon_code"] == null
            ? null
            : int.parse(json["add_coupon_code"].toString()),
        productImage: json["product_image"].toString(),
        productGroupTag: json["product_group_tag"] == null
            ? null
            : json["product_group_tag"].toString(),
        productTag:
            json["product_tag"] == null ? null : json["product_tag"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "product_name": productName == null ? null : productName,
        "product_price": productPrice == null ? null : productPrice,
        "product_description": productDescription,
        "product_status": productStatus == null ? null : productStatus,
        "add_coupon_code": addCouponCode == null ? null : addCouponCode,
        "product_image": productImage,
        "product_group_tag": productGroupTag == null ? null : productGroupTag,
        "product_tag": productTag == null ? null : productTag,
      };
}
