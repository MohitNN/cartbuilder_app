import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/screens/product/models/user_product_details.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

Future<UserProductDetailsModel> getUserProductDetailsService(
    String productId) async {
  print("-**-/*-/ PRODUCT");
  ProductController productController = Get.put(ProductController());
  var response = await http.get(
      Uri.parse(APIUtils.baseUrl + APIUtils.getProductDetails + productId),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (decodedData["code"] == 200) {
    productController.twoStepForm.value =
        UserProductDetailsModel.fromJson(decodedData).product.twoStepForm;
    return UserProductDetailsModel.fromJson(decodedData);
  } else {
    return UserProductDetailsModel();
  }
}