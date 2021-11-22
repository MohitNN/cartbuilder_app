import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/screens/bump_offers/controller/bump_offer_controller.dart';
import 'package:mint_bird_app/screens/bump_offers/models/bump_offer_detail_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

import '../../../main.dart';

Future<BumpOfferDetailDataModel> getBumpOfferDetail(String bumpOfferId) async {
  print("BUMP OFFER ID : $bumpOfferId");
  BumpOfferController bumpOfferController = Get.put(BumpOfferController());
  bumpOfferController.isLoading.value = true;
  var response = await http.get(
      Uri.parse(APIUtils.baseUrl + APIUtils.getBumpOfferDetail + bumpOfferId),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (decodedData["code"] == 200) {
    bumpOfferController.isLoading.value = false;
    String borderType = BumpOfferDetailDataModel.fromJson(decodedData)
        .response
        .templateCode
        .borderType;
    bumpOfferController.boxBorderWidth.value = borderType == "solid"
        ? 0.0
        : borderType == "dotted"
            ? 5.0
            : 8.0;
    return BumpOfferDetailDataModel.fromJson(decodedData);
  } else {
    bumpOfferController.isLoading.value = false;
    return BumpOfferDetailDataModel();
  }
}
