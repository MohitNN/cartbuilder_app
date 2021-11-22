import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

getDimeSalesGroupListService() async {
  ProductController productController = Get.put(ProductController());
  productController.isLoading.value = true;
  var response = await http
      .get(Uri.parse(APIUtils.baseUrl + APIUtils.getDimeSalesGroup), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  });

  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["code"] == 200) {
      productController.dimeSalesGroup.clear();
      decodedData["response"].forEach((element) {
        productController.dimeSalesGroup.add({
          "id": element["_id"],
          "name": element["name"],
        });
      });
      productController.selectedDimeSaleGroup.value =
          productController.dimeSalesGroup.first["id"];
      productController.isLoading.value = false;
    } else {
      productController.isLoading.value = false;
    }
  }
}
