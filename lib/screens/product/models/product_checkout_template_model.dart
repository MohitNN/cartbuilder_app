// To parse this JSON data, do
//
//     final checkOutTemplateModel = checkOutTemplateModelFromJson(jsonString);

import 'dart:convert';

ProductCheckOutTemplateModel checkOutTemplateModelFromJson(String str) =>
    ProductCheckOutTemplateModel.fromJson(json.decode(str));

String checkOutTemplateModelToJson(ProductCheckOutTemplateModel data) =>
    json.encode(data.toJson());

class ProductCheckOutTemplateModel {
  ProductCheckOutTemplateModel({
    this.status,
    this.response,
  });

  bool status;
  Response response;

  factory ProductCheckOutTemplateModel.fromJson(Map<String, dynamic> json) =>
      ProductCheckOutTemplateModel(
        status: json["status"] == null ? null : json["status"],
        response: json["response"] == null
            ? null
            : Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "response": response == null ? null : response.toJson(),
      };
}

class Response {
  Response({
    this.id,
    this.productId,
    this.userId,
    this.templateCode,
    this.modalStatus,
    this.updatedAt,
    this.createdAt,
    this.templateTheme,
  });

  String id;
  String productId;
  String userId;
  TemplateCode templateCode;
  ModalStatus modalStatus;
  DateTime updatedAt;
  DateTime createdAt;
  String templateTheme;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        id: json["_id"] == null ? null : json["_id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        templateCode: json["template_code"] == null
            ? null
            : TemplateCode.fromJson(json["template_code"]),
        modalStatus: json["modal_status"] == null
            ? null
            : ModalStatus.fromJson(json["modal_status"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        templateTheme:
            json["template_theme"] == null ? null : json["template_theme"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "product_id": productId == null ? null : productId,
        "user_id": userId == null ? null : userId,
        "template_code": templateCode == null ? null : templateCode.toJson(),
        "modal_status": modalStatus == null ? null : modalStatus.toJson(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "template_theme": templateTheme == null ? null : templateTheme,
      };
}

class ModalStatus {
  ModalStatus({
    this.navigationBar,
    this.cartHeader,
    this.seals,
    this.image,
    this.formHeader,
    this.bulletPoints,
    this.offerBox,
    this.testimonial,
    this.video,
    this.badges,
    this.productTextButton,
    this.textButton,
    this.coverImage,
    this.headerImage,
  });

  var navigationBar;
  var cartHeader;
  var seals;
  var image;
  var formHeader;
  var bulletPoints;
  var offerBox;
  var testimonial;
  var video;
  var badges;
  String productTextButton;
  String textButton;
  String coverImage;
  var headerImage;

  factory ModalStatus.fromJson(Map<String, dynamic> json) => ModalStatus(
        navigationBar:
            json["navigation_bar"] == null ? null : json["navigation_bar"],
        cartHeader: json["cart_header"] == null ? null : json["cart_header"],
        seals: json["seals"] == null ? null : json["seals"],
        image: json["image"] == null ? null : json["image"],
        formHeader: json["form_header"] == null ? null : json["form_header"],
        bulletPoints:
            json["bullet_points"] == null ? null : json["bullet_points"],
        offerBox: json["offer_box"] == null ? null : json["offer_box"],
        testimonial: json["testimonial"] == null ? null : json["testimonial"],
        video: json["video"],
        badges: json["badges"] == null ? null : json["badges"],
        productTextButton: json["product_text_button"] == null
            ? null
            : json["product_text_button"],
        textButton: json["text_button"] == null ? null : json["text_button"],
        coverImage: json["cover_image"],
        headerImage: json["header_image"],
      );

  Map<String, dynamic> toJson() => {
        "navigation_bar": navigationBar == null ? null : navigationBar,
        "cart_header": cartHeader == null ? null : cartHeader,
        "seals": seals == null ? null : seals,
        "image": image == null ? null : image,
        "form_header": formHeader == null ? null : formHeader,
        "bullet_points": bulletPoints == null ? null : bulletPoints,
        "offer_box": offerBox == null ? null : offerBox,
        "testimonial": testimonial == null ? null : testimonial,
        "video": video,
        "badges": badges == null ? null : badges,
        "product_text_button":
            productTextButton == null ? null : productTextButton,
        "text_button": textButton == null ? null : textButton,
        "cover_image": coverImage,
        "header_image": headerImage,
      };
}

class TemplateCode {
  TemplateCode({
    this.productTitle,
    this.productDescription,
    this.productLabelImageOne,
    this.productLabelOne,
    this.productLabelImageTwo,
    this.productLabelTwo,
    this.productLabelImageThree,
    this.productLabelThree,
    this.productImage,
    this.productFormHeaderOne,
    this.productFormHeaderTwo,
    this.productBumpOfferLabel,
    this.productBumpOfferTitle,
    this.productBumpOfferDescription,
    this.productList,
    this.productClientTestimonial,
    this.productVideoOne,
    this.productVideoTwo,
    this.productVideoThree,
    this.productBadgeOne,
    this.productBadgeTwo,
    this.productBadgeThree,
    this.navigationImage,
    this.productTextButton,
    this.textButton,
  });

  String productTitle;
  String productDescription;
  String productLabelImageOne;
  String productLabelOne;
  String productLabelImageTwo;
  String productLabelTwo;
  dynamic productLabelImageThree;
  dynamic productLabelThree;
  String productImage;
  dynamic productFormHeaderOne;
  dynamic productFormHeaderTwo;
  dynamic productBumpOfferLabel;
  dynamic productBumpOfferTitle;
  dynamic productBumpOfferDescription;
  List<dynamic> productList;
  List<ProductClientTestimonial> productClientTestimonial;
  dynamic productVideoOne;
  dynamic productVideoTwo;
  dynamic productVideoThree;
  String productBadgeOne;
  String productBadgeTwo;
  String productBadgeThree;
  String navigationImage;
  String productTextButton;
  String textButton;

  factory TemplateCode.fromJson(Map<String, dynamic> json) => TemplateCode(
        productTitle:
            json["product_title"] == null ? null : json["product_title"],
        productDescription: json["product_description"] == null
            ? null
            : json["product_description"],
        productLabelImageOne: json["product_label_image_one"] == null
            ? null
            : json["product_label_image_one"],
        productLabelOne: json["product_label_one"] == null
            ? null
            : json["product_label_one"],
        productLabelImageTwo: json["product_label_image_two"] == null
            ? null
            : json["product_label_image_two"],
        productLabelTwo: json["product_label_two"] == null
            ? null
            : json["product_label_two"],
        productLabelImageThree: json["product_label_image_three"],
        productLabelThree: json["product_label_three"],
        productImage:
            json["product_image"] == null ? null : json["product_image"],
        productFormHeaderOne: json["product_form_header_one"],
        productFormHeaderTwo: json["product_form_header_two"],
        productBumpOfferLabel: json["product_bump_offer_label"],
        productBumpOfferTitle: json["product_bump_offer_title"],
        productBumpOfferDescription: json["product_bump_offer_description"],
        productList: json["product_list"] == null
            ? null
            : List<dynamic>.from(json["product_list"].map((x) => x)),
        productClientTestimonial: json["product_client_testimonial"] == null
            ? null
            : List<ProductClientTestimonial>.from(
                json["product_client_testimonial"]
                    .map((x) => ProductClientTestimonial.fromJson(x))),
        productVideoOne: json["product_video_one"],
        productVideoTwo: json["product_video_two"],
        productVideoThree: json["product_video_three"],
        productBadgeOne: json["product_badge_one"] == null
            ? null
            : json["product_badge_one"],
        productBadgeTwo: json["product_badge_two"] == null
            ? null
            : json["product_badge_two"],
        productBadgeThree: json["product_badge_three"] == null
            ? null
            : json["product_badge_three"],
        navigationImage:
            json["navigation_image"] == null ? null : json["navigation_image"],
        productTextButton: json["product_text_button"] == null
            ? null
            : json["product_text_button"],
        textButton: json["text_button"] == null ? null : json["text_button"],
      );

  Map<String, dynamic> toJson() => {
        "product_title": productTitle == null ? null : productTitle,
        "product_description":
            productDescription == null ? null : productDescription,
        "product_label_image_one":
            productLabelImageOne == null ? null : productLabelImageOne,
        "product_label_one": productLabelOne == null ? null : productLabelOne,
        "product_label_image_two":
            productLabelImageTwo == null ? null : productLabelImageTwo,
        "product_label_two": productLabelTwo == null ? null : productLabelTwo,
        "product_label_image_three": productLabelImageThree,
        "product_label_three": productLabelThree,
        "product_image": productImage == null ? null : productImage,
        "product_form_header_one": productFormHeaderOne,
        "product_form_header_two": productFormHeaderTwo,
        "product_bump_offer_label": productBumpOfferLabel,
        "product_bump_offer_title": productBumpOfferTitle,
        "product_bump_offer_description": productBumpOfferDescription,
        "product_list": productList == null
            ? null
            : List<dynamic>.from(productList.map((x) => x)),
        "product_client_testimonial": productClientTestimonial == null
            ? null
            : List<dynamic>.from(
                productClientTestimonial.map((x) => x.toJson())),
        "product_video_one": productVideoOne,
        "product_video_two": productVideoTwo,
        "product_video_three": productVideoThree,
        "product_badge_one": productBadgeOne == null ? null : productBadgeOne,
        "product_badge_two": productBadgeTwo == null ? null : productBadgeTwo,
        "product_badge_three":
            productBadgeThree == null ? null : productBadgeThree,
        "navigation_image": navigationImage == null ? null : navigationImage,
        "product_text_button":
            productTextButton == null ? null : productTextButton,
        "text_button": textButton == null ? null : textButton,
      };
}

class ProductClientTestimonial {
  ProductClientTestimonial({
    this.clientTitle,
    this.clientDescription,
    this.clientImage,
  });

  String clientTitle;
  String clientDescription;
  String clientImage;

  factory ProductClientTestimonial.fromJson(Map<String, dynamic> json) =>
      ProductClientTestimonial(
        clientTitle: json["client_title"] == null ? null : json["client_title"],
        clientDescription: json["client_description"] == null
            ? null
            : json["client_description"],
        clientImage: json["client_image"] == null ? null : json["client_image"],
      );

  Map<String, dynamic> toJson() => {
        "client_title": clientTitle == null ? null : clientTitle,
        "client_description":
            clientDescription == null ? null : clientDescription,
        "client_image": clientImage == null ? null : clientImage,
      };
}
