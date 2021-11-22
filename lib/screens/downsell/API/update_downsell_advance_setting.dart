import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/downsell/controller/downsell_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';
import 'package:http/http.dart' as http;


Future<bool> updateDownSellTrackingScriptDetailService({
  @required String downSellId,
  @required String headerScripts,
  @required String footerScripts,
  @required String pixelFooterScripts,
}) async {
  DownSellController downsellController = Get.put(DownSellController());

  downsellController.isLoading.value = true;
  var response = await http
      .post(Uri.parse(APIUtils.baseUrl + APIUtils.downSellTrackingScript), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  }, body: {
    'downsell_id': downSellId,
    'header_scripts': headerScripts,
    'footer_scripts': footerScripts,
    'pixel_footer_scripts': pixelFooterScripts,
  });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["status"] == true) {
      downsellController.isLoading.value = false;
      Get.back();
      getToast(msg: decodedData["response"]);
      return true;
    } else {
      downsellController.isLoading.value = false;
      getToast(msg: "Something went wrong");
      return false;
    }
  } else {
    downsellController.isLoading.value = false;
    getToast(msg: decodedData["response"] ?? decodedData["message"]);
    return false;
  }
}
