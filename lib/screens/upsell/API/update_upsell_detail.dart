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
import '../controller/upsell_controller.dart';

updateUpSellDetailService({
  @required String upSellId,
  @required String upSellName,
  @required String upSellPrice,
  @required String upSellDescription,
  @required File image,
}) async {
  UpsellController upSellController = Get.put(UpsellController());
  DashboardController dashboardController = Get.put(DashboardController());
  upSellController.isLoading.value = true;

  print(upSellController.selectedGroupId.value);
  Map<String, String> headers = {
    "Authorization": "Bearer ${authController.userToken.value}",
  };
  var request = http.MultipartRequest(
      "POST", Uri.parse(APIUtils.baseUrl + APIUtils.updateUpSellDetails))
    ..headers.addAll(headers)
    ..fields['upsell_id'] = upSellId
    ..fields['upsell_name'] = upSellName
    ..fields['upsell_price'] = upSellPrice
    ..fields['upsell_description'] = upSellDescription
    ..fields['thumbnail_status'] =
        upSellController.displayThumbnailSwitch.value ? '1' : '0'
    ..fields['upsell_group_tag'] = upSellController.selectedGroupId.value
    ..fields["upsell_tag"] = dashboardController.selectedTagList.value;
  if (image != null)
    request.files.add(http.MultipartFile(
      'upsell_image',
      File(image.path).readAsBytes().asStream(),
      File(image.path).lengthSync(),
      filename: image.path.split("/").last,
    ));
  var response = await request.send();
  if (response.statusCode == 200) {
    upSellController.isLoading.value = false;
    Get.back();
    getToast(msg: "Updated successfully");
  } else {
    upSellController.isLoading.value = false;
    errorSnackBar("Something went wrong", "Please try again");
  }
}
