// To parse this JSON data, do
//
//     final userProductModel1 = userProductModel1FromJson(jsonString);

import 'dart:convert';

UserProductModel1 userProductModel1FromJson(String str) =>
    UserProductModel1.fromJson(json.decode(str));

String userProductModel1ToJson(UserProductModel1 data) =>
    json.encode(data.toJson());

class UserProductModel1 {
  UserProductModel1({
    this.status,
    this.code,
    this.products,
  });

  bool status;
  int code;
  Products products;

  factory UserProductModel1.fromJson(Map<String, dynamic> json) =>
      UserProductModel1(
        status: json["status"],
        code: json["code"],
        products: Products.fromJson(json["products"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "products": products.toJson(),
      };
}

class Products {
  Products({
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
  List<Datum> data;
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

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  Datum({
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
    this.updatedAt,
    this.createdAt,
    this.productUrl,
    this.pricingOptions,
    this.orders,
    this.typeOfDelivery,
    this.membershipType,
    this.advancedPricing,
    this.isFunnel,
  });

  String id;
  UserId userId;
  ProductDetails productDetails;
  List<String> paymentOptions;
  CheckoutDesign checkoutDesign;
  String checkoutPageUrl;
  int ckeckoutCount;
  String addToFunnel;
  int thumbnailStatus;
  int shippingStatus;
  DateTime updatedAt;
  DateTime createdAt;
  String productUrl;
  List<PricingOptionElement> pricingOptions;
  int orders;
  String typeOfDelivery;
  String membershipType;
  String advancedPricing;
  bool isFunnel;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        userId: userIdValues.map[json["user_id"]],
        productDetails: ProductDetails.fromJson(json["product_details"]),
        paymentOptions: json["payment_options"] == null
            ? null
            : List<String>.from(json["payment_options"].map((x) => x)),
        checkoutDesign: CheckoutDesign.fromJson(json["checkout_design"]),
        checkoutPageUrl: json["checkout_page_url"],
        ckeckoutCount: json["ckeckout_count"],
        addToFunnel:
            json["add_to_funnel"] == null ? null : json["add_to_funnel"],
        thumbnailStatus: json["thumbnail_status"],
        shippingStatus: json["shipping_status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        productUrl: json["product_url"],
        pricingOptions: List<PricingOptionElement>.from(json["pricing_options"]
            .map((x) => PricingOptionElement.fromJson(x))),
        orders: json["orders"],
        typeOfDelivery:
            json["type_of_delivery"] == null ? null : json["type_of_delivery"],
        membershipType:
            json["membership_type"] == null ? null : json["membership_type"],
        advancedPricing:
            json["advanced_pricing"] == null ? null : json["advanced_pricing"],
        isFunnel: json["is_funnel"] == null ? null : json["is_funnel"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userIdValues.reverse[userId],
        "product_details": productDetails.toJson(),
        "payment_options": paymentOptions == null
            ? null
            : List<dynamic>.from(paymentOptions.map((x) => x)),
        "checkout_design": checkoutDesign.toJson(),
        "checkout_page_url": checkoutPageUrl,
        "ckeckout_count": ckeckoutCount,
        "add_to_funnel": addToFunnel == null ? null : addToFunnel,
        "thumbnail_status": thumbnailStatus,
        "shipping_status": shippingStatus,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "product_url": productUrl,
        "pricing_options":
            List<dynamic>.from(pricingOptions.map((x) => x.toJson())),
        "orders": orders,
        "type_of_delivery": typeOfDelivery == null ? null : typeOfDelivery,
        "membership_type": membershipType == null ? null : membershipType,
        "advanced_pricing": advancedPricing == null ? null : advancedPricing,
        "is_funnel": isFunnel == null ? null : isFunnel,
      };
}

class CheckoutDesign {
  CheckoutDesign({
    this.templateId,
  });

  int templateId;

  factory CheckoutDesign.fromJson(Map<String, dynamic> json) => CheckoutDesign(
        templateId: json["template_id"],
      );

  Map<String, dynamic> toJson() => {
        "template_id": templateId,
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
        id: json["_id"],
        pricingOption:
            PricingOptionPricingOption.fromJson(json["pricing_option"]),
        productId: json["product_id"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "pricing_option": pricingOption.toJson(),
        "product_id": productId,
        "is_active": isActive == null ? null : isActive,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
      };
}

class PricingOptionPricingOption {
  PricingOptionPricingOption({
    this.type,
    this.price,
    this.trailPeriod,
    this.billingFrequency,
    this.billingFrequencyPrice,
    this.todaysPrice,
    this.trailNumPayments,
    this.processorType,
    this.planId,
    this.paypalPlanId,
  });

  Type type;
  String price;
  int trailPeriod;
  String billingFrequency;
  int billingFrequencyPrice;
  int todaysPrice;
  dynamic trailNumPayments;
  dynamic processorType;
  String planId;
  String paypalPlanId;

  factory PricingOptionPricingOption.fromJson(Map<String, dynamic> json) =>
      PricingOptionPricingOption(
        type: typeValues.map[json["type"]],
        price: json["price"] == null ? null : json["price"],
        trailPeriod: json["trail_period"],
        billingFrequency: json["billing_frequency"] == null
            ? null
            : json["billing_frequency"],
        billingFrequencyPrice: json["billing_frequency_price"] == null
            ? null
            : json["billing_frequency_price"],
        todaysPrice: json["todays_price"] == null ? null : json["todays_price"],
        trailNumPayments: json["trail_num_payments"],
        processorType: json["processor_type"],
        planId: json["plan_id"] == null ? null : json["plan_id"],
        paypalPlanId:
            json["paypal_plan_id"] == null ? null : json["paypal_plan_id"],
      );

  Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "price": price == null ? null : price,
        "trail_period": trailPeriod,
        "billing_frequency": billingFrequency == null ? null : billingFrequency,
        "billing_frequency_price":
            billingFrequencyPrice == null ? null : billingFrequencyPrice,
        "todays_price": todaysPrice == null ? null : todaysPrice,
        "trail_num_payments": trailNumPayments,
        "processor_type": processorType,
        "plan_id": planId == null ? null : planId,
        "paypal_plan_id": paypalPlanId == null ? null : paypalPlanId,
      };
}

enum Type { ONE_TIME, SUBSCRIPTION }

final typeValues =
    EnumValues({"one_time": Type.ONE_TIME, "subscription": Type.SUBSCRIPTION});

class ProductDetails {
  ProductDetails({
    this.productName,
    this.productPrice,
    this.productDescription,
    this.productStatus,
    this.addCouponCode,
    this.productImage,
    this.productGroupTag,
    this.checkoutCount,
    this.advancedPayment,
    this.advancedPricing,
  });

  String productName;
  int productPrice;
  String productDescription;
  int productStatus;
  int addCouponCode;
  dynamic productImage;
  ProductGroupTag productGroupTag;
  int checkoutCount;
  int advancedPayment;
  int advancedPricing;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        productName: json["product_name"],
        productPrice: json["product_price"],
        productDescription: json["product_description"] == null
            ? null
            : json["product_description"],
        productStatus: json["product_status"],
        addCouponCode: json["add_coupon_code"],
        productImage: json["product_image"],
        productGroupTag: productGroupTagValues.map[json["product_group_tag"]],
        checkoutCount:
            json["checkout_count"] == null ? null : json["checkout_count"],
        advancedPayment:
            json["advanced_payment"] == null ? null : json["advanced_payment"],
        advancedPricing:
            json["advanced_pricing"] == null ? null : json["advanced_pricing"],
      );

  Map<String, dynamic> toJson() => {
        "product_name": productName,
        "product_price": productPrice,
        "product_description":
            productDescription == null ? null : productDescription,
        "product_status": productStatus,
        "add_coupon_code": addCouponCode,
        "product_image": productImage,
        "product_group_tag": productGroupTagValues.reverse[productGroupTag],
        "checkout_count": checkoutCount == null ? null : checkoutCount,
        "advanced_payment": advancedPayment == null ? null : advancedPayment,
        "advanced_pricing": advancedPricing == null ? null : advancedPricing,
      };
}

enum ProductGroupTag {
  THE_608_ACB13241_B1876663_A0_B92,
  THE_609_D6728436_C83570679_D362,
  THE_60_A5_EB52_CC29511_D7_A790_A82
}

final productGroupTagValues = EnumValues({
  "608acb13241b1876663a0b92": ProductGroupTag.THE_608_ACB13241_B1876663_A0_B92,
  "609d6728436c83570679d362": ProductGroupTag.THE_609_D6728436_C83570679_D362,
  "60a5eb52cc29511d7a790a82": ProductGroupTag.THE_60_A5_EB52_CC29511_D7_A790_A82
});

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
