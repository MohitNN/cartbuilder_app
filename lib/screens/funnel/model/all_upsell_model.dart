// To parse this JSON data, do
//
//     final allUpsellModel = allUpsellModelFromJson(jsonString);

import 'dart:convert';

AllUpsellModel allUpsellModelFromJson(String str) =>
    AllUpsellModel.fromJson(json.decode(str));

String allUpsellModelToJson(AllUpsellModel data) => json.encode(data.toJson());

class AllUpsellModel {
  AllUpsellModel({
    this.status,
    this.code,
    this.response,
  });

  bool status;
  int code;
  List<Response> response;

  factory AllUpsellModel.fromJson(Map<String, dynamic> json) => AllUpsellModel(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : json["code"],
        response: json["response"] == null
            ? null
            : List<Response>.from(
                json["response"].map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "response": response == null
            ? null
            : List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class Response {
  Response({
    this.upsellId,
    this.upsellName,
    this.upsellPrice,
  });

  String upsellId;
  String upsellName;
  dynamic upsellPrice;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        upsellId: json["upsell_id"] == null ? null : json["upsell_id"],
        upsellName: json["upsell_name"] == null ? null : json["upsell_name"],
        upsellPrice: json["upsell_price"],
      );

  Map<String, dynamic> toJson() => {
        "upsell_id": upsellId == null ? null : upsellId,
        "upsell_name": upsellName == null ? null : upsellName,
        "upsell_price": upsellPrice,
      };
}
