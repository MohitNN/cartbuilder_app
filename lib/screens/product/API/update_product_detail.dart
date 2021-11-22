import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

import '../../../widgets/get_toast.dart';
import '../controller/product_controller.dart';

updateProductDetailService({
  @required String productId,
  @required String productName,
  @required String productPrice,
  @required String originalPrice,
  @required String productDescription,
  @required String productCheckoutPageUrl,
  @required File image,
}) async {
  ProductController productController = Get.put(ProductController());
  DashboardController dashboardController = Get.put(DashboardController());
  productController.isLoading.value = true;

  Map<String, String> headers = {
    "Authorization": "Bearer ${authController.userToken.value}",
  };
  var request = http.MultipartRequest(
      "POST", Uri.parse(APIUtils.baseUrl + APIUtils.updateProductDetails))
    ..headers.addAll(headers)
    ..fields['product_id'] = productId.toString()
    ..fields['product_name'] = productName.toString()
    ..fields['product_price'] = productPrice.toString()
    ..fields['checkout_page_url'] = productCheckoutPageUrl.toString()
    ..fields['shipping_status'] =
        productController.disableShippingSwitch.value ? '1' : '0'
    ..fields['active_shipping_billing'] =
        productController.billingShippingFirstSwitch.value ? '1' : '0'
    ..fields['add_coupon_code'] =
        productController.disableShippingSwitch.value ? '1' : '0'
    ..fields['require_name'] = productController.requireName.value ? '1' : '0'
    ..fields['require_phone'] = productController.requirePhone.value ? '1' : '0'
    ..fields['thumbnail_status'] =
        productController.disableThumbnailSwitch.value ? '1' : '0'
    ..fields['original_price_status'] =
        productController.originalPrice.value ? '1' : '0'
    ..fields['original_price'] =
        productController.originalPrice.value ? originalPrice.toString() : '0'
    ..fields['product_description'] = productDescription.toString()
    ..fields['product_group_tag'] =
        productController.selectedGroupId.value.toString()
    ..fields["product_tag"] = dashboardController.selectedTagList.value;
  if (image != null)
    request.files.add(http.MultipartFile(
      'product_image',
      File(image.path).readAsBytes().asStream(),
      File(image.path).lengthSync(),
      filename: image.path.split("/").last,
    ));
  var response = await request.send();
  if (response.statusCode == 200) {
    productController.isLoading.value = false;
    Get.back();
    getToast(msg: "Updated successfully");
  } else {
    productController.isLoading.value = false;
    errorSnackBar("Something went wrong", "Please try again");
  }
}
