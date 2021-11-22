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
import '../controller/downsell_controller.dart';

updateDownSellDetailService({
  @required String downSellId,
  @required String downSellName,
  @required String downSellPrice,
  @required String downSellDescription,
  @required File image,
}) async {
  DownSellController downSellController = Get.put(DownSellController());
  DashboardController dashboardController = Get.put(DashboardController());

  downSellController.isLoading.value = true;

  Map<String, String> headers = {
    "Authorization": "Bearer ${authController.userToken.value}",
  };
  var request = http.MultipartRequest(
      "POST", Uri.parse(APIUtils.baseUrl + APIUtils.updateDownSellDetails))
    ..headers.addAll(headers)
    ..fields['downsell_id'] = downSellId
    ..fields['downsell_name'] = downSellName
    ..fields['downsell_price'] = downSellPrice
    ..fields['downsell_description'] = downSellDescription
    ..fields['thumbnail_status'] =
        downSellController.displayThumbnailSwitch.value ? '1' : '0'
    ..fields['downsell_group_tag'] = downSellController.selectedGroupId.value
    ..fields["downsell_tag"] = dashboardController.selectedTagList.value;
  if (image != null)
    request.files.add(http.MultipartFile(
      'downsell_image',
      File(image.path).readAsBytes().asStream(),
      File(image.path).lengthSync(),
      filename: image.path.split("/").last,
    ));
  var response = await request.send();
  if (response.statusCode == 200) {
    downSellController.isLoading.value = false;
    Get.back();
    getToast(msg: "Updated successfully");
  } else {
    downSellController.isLoading.value = false;
    errorSnackBar("Something went wrong", "Please try again");
  }
}
