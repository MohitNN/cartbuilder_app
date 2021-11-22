import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

Future<bool> createDimeSalesService({String dimeSalesName}) async {
  ProductController productController = Get.put(ProductController());
  DashboardController dashboardController = Get.put(DashboardController());
  productController.isLoading.value = true;

  var response = await http
      .post(Uri.parse(APIUtils.baseUrl + APIUtils.createDimeSale), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  }, body: {
    'dimesale_name': dimeSalesName,
    'dimesale_group_tag': productController.selectedDimeSaleGroup.value,
  });

  print(response.statusCode);
  print(response.body);
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["status"] == "Success") {
      dashboardController.listOfDimeSale.clear();
      productController.isLoading.value = false;
      Get.back();
      return true;
    } else {
      productController.isLoading.value = false;
      getToast(msg: "Something went wrong");
      return false;
    }
  } else {
    productController.isLoading.value = false;
    return false;
  }
}
