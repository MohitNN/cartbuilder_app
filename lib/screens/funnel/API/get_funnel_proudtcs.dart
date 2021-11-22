import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/funnel/controller/funnel_controller.dart';
import 'package:mint_bird_app/screens/funnel/model/single_funnel_product_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

getFunnelProducts() async {
  print("START");
  FunnelController funnelController = Get.put(FunnelController());
  funnelController.isLoading.value = true;
  var response = await http.get(
      Uri.parse(APIUtils.baseUrl +
          APIUtils.getFunnelProducts +
          "/${funnelController.funnelId.value}"),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["code"] == 200) {
      funnelController.newFunnelProductList.clear();
      List<FunnelsProduct1> proData =
          SingleFunnelProductModel.fromJson(decodedData)
              .response
              .funnelsProduct;
      if (proData != null) {
        funnelController.newFunnelProductList.value = proData;
        proData.forEach((element) {
          funnelController.existingFunnelUpsells.add(element.upsell);
        });
        proData.forEach((element) {
          if (element.downsell != null) {
            element.downsell.forEach((element1) {
              funnelController.existingFunnelDownsell.add(element1.downsell);
            });
          }
        });
      }

      funnelController.isLoading.value = false;
    } else {
      funnelController.isLoading.value = false;
    }
  }
  print("END");
}
