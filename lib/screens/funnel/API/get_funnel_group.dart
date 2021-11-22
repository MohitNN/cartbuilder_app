import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/funnel/controller/funnel_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

getFunnelGroupService() async {
  FunnelController funnelController = Get.put(FunnelController());
  funnelController.isLoading.value = true;
  authController.loading.value = true;
  var response = await http
      .get(Uri.parse(APIUtils.baseUrl + APIUtils.getFunnelGroup), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["code"] == 200) {
      funnelController.funnelGroup.clear();
      decodedData["response"].forEach((element) {
        funnelController.funnelGroup.add({
          "id": element["_id"],
          "name": element["name"],
        });
      });
      funnelController.selectedGroup.value =
          funnelController.funnelGroup.first["id"];
      funnelController.isLoading.value = false;
      authController.loading.value = false;
    } else {
      authController.loading.value = false;
      funnelController.isLoading.value = false;
    }
  }
}
