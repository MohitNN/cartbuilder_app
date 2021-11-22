import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/product/API/get_product_bump_offer.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

Future<bool> createBumpOfferService(
    {String groupId, String bumpId, String productId}) async {
  ProductController productController = Get.put(ProductController());
  productController.isDialogLoading.value = true;
  var response = await http
      .post(Uri.parse(APIUtils.baseUrl + APIUtils.createBumpOffer), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  }, body: {
    'bump_group_id': groupId,
    'bump_id': bumpId,
    'product_id': productId,
  });

  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["status"] == true) {
      productController.isLoading.value = false;
      Get.back();
      getToast(msg: 'Bump Offer Added Successfully');
      getProductBumpOfferService(productId);
      return true;
    } else {
      productController.isLoading.value = false;
      getToast(msg: "Something went wrong");
      return false;
    }
  } else {
    productController.isLoading.value = false;
    return false;
  }
}
