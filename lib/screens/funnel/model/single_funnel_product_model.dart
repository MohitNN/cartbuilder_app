// To parse this JSON data, do
//
//     final singleFunnelProductModel = singleFunnelProductModelFromJson(jsonString);

import 'dart:convert';

SingleFunnelProductModel singleFunnelProductModelFromJson(String str) => SingleFunnelProductModel.fromJson(json.decode(str));

String singleFunnelProductModelToJson(SingleFunnelProductModel data) => json.encode(data.toJson());

class SingleFunnelProductModel {
  SingleFunnelProductModel({
    this.status,
    this.response,
    this.code,
  });

  String status;
  Funnel response;
  int code;

  factory SingleFunnelProductModel.fromJson(Map<String, dynamic> json) => SingleFunnelProductModel(
    status: json["status"] == null ? null : json["status"],
    response: json["response"] == null ? null : Funnel.fromJson(json["response"]),
    code: json["code"] == null ? null : json["code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "response": response == null ? null : response.toJson(),
    "code": code == null ? null : code,
  };
}

class Funnel {
  Funnel({
    this.funnelId,
    this.funnelsProduct,
  });

  String funnelId;
  List<FunnelsProduct1> funnelsProduct;

  factory Funnel.fromJson(Map<String, dynamic> json) => Funnel(
    funnelId: json["funnel_id"] == null ? null : json["funnel_id"],
    funnelsProduct: json["funnels_product"] == null ? null : List<FunnelsProduct1>.from(json["funnels_product"].map((x) => FunnelsProduct1.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "funnel_id": funnelId == null ? null : funnelId,
    "funnels_product": funnelsProduct == null ? null : List<dynamic>.from(funnelsProduct.map((x) => x.toJson())),
  };
}

class FunnelsProduct1 {
  FunnelsProduct1({
    this.upsell,
    this.upsellUrl,
    this.templateId,
    this.downsell,
    this.embedCode,
  });

  String upsell;
  String upsellUrl;
  int templateId;
  List<Downsell> downsell;
  String embedCode;

  factory FunnelsProduct1.fromJson(Map<String, dynamic> json) => FunnelsProduct1(
    upsell: json["upsell"] == null ? null : json["upsell"],
    upsellUrl: json["upsell_url"] == null ? null : json["upsell_url"],
    templateId: json["template_id"] == null ? null : json["template_id"],
    downsell: json["downsell"] == null ? null : List<Downsell>.from(json["downsell"].map((x) => Downsell.fromJson(x))),
    embedCode: json["embed_code"] == null ? null : json["embed_code"],
  );

  Map<String, dynamic> toJson() => {
    "upsell": upsell == null ? null : upsell,
    "upsell_url": upsellUrl == null ? null : upsellUrl,
    "template_id": templateId == null ? null : templateId,
    "downsell": downsell == null ? null : List<dynamic>.from(downsell.map((x) => x.toJson())),
    "embed_code": embedCode == null ? null : embedCode,
  };
}

class Downsell {
  Downsell({
    this.downsell,
    this.downsellUrl,
    this.templateId,
    this.customUrl,
    this.embedCode,
    this.isActive,
  });

  String downsell;
  String downsellUrl;
  int templateId;
  dynamic customUrl;
  String embedCode;
  bool isActive;

  factory Downsell.fromJson(Map<String, dynamic> json) => Downsell(
    downsell: json["downsell"] == null ? null : json["downsell"],
    downsellUrl: json["downsell_url"] == null ? null : json["downsell_url"],
    templateId: json["template_id"] == null ? null : json["template_id"],
    customUrl: json["custom_url"],
    embedCode: json["embed_code"] == null ? null : json["embed_code"],
    isActive: json["is_active"] == null ? null : json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "downsell": downsell == null ? null : downsell,
    "downsell_url": downsellUrl == null ? null : downsellUrl,
    "template_id": templateId == null ? null : templateId,
    "custom_url": customUrl,
    "embed_code": embedCode == null ? null : embedCode,
    "is_active": isActive == null ? null : isActive,
  };
}
