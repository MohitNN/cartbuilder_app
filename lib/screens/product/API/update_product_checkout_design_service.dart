import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

import '../../../main.dart';

Future<bool> updateProductCheckoutDesignService({
  String pId,
  String tId,
}) async {
  authController.loading.value = true;
  var response = await http.post(
      Uri.parse(APIUtils.baseUrl + APIUtils.updateCheckoutDesign),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      },
      body: {
        "product_id": pId,
        "template": tId,
      });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["status"] == true) {
      authController.loading.value = false;
      getToast(msg: "Template changed successfully");
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
