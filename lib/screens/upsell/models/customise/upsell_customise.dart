// To parse this JSON data, do
//
//     final upsellCustomise = upsellCustomiseFromJson(jsonString);

import 'dart:convert';

UpsellCustomise upsellCustomiseFromJson(String str) =>
    UpsellCustomise.fromJson(json.decode(str));

String upsellCustomiseToJson(UpsellCustomise data) =>
    json.encode(data.toJson());

class UpsellCustomise {
  UpsellCustomise({
    this.status,
    this.code,
    this.response,
  });

  bool status;
  int code;
  Response response;

  factory UpsellCustomise.fromJson(Map<String, dynamic> json) =>
      UpsellCustomise(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : json["code"],
        response: json["response"] == null
            ? null
            : Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "response": response == null ? null : response.toJson(),
      };
}

class Response {
  Response({
    this.userId,
    this.funnelId,
    this.upsellDownsellId,
    this.templateCode,
    this.type,
    this.templateId,
    this.modalStatus,
    this.updatedAt,
    this.createdAt,
    this.templateTheme,
    this.id,
  });

  String userId;
  dynamic funnelId;
  String upsellDownsellId;
  TemplateCode templateCode;
  String type;
  var templateId;
  ModalStatus modalStatus;
  DateTime updatedAt;
  DateTime createdAt;
  String templateTheme;
  String id;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        userId: json["user_id"] == null ? null : json["user_id"],
        funnelId: json["funnel_id"],
        upsellDownsellId: json["upsell_downsell_id"] == null
            ? null
            : json["upsell_downsell_id"],
        templateCode: json["template_code"] == null
            ? null
            : TemplateCode.fromJson(json["template_code"]),
        type: json["type"] == null ? null : json["type"],
        templateId: json["template_id"] == null ? null : json["template_id"],
        modalStatus: json["modal_status"] == null
            ? null
            : ModalStatus.fromJson(json["modal_status"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        templateTheme:
            json["template_theme"] == null ? null : json["template_theme"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["_id"] == null ? null : json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "funnel_id": funnelId,
        "upsell_downsell_id":
            upsellDownsellId == null ? null : upsellDownsellId,
        "template_code": templateCode == null ? null : templateCode.toJson(),
        "type": type == null ? null : type,
        "template_id": templateId == null ? null : templateId,
        "modal_status": modalStatus == null ? null : modalStatus.toJson(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "template_theme": templateTheme == null ? null : templateTheme,
        "_id": id == null ? null : id,
      };
}

class ModalStatus {
  var navigationBar;
  int header;
  int video;
  int bullets;
  int oto;
  int thankYou;
  var descriptionText;
  var upgradeText;
  var footerLogo;
  int copyright;
  int waitAMinute;
  int instantButton;
  int specialOffer;
  int centerContent;
  int lifetimeText;
  int timer;
  int oneTimeOnlyOffer;
  int oneTimeImage;

  ModalStatus(
      {this.navigationBar,
      this.header,
      this.video,
      this.bullets,
      this.oto,
      this.thankYou,
      this.descriptionText,
      this.upgradeText,
      this.footerLogo,
      this.copyright,
      this.waitAMinute,
      this.instantButton,
      this.specialOffer,
      this.centerContent,
      this.lifetimeText,
      this.timer,
      this.oneTimeImage,
      this.oneTimeOnlyOffer});

  ModalStatus.fromJson(Map<String, dynamic> json) {
    navigationBar = json['navigation_bar'];
    header = json['header'];
    video = json['video'];
    bullets = json['bullets'];
    oto = json['oto'];
    thankYou = json['thank_you'];
    descriptionText = json['description_text'];
    upgradeText = json['upgrade_text'];
    footerLogo = json['footer_logo'];
    copyright = json['copyright'];
    waitAMinute = json['wait_a_minute'];
    instantButton = json['instant_button'];
    specialOffer = json['special_offer'];
    centerContent = json['center_content'];
    lifetimeText = json['lifetime_text'];
    timer = json['timer'];
    oneTimeOnlyOffer = json['one_time_only_offer'];
    oneTimeImage = json['one_time_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['navigation_bar'] = this.navigationBar;
    data['header'] = this.header;
    data['video'] = this.video;
    data['bullets'] = this.bullets;
    data['oto'] = this.oto;
    data['thank_you'] = this.thankYou;
    data['description_text'] = this.descriptionText;
    data['upgrade_text'] = this.upgradeText;
    data['footer_logo'] = this.footerLogo;
    data['copyright'] = this.copyright;
    data['wait_a_minute'] = this.waitAMinute;
    data['instant_button'] = this.instantButton;
    data['special_offer'] = this.specialOffer;
    data['center_content'] = this.centerContent;
    data['lifetime_text'] = this.lifetimeText;
    data['lifetime_text'] = this.timer;
    data['lifetime_text'] = this.oneTimeImage;
    data['lifetime_text'] = this.oneTimeOnlyOffer;
    return data;
  }
}

class TemplateCode {
  TemplateCode(
      {this.funnelNavigationOne,
      this.funnelHeaderImageOne,
      this.funnelHeaderTextOne,
      this.funnelHeaderOne,
      this.funnelHeaderTwo,
      this.funnelVideoOne,
      this.funnelBullet,
      this.funnelDescriptionTextOne,
      this.funnelOtoButtonOne,
      this.funnelOtoButtonDescriptionOne,
      this.funnelThankyouButtonOne,
      this.funnelUpgradeTextOne,
      this.funnelFooterLogoOne,
      this.funnelCopyrightTextOne,
      this.funnelWaitMinuteTextOne,
      this.funnelInstantButtonOne,
      this.funnelOfferTextOne,
      this.funnelCenterTitleOne,
      this.funnelCenetrDescriptionOne,
      this.funnelLifetimeTextOne,
      this.funnelButtonOne,
      this.funnelButtonTwo,
      this.funnelBulletTitle});

  dynamic funnelNavigationOne;
  dynamic funnelHeaderImageOne;
  dynamic funnelHeaderTextOne;
  String funnelHeaderOne;
  String funnelHeaderTwo;
  String funnelVideoOne;
  List<FunnelBullet> funnelBullet;
  dynamic funnelDescriptionTextOne;
  String funnelOtoButtonOne;
  dynamic funnelOtoButtonDescriptionOne;
  String funnelThankyouButtonOne;
  dynamic funnelUpgradeTextOne;
  dynamic funnelFooterLogoOne;
  dynamic funnelCopyrightTextOne;
  dynamic funnelWaitMinuteTextOne;
  dynamic funnelInstantButtonOne;
  dynamic funnelOfferTextOne;
  dynamic funnelCenterTitleOne;
  dynamic funnelCenetrDescriptionOne;
  dynamic funnelLifetimeTextOne;
  dynamic funnelButtonOne;
  dynamic funnelButtonTwo;
  dynamic funnelBulletTitle;

  factory TemplateCode.fromJson(Map<String, dynamic> json) => TemplateCode(
        funnelNavigationOne: json["funnel_navigation_one"],
        funnelHeaderImageOne: json["funnel_header_image_one"],
        funnelHeaderTextOne: json["funnel_header_text_one"],
        funnelHeaderOne: json["funnel_header_one"] == null
            ? null
            : json["funnel_header_one"],
        funnelHeaderTwo: json["funnel_header_two"] == null
            ? null
            : json["funnel_header_two"],
        funnelVideoOne:
            json["funnel_video_one"] == null ? null : json["funnel_video_one"],
        funnelBullet: json["funnel_bullet"] == null
            ? null
            : List<FunnelBullet>.from(
                json["funnel_bullet"].map((x) => FunnelBullet.fromJson(x))),
        funnelDescriptionTextOne: json["funnel_description_text_one"],
        funnelOtoButtonOne: json["funnel_oto_button_one"] == null
            ? null
            : json["funnel_oto_button_one"],
        funnelOtoButtonDescriptionOne:
            json["funnel_oto_button_description_one"],
        funnelThankyouButtonOne: json["funnel_thankyou_button_one"] == null
            ? null
            : json["funnel_thankyou_button_one"],
        funnelUpgradeTextOne: json["funnel_upgrade_text_one"] == null
            ? null
            : json["funnel_upgrade_text_one"],
        funnelFooterLogoOne: json["funnel_footer_logo_one"] == null
            ? null
            : json["funnel_footer_logo_one"],
        funnelCopyrightTextOne: json["funnel_copyright_text_one"] == null
            ? null
            : json["funnel_copyright_text_one"],
        funnelWaitMinuteTextOne: json["funnel_wait_minute_text_one"] == null
            ? null
            : json["funnel_wait_minute_text_one"],
        funnelInstantButtonOne: json["funnel_instant_button_one"] == null
            ? null
            : json["funnel_instant_button_one"],
        funnelOfferTextOne: json["funnel_offer_text_one"] == null
            ? null
            : json["funnel_offer_text_one"],
        funnelCenterTitleOne: json["funnel_center_title_one"] == null
            ? null
            : json["funnel_center_title_one"],
        funnelCenetrDescriptionOne:
            json["funnel_cenetr_description_one"] == null
                ? null
                : json["funnel_cenetr_description_one"],
        funnelLifetimeTextOne: json["funnel_lifetime_text_one"] == null
            ? null
            : json["funnel_lifetime_text_one"],
        funnelButtonOne: json["funnel_button_one"] == null
            ? null
            : json["funnel_button_one"],
        funnelButtonTwo: json["funnel_button_two"] == null
            ? null
            : json["funnel_button_two"],
        funnelBulletTitle: json["funnel_bullet_title"] == null
            ? null
            : json["funnel_bullet_title"],
      );

  Map<String, dynamic> toJson() => {
        "funnel_navigation_one": funnelNavigationOne,
        "funnel_header_image_one": funnelHeaderImageOne,
        "funnel_header_text_one": funnelHeaderTextOne,
        "funnel_header_one": funnelHeaderOne == null ? null : funnelHeaderOne,
        "funnel_header_two": funnelHeaderTwo == null ? null : funnelHeaderTwo,
        "funnel_video_one": funnelVideoOne == null ? null : funnelVideoOne,
        "funnel_bullet": funnelBullet == null
            ? null
            : List<dynamic>.from(funnelBullet.map((x) => x.toJson())),
        "funnel_description_text_one": funnelDescriptionTextOne,
        "funnel_oto_button_one":
            funnelOtoButtonOne == null ? null : funnelOtoButtonOne,
        "funnel_oto_button_description_one": funnelOtoButtonDescriptionOne,
        "funnel_thankyou_button_one":
            funnelThankyouButtonOne == null ? null : funnelThankyouButtonOne,
        "funnel_upgrade_text_one":
            funnelUpgradeTextOne == null ? null : funnelUpgradeTextOne,
        "funnel_footer_logo_one":
            funnelFooterLogoOne == null ? null : funnelFooterLogoOne,
        "funnel_copyright_text_one":
            funnelCopyrightTextOne == null ? null : funnelCopyrightTextOne,
        "funnel_wait_minute_text_one":
            funnelWaitMinuteTextOne == null ? null : funnelWaitMinuteTextOne,
        "funnel_instant_button_one":
            funnelInstantButtonOne == null ? null : funnelInstantButtonOne,
        "funnel_offer_text_one":
            funnelOfferTextOne == null ? null : funnelOfferTextOne,
        "funnel_center_title_one":
            funnelCenterTitleOne == null ? null : funnelCenterTitleOne,
        "funnel_cenetr_description_one": funnelCenetrDescriptionOne == null
            ? null
            : funnelCenetrDescriptionOne,
        "funnel_lifetime_text_one":
            funnelLifetimeTextOne == null ? null : funnelLifetimeTextOne,
        "funnel_button_one": funnelButtonOne == null ? null : funnelButtonOne,
        "funnel_button_two": funnelButtonTwo == null ? null : funnelButtonTwo,
        "funnel_bullet_title":
            funnelBulletTitle == null ? null : funnelBulletTitle,
      };
}

class FunnelBullet {
  FunnelBullet({
    this.image,
    this.title,
    this.description,
  });

  String image;
  String title;
  String description;

  factory FunnelBullet.fromJson(Map<String, dynamic> json) => FunnelBullet(
        image: json["image"] == null ? null : json["image"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "image": image == null ? null : image,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
      };
}
