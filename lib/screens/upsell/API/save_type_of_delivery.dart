import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

import '../../../main.dart';

Future<bool> saveTypeOfDelivery({String type, String id}) async {
  ProductController productController = Get.put(ProductController());
  productController.isLoading.value = true;
  var response = await http.post(
      Uri.parse(APIUtils.baseUrl + APIUtils.saveTypeOfDelivery),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      },
      body: {
        "type_of_delivery": type,
        productController.productUpSellDownSell.value == 'product'
            ? 'product_id'
            : productController.productUpSellDownSell.value == 'downsell'
                ? "downsell_id"
                : "upsell_id": id,
      });

  Map<String, dynamic> decodedData = jsonDecode(response.body);

  if (response.statusCode == 200) {
    if (decodedData["status"] == "Success") {
      productController.isLoading.value = false;
      getToast(msg: 'Update Successfully');
      return true;
    } else {
      productController.isLoading.value = false;
      getToast(msg: "Something went wrong");
      return false;
    }
  } else {
    productController.isLoading.value = false;
    getToast(msg: "Something went wrong");
    return false;
  }
}
