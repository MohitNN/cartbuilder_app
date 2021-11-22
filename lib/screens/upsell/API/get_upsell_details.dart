import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/upsell/controller/upsell_controller.dart';
import 'package:mint_bird_app/screens/upsell/models/upsell_details_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

Future<UserUpsellDetailsModel> getUpsellDetailsService(String upsellId) async {
  DashboardController dashboardController = Get.put(DashboardController());
  UpsellController upsellController = Get.put(UpsellController());
  print("***  $upsellId");
  var response = await http.get(
      Uri.parse(APIUtils.baseUrl + APIUtils.getUpsellDetails + upsellId),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  print(decodedData);
  if (decodedData["code"] == 200) {
    UserUpsellDetailsModel uS = UserUpsellDetailsModel.fromJson(decodedData);
    upsellController.upSellId.value = uS.upsell.id;
    dashboardController.selectedTagList.value =
        uS.upsell.upsellDetails.upsellTag == null
            ? ""
            : uS.upsell.upsellDetails.upsellTag;
    return uS;
  } else {
    return UserUpsellDetailsModel();
  }
}
