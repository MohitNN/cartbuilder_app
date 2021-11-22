import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/funnel/controller/funnel_controller.dart';
import 'package:mint_bird_app/screens/funnel/model/all_downsell_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

getAllDownsell() async {
  FunnelController funnelController = Get.put(FunnelController());
  authController.loading.value = true;
  var response = await http
      .get(Uri.parse(APIUtils.baseUrl + APIUtils.getAllDownsell), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  });

  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (decodedData["code"] == 200) {
    authController.loading.value = false;
    funnelController.allDownsellModel.value =
        AllDownsellModel.fromJson(decodedData);
  } else {
    authController.loading.value = false;
  }
}
