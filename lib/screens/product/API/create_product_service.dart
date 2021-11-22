import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

import '../../../main.dart';

Future<bool> createProductService({
  String pName,
  String pPrice,
  String pStatus,
  String pDescription,
  String checkOutPageUrl,
}) async {
  authController.loading.value = true;
  ProductController productController = Get.put(ProductController());
  var response = await http
      .post(Uri.parse(APIUtils.baseUrl + APIUtils.createProduct), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  }, body: {
    "product_name": pName,
    "product_price": pPrice,
    "product_status": pStatus,
    "product_description": pDescription,
    "shipping_status": "1",
    "add_coupon_code": "0",
    "product_group_tag": productController.selectedGroup.value
  });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["status"] == "Success") {
      authController.loading.value = false;
      Get.back();
      getToast(msg: decodedData["response"]);
      return true;
    } else {
      authController.loading.value = false;
      getToast(msg: "Something went wrong");
      return false;
    }
  } else {
    authController.loading.value = false;
    getToast(msg: decodedData["response"] ?? decodedData["message"]);
    return false;
  }
}
