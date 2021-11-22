import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/upsell/controller/upsell_customise_controller.dart';
import 'package:mint_bird_app/screens/upsell/models/customise/upsell_customise_data_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

getUpSellCustomiseDataService({String template}) async {
  UpsellCustomiseController uCC = Get.put(UpsellCustomiseController());
  authController.loading.value = true;
  var response = await http.get(
      Uri.parse(
          APIUtils.baseUrl + APIUtils.getTemplateCustomiseData + template),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (decodedData["code"] == 200) {
    uCC.uCData.value =
        UpsellTemplateCustomiseData.fromJson(decodedData).response;
    authController.loading.value = false;
  } else {
    authController.loading.value = false;
  }
}
