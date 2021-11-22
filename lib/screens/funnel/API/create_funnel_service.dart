import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/screens/funnel/controller/funnel_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

import '../../../main.dart';

Future<bool> createFunnelService({String pName}) async {
  FunnelController funnelController = Get.put(FunnelController());
  funnelController.isLoading.value = true;
  var response = await http
      .post(Uri.parse(APIUtils.baseUrl + APIUtils.createFunnel), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  }, body: {
    "funnel_name": pName,
    "funnel_group_tag": funnelController.selectedGroup.value
  });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["status"] == true) {
      funnelController.isLoading.value = false;
      Get.back();
      getToast(msg: decodedData["response"]);
      return true;
    } else {
      funnelController.isLoading.value = false;
      getToast(msg: "Something went wrong");
      return false;
    }
  } else {
    funnelController.isLoading.value = false;
    getToast(msg: decodedData["response"] ?? decodedData["message"]);
    return false;
  }
}
