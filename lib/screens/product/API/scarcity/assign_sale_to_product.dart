import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/product/API/scarcity/get_scarcity_product.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

assignSaleToProductService() async {
  ProductController productController = Get.put(ProductController());
  DashboardController dashboardController = Get.put(DashboardController());
  dashboardController.isLoading.value = true;
  Map<String, dynamic> timeSaleBody = {
    "id": productController.productId.value,
    "sales": dashboardController.selectedTimeSaleId.value,
    "salesgroup": productController.selectedTimeSaleGroup.value,
    "type": "timesale"
  };
  Map<String, dynamic> dimeSaleBody = {
    "id": productController.productId.value,
    "sales": dashboardController.selectedDimeSaleId.value,
    "salesgroup": productController.selectedDimeSaleGroup.value,
    "type": "dimesale"
  };
  var response = await http.post(
      Uri.parse(APIUtils.baseUrl + APIUtils.assignScarcityProducts),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      },
      body:
          productController.timeDime.value == 0 ? timeSaleBody : dimeSaleBody);
  print(productController.timeDime.value == 0 ? timeSaleBody : dimeSaleBody);
  print(response.statusCode);
  print(response.body);
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (decodedData["status"] == "Success") {
    dashboardController.isLoading.value = false;
    if (decodedData["response"] == 0) {
      errorToast(
          msg:
              "Please configure this ${productController.timeDime.value == 0 ? "time sale" : "dime sale"} first");
    } else {
      getToast(msg: "Added Successfully");
      getScarcityProductService();
      Get.back();
    }
  } else {
    getToast(msg: "Something went wrong");
    dashboardController.isLoading.value = false;
  }
}
