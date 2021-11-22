import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

getProductGroupService() async {
  ProductController productController = Get.put(ProductController());
  productController.isLoading.value = true;
  var response = await http
      .get(Uri.parse(APIUtils.baseUrl + APIUtils.getProductGroup), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  });

  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["code"] == 200) {
      productController.productGroup.clear();
      decodedData["response"].forEach((element) {
        productController.productGroup.add({
          "id": element["_id"],
          "name": element["name"],
        });
      });
      productController.selectedGroup.value =
          productController.productGroup.first["id"];
      productController.isLoading.value = false;
    } else {
      productController.isLoading.value = false;
    }
  }
}
