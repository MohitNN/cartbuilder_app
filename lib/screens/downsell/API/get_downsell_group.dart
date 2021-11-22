import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/downsell/controller/downsell_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

getDownSellGroupService() async {
  DownSellController downsellController = Get.put(DownSellController());
  downsellController.isLoading.value = true;
  var response = await http
      .get(Uri.parse(APIUtils.baseUrl + APIUtils.getDownSellGroup), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  });

  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["code"] == 200) {
      downsellController.downSellGroup.clear();
      decodedData["response"].forEach((element) {
        downsellController.downSellGroup.add({
          "id": element["_id"],
          "name": element["name"],
        });
      });
      downsellController.selectedGroup.value =
          downsellController.downSellGroup.first["id"];
      downsellController.isLoading.value = false;
    } else {
      downsellController.isLoading.value = false;
    }
  }
}
