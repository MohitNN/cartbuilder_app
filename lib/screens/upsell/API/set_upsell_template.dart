import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/upsell/API/customise/get_upsell_template_customise_data.dart';
import 'package:mint_bird_app/screens/upsell/controller/upsell_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

setUpSellTemplate({String upSellDownSellId, int template}) async {
  authController.loading.value = true;
  UpsellController upsellController = Get.put(UpsellController());
  var response = await http.post(
      Uri.parse(APIUtils.baseUrl + APIUtils.updateUpsSellTemplate),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      },
      body: {
        "template_id":
            upsellController.selectedCheckoutTemplate.value.toString(),
        "upsell_id": upsellController.upSellId.value
      });
  Map<String, dynamic> decodedData = jsonDecode(response.body);

  if (decodedData["code"] == 200) {
    await getUpSellCustomiseDataService(template: template.toString());
    getToast(msg: "Changed Successfully");
    authController.loading.value = false;
  } else {
    errorSnackBar("Something went wrong", "Please try again");
    authController.loading.value = false;
  }
}
