import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../main.dart';
import '../../../../utils/api_utils.dart';
import '../../../../widgets/get_toast.dart';
import '../../controller/payment_options_controller.dart';
import '../../controller/product_controller.dart';

Future<bool> createUpdateOnetimePricingOptionService(
    {@required String createUpdate, String pricingOptionId = ''}) async {
  authController.loading.value = true;
  ProductController productController = Get.put(ProductController());

  var response = await http.post(
    Uri.parse(APIUtils.baseUrl + ((createUpdate == 'Edit')
        ? APIUtils.updateOnetimePricingOption
        : APIUtils.createOnetimePricingOption)),
    headers: {
      "Authorization": "Bearer ${authController.userToken.value}",
    },
    body: {
      "product_id": productController.productId.value,
      "price": paymentOptionsController.productPrice.value,
      "trail_period": paymentOptionsController.selectedTrailPeriod.value,
      "pricing_name": paymentOptionsController.pricingName.value,
      "type": 'one_time',
      "processor_type": '',
      "trail_type": paymentOptionsController.selectedTrailType.value,
      "trail_number": paymentOptionsController.trailNumber.value,
      if (createUpdate == 'Edit') "pricing_option_id": pricingOptionId,
    },
  );
  Map<String, dynamic> decodedData = jsonDecode(response.body);

  if (response.statusCode == 200) {
    if (decodedData["status"].toString() == "true") {
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
