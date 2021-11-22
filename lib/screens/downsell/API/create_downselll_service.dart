import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/screens/downsell/controller/downsell_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

import '../../../main.dart';

Future<bool> createDownSellService({String pName, String pPrice}) async {
  DownSellController downsellController = Get.put(DownSellController());

  downsellController.isLoading.value = true;
  var response = await http
      .post(Uri.parse(APIUtils.baseUrl + APIUtils.createDownSell), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  }, body: {
    "downsell_name": pName,
    "downsell_price": pPrice,
    "downsell_custom_url": pName,
    "downsell_group_tag": downsellController.selectedGroup.value
  });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["status"] == true) {
      downsellController.isLoading.value = false;
      Get.back();
      getToast(msg: decodedData["response"]);
      return true;
    } else {
      downsellController.isLoading.value = false;
      getToast(msg: "Something went wrong");
      return false;
    }
  } else {
    downsellController.isLoading.value = false;
    getToast(msg: decodedData["response"] ?? decodedData["message"]);
    return false;
  }
}
