import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/screens/upsell/controller/upsell_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

import '../../../main.dart';

Future<bool> createUpSellService({String pName, String pPrice}) async {
  UpsellController upsellController = Get.put(UpsellController());
  upsellController.isLoading.value = true;
  var response = await http
      .post(Uri.parse(APIUtils.baseUrl + APIUtils.createUpSell), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  }, body: {
    "upsell_name": pName,
    "upsell_price": pPrice,
    "upsell_custom_url": pName,
    "upsell_group_tag": upsellController.selectedGroup.value
  });

  Map<String, dynamic> decodedData = jsonDecode(response.body);

  if (response.statusCode == 200) {
    if (decodedData["status"] == true) {
      upsellController.isLoading.value = false;
      Get.back();
      getToast(msg: decodedData["response"]);
      return true;
    } else {
      upsellController.isLoading.value = false;
      getToast(msg: "Something went wrong");
      return false;
    }
  } else {
    upsellController.isLoading.value = false;
    getToast(msg: decodedData["response"] ?? decodedData["message"]);
    return false;
  }
}
