import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/dime_sales/models/dime_sales_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

getUserDimeSalesService() async {
  DashboardController dashboardController = Get.put(DashboardController());
  dashboardController.isLoading.value = true;
  var response = await http.get(
      Uri.parse(APIUtils.baseUrl +
          APIUtils.getDimeSales +
          "${dashboardController.searchQuery.value.length > 0 ? "?search=${dashboardController.searchQuery.value}" : ""}" +
          "${dashboardController.currentPage.value == 1 && dashboardController.searchQuery.value.length > 0 ? "" : "?page=${dashboardController.currentPage.value}"}"),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (decodedData["code"] == 200) {
    DimeSalesModel dimeSalesModel = DimeSalesModel.fromJson(decodedData);
    dashboardController.lastPage.value = dimeSalesModel.lastPage;
    dashboardController.currentPage.value =
        dashboardController.currentPage.value + 1;
    dimeSalesModel.upsells.forEach((element) {
      dashboardController.listOfDimeSale.add(element);
    });
    dashboardController.isLoading.value = false;
    dashboardController.bottomLoader.value = false;
  } else {
    dashboardController.isLoading.value = false;
    dashboardController.bottomLoader.value = false;
  }
}

getUserAllDimeSalesService() async {
  DashboardController dashboardController = Get.put(DashboardController());
  dashboardController.isLoading.value = true;
  var response = await http
      .get(Uri.parse(APIUtils.baseUrl + APIUtils.getAllDimeSales), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (decodedData["code"] == 200) {
    DimeSalesModel dimeSalesModel = DimeSalesModel.fromJson(decodedData);
    dimeSalesModel.upsells.forEach((element) {
      dashboardController.listOfDimeSale.add(element);
    });
    dashboardController.isLoading.value = false;
  } else {
    dashboardController.isLoading.value = false;
  }
}
