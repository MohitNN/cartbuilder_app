import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

updateTwoStepForm(int status) async {
  ProductController productController = Get.put(ProductController());
  productController.isLoading.value = true;
  var response = await http
      .post(Uri.parse(APIUtils.baseUrl + APIUtils.updateTwoStepForm), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  }, body: {
    "product_id": productController.productId.value,
    "status": status.toString()
  });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  print('**++--**++--**++-- $decodedData');
  if (response.statusCode == 200) {
    if (decodedData["status"] == "Success") {
      productController.isLoading.value = false;
      productController.twoStepForm.value = status;
      getToast(msg: "Updated Successfully");
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
