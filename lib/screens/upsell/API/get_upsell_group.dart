import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/upsell/controller/upsell_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

getUpSellGroupService() async {
  UpsellController upsellController = Get.put(UpsellController());
  upsellController.isLoading.value = true;
  var response = await http
      .get(Uri.parse(APIUtils.baseUrl + APIUtils.getUpsellGroup), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  });

  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["code"] == 200) {
      upsellController.upSellGroup.clear();
      decodedData["response"].forEach((element) {
        upsellController.upSellGroup.add({
          "id": element["_id"],
          "name": element["name"],
        });
      });
      upsellController.selectedGroup.value =
          upsellController.upSellGroup.first["name"];
    }
  }
  upsellController.isLoading.value = false;
}
