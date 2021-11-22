import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/time_sales/models/time_sales_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

getUserTimeSalesService() async {
  DashboardController dashboardController = Get.put(DashboardController());
  dashboardController.isLoading.value = true;
  var response = await http.get(
      Uri.parse(APIUtils.baseUrl +
          APIUtils.getTimeSales +
          "${dashboardController.searchQuery.value.length > 0 ? "?search=${dashboardController.searchQuery.value}" : ""}" +
          "${dashboardController.currentPage.value == 1 && dashboardController.searchQuery.value.length > 0 ? "" : "?page=${dashboardController.currentPage.value}"}"),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });
  print(response.statusCode);
  print(response.body);
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (decodedData["code"] == 200) {
    TimeSalesModel timeSalesModel = TimeSalesModel.fromJson(decodedData);
    dashboardController.lastPage.value = timeSalesModel.lastPage;
    dashboardController.currentPage.value =
        dashboardController.currentPage.value + 1;
    timeSalesModel.upsells.forEach((element) {
      dashboardController.listOfTimesell.add(element);
    });
    dashboardController.bottomLoader.value = false;
    dashboardController.isLoading.value = false;
  } else {
    dashboardController.bottomLoader.value = false;
    dashboardController.isLoading.value = false;
  }
}

getUserAllTimeSalesService() async {
  DashboardController dashboardController = Get.put(DashboardController());
  dashboardController.isLoading.value = true;
  var response = await http
      .get(Uri.parse(APIUtils.baseUrl + APIUtils.getTimeSales), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  });
  print(response.statusCode);
  print(response.body);
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (decodedData["code"] == 200) {
    TimeSalesModel timeSalesModel = TimeSalesModel.fromJson(decodedData);
    dashboardController.lastPage.value = timeSalesModel.lastPage;
    dashboardController.currentPage.value =
        dashboardController.currentPage.value + 1;
    timeSalesModel.upsells.forEach((element) {
      dashboardController.listOfTimesell.add(element);
    });
    dashboardController.bottomLoader.value = false;
    dashboardController.isLoading.value = false;
  } else {
    dashboardController.bottomLoader.value = false;
    dashboardController.isLoading.value = false;
  }
}
