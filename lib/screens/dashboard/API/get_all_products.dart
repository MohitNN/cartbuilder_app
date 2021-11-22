import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/dashboard/model/all_products_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

getAllProductsService() async {
  DashboardController dashboardController = Get.put(DashboardController());
  dashboardController.isLoading.value = true;
  var response = await http.get(
    Uri.parse(APIUtils.baseUrl + APIUtils.getAllProduct),
    headers: {
      "Authorization": "Bearer ${authController.userToken.value}",
    },
  );
  print("HHH ::: ${response.statusCode}");
  print("HHH ::: ${response.body}");
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (decodedData["code"] == 200) {
    dashboardController.allProducts.value = [
      AllProduct(id: "0", productName: "Select Product")
    ];
    AllProductsModel allProductsModel = AllProductsModel.fromJson(decodedData);
    allProductsModel.response.forEach((element) {
      dashboardController.allProducts.add(element);
    });
    dashboardController.isLoading.value = false;
  } else {
    dashboardController.isLoading.value = false;
  }
}
