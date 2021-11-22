import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/downsell/models/downsell_details_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

import '../../downsell/controller/downsell_controller.dart';

Future<UserDownSellDetailsModel> getDownSellDetailsService(
    String downSellId) async {
  print("D=-=-= $downSellId");
  DownSellController downSellController = Get.put(DownSellController());
  DashboardController dashboardController = Get.put(DashboardController());
  var response = await http.get(
      Uri.parse(APIUtils.baseUrl + APIUtils.getDownsellDetails + downSellId),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (decodedData["code"] == 200) {
    UserDownSellDetailsModel uS =
        UserDownSellDetailsModel.fromJson(decodedData);
    downSellController.downSellId.value = uS.downsell.id;
    dashboardController.selectedTagList.value =
        uS.downsell.downsellDetails.downsellTag == null
            ? ""
            : uS.downsell.downsellDetails.downsellTag;
    return uS;
  } else {
    return UserDownSellDetailsModel();
  }
}
