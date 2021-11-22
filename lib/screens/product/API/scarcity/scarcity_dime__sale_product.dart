import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dime_sales/controller/dime_sell_controller.dart';
import 'package:mint_bird_app/screens/product/API/scarcity/get_scarcity_product.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

Future<bool> updateScarDimeSalesProducts(String body) async {
  DimeSellController dimeSellController = Get.put(DimeSellController());
  var response = await http.post(
      Uri.parse(APIUtils.baseUrl + APIUtils.updateScarcityDimePro),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      },
      body: {
        "sales": body
      });
  print("HELLO : ${response.statusCode}");
  print("HELLO : ${response.body}");
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["status"] == "Success") {
      dimeSellController.detailLoader.value = false;
      getToast(msg: "Updated Successfully");
      getScarcityProductService();
      return true;
    } else {
      dimeSellController.detailLoader.value = false;
      getToast(msg: "Something went wrong");
      return false;
    }
  } else {
    dimeSellController.detailLoader.value = false;
    return false;
  }
}
