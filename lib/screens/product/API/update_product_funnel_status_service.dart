import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

import '../../../main.dart';

Future<bool> updateProductFunnelStatusService() async {
  ProductController productController = Get.put(ProductController());
  productController.isLoading.value = true;

  var response =
      await http.post(Uri.parse(APIUtils.baseUrl + APIUtils.updateProductFunnelStatus), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  }, body: {
    "product_id": productController.productId.value,
    "is_funnel": productController.addToFunnelSwitch.value ? '0' : '1',
  });
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
