import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/screens/product/models/scarcity/scarcity_products_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

getScarcityProductService() async {
  ProductController productController = Get.put(ProductController());
  productController.isLoading.value = true;
  var response = await http
      .post(Uri.parse(APIUtils.baseUrl + APIUtils.scarcityProducts), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  }, body: {
    "product_id": productController.productId.value
  });
  print(response.statusCode);
  print(response.body);
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (decodedData["status"] == "Success") {
    productController.scarcityModel.value =
        ScarcityProductsModel.fromJson(decodedData);
    productController.isLoading.value = false;
  } else {
    productController.isLoading.value = false;
  }
}
