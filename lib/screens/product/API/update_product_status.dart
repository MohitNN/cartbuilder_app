import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

Future<bool> updateProductStatusService(String productId) async {
  ProductController productController = Get.put(ProductController());
  productController.isLoading.value = true;
  String liveMode = productController.liveModeSwitch.value ? '/1' : '/0';
  var response = await http.get(
    Uri.parse(
        APIUtils.baseUrl + APIUtils.updateProductStatus + productId + liveMode),
    headers: {
      "Authorization": "Bearer ${authController.userToken.value}",
    },
  );
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["status"] == true) {
      productController.isLoading.value = false;
      getToast(msg: decodedData["response"].toString());
      return true;
    } else {
      productController.isLoading.value = false;

      getToast(msg: "Something went wrong");
      return false;
    }
  } else {
    productController.isLoading.value = false;
    getToast(msg: decodedData["response"] ?? decodedData["message"]);
    return false;
  }
}
