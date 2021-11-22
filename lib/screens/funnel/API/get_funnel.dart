import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/funnel/model/user_funnel_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

getUserFunnelService() async {
  print("*** FUNNEL");
  DashboardController dashboardController = Get.put(DashboardController());
  dashboardController.isLoading.value = true;
  var response = await http.get(
      Uri.parse(
        APIUtils.baseUrl +
            APIUtils.getFunnel +
            "${dashboardController.searchQuery.value.length > 0 ? "?search=${dashboardController.searchQuery.value}" : ""}" +
            "${dashboardController.currentPage.value == 1 && dashboardController.searchQuery.value.length > 0 ? "" : "${dashboardController.searchQuery.value.length > 0 ? "&" : "?"}page=${dashboardController.currentPage.value}"}",
      ),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });

  Map<String, dynamic> decodedData = jsonDecode(response.body);
  print("*** FUNNEL  $decodedData");
  if (decodedData["code"] == 200) {
    dashboardController.lastPage.value =
        UserFunnelModel.fromJson(decodedData).lastPage;
    UserFunnelModel.fromJson(decodedData).response.forEach((element) {
      dashboardController.listOfFunnel.add(element);
    });
    dashboardController.currentPage.value =
        dashboardController.currentPage.value + 1;
    dashboardController.bottomLoader.value = false;
    dashboardController.isLoading.value = false;
  } else {
    dashboardController.isLoading.value = false;
    dashboardController.bottomLoader.value = false;
  }
}
