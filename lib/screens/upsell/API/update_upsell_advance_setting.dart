import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/upsell/controller/upsell_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';
import 'package:http/http.dart' as http;

Future<bool> updateUpSellTrackingScriptDetailService({
  @required String upSellId,
  @required String headerScripts,
  @required String footerScripts,
  @required String pixelFooterScripts,
}) async {
  UpsellController upSellController = Get.put(UpsellController());

  upSellController.isLoading.value = true;
  var response = await http.post(
      Uri.parse(APIUtils.baseUrl + APIUtils.upSellTrackingScript),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      },
      body: {
        'upsell_id': upSellId,
        'header_scripts': headerScripts,
        'footer_scripts': footerScripts,
        'pixel_footer_scripts': pixelFooterScripts,
      });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["status"] == true) {
      upSellController.isLoading.value = false;
      Get.back();
      getToast(msg: decodedData["response"]);
      return true;
    } else {
      upSellController.isLoading.value = false;
      getToast(msg: "Something went wrong");
      return false;
    }
  } else {
    upSellController.isLoading.value = false;
    getToast(msg: decodedData["response"] ?? decodedData["message"]);
    return false;
  }
}
