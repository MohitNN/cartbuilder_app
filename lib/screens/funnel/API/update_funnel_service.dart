import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/funnel/controller/funnel_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

updateFunnelService(
    {String name, String checkoutUrl, @required File image}) async {
  FunnelController funnelController = Get.put(FunnelController());
  DashboardController dashboardController = Get.put(DashboardController());
  funnelController.isLoading.value = true;
  Map<String, String> headers = {
    "Authorization": "Bearer ${authController.userToken.value}",
  };

  var request = http.MultipartRequest(
      "POST", Uri.parse(APIUtils.baseUrl + APIUtils.updateFunnel))
    ..headers.addAll(headers)
    ..fields['funnel_name'] = name
    ..fields['checkout_page_url'] = checkoutUrl
    ..fields['id'] = funnelController.funnelId.value
    ..fields['thumbnail_status'] =
        funnelController.thumbnailSwitch.value ? '1' : '0'
    ..fields['funnel_group_tag '] = funnelController.selectedGroup.value
    ..fields["funnel_tag"] = dashboardController.selectedTagList.value;

  if (image != null)
    request.files.add(http.MultipartFile(
      'funnel_image',
      File(image.path).readAsBytes().asStream(),
      File(image.path).lengthSync(),
      filename: image.path.split("/").last,
    ));

  var response = await request.send();

  if (response.statusCode == 200) {
    funnelController.isLoading.value = false;
    Get.back();
    getToast(msg: "Updated successfully");
  } else {
    funnelController.isLoading.value = false;
    errorSnackBar("Something went wrong", "Please try again");
  }
}

// import 'dart:convert';
//
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:mint_bird_app/main.dart';
// import 'package:mint_bird_app/screens/funnel/controller/funnel_controller.dart';
// import 'package:mint_bird_app/utils/api_utils.dart';
// import 'package:mint_bird_app/widgets/app_snackbars.dart';
// import 'package:mint_bird_app/widgets/get_toast.dart';
//
// updateFunnelService({String name, String checkoutUrl}) async {
//   FunnelController funnelController = Get.put(FunnelController());
//   funnelController.isLoading.value = true;
//   var response = await http
//       .post(Uri.parse(APIUtils.baseUrl + APIUtils.updateFunnel), headers: {
//     "Authorization": "Bearer ${authController.userToken.value}",
//   }, body: {
//     "funnel_name": name,
//     "checkout_page_url": checkoutUrl,
//     "id": funnelController.funnelId.value,
//   });
//   print({
//     "funnel_name": name,
//     "checkout_page_url": checkoutUrl,
//     "id": funnelController.funnelId.value
//   });
//   Map<String, dynamic> decodedData = jsonDecode(response.body);
//
//   if (response.statusCode == 200) {
//     if (decodedData["code"] == 200) {
//       funnelController.isLoading.value = false;
//       Get.back();
//       getToast(msg: "Updated successfully");
//     } else {
//       funnelController.isLoading.value = false;
//       errorSnackBar("Something went wrong", "Please try again");
//     }
//   } else {
//     funnelController.isLoading.value = false;
//     errorSnackBar("Something went wrong", "Please try again");
//   }
// }
