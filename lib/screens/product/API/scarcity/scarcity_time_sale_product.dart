import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/product/API/scarcity/get_scarcity_product.dart';
import 'package:mint_bird_app/screens/time_sales/controller/timesell_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

Future<bool> updateScarTimeSalesProduct(String body) async {
  TimeSellController timeSellController = Get.put(TimeSellController());
  var response = await http.post(
      Uri.parse(APIUtils.baseUrl + APIUtils.updateScarcityTimePro),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      },
      body: {
        "sales": body
      });
  print(body);
  print(response.statusCode);
  print(response.body);
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["status"] == "Success") {
      timeSellController.detailLoader.value = false;
      getToast(msg: "Updated Successfully");
      getScarcityProductService();
      return true;
    } else {
      timeSellController.detailLoader.value = false;
      getToast(msg: "Something went wrong");
      return false;
    }
  } else {
    timeSellController.detailLoader.value = false;
    return false;
  }
}
