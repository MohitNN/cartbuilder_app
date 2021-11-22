import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/downsell/controller/downsell_controller.dart';
import 'package:mint_bird_app/screens/upsell/API/customise/get_upsell_template_customise_data.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

setDownsellTemplate({String upSellDownSellId, int template}) async {
  authController.loading.value = true;
  DownSellController downSellController = Get.put(DownSellController());
  var response = await http.post(
      Uri.parse(APIUtils.baseUrl + APIUtils.updateDownsellTemplate),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      },
      body: {
        // "template": template.toString(),
        "template_id":
            downSellController.selectedCheckoutTemplate.value.toString(),
        "upsell_id": downSellController.downSellId.value
      });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  print(response.statusCode);
  print(response.body);
  if (decodedData["code"] == 200) {
    // getUpSellDownSellTemplateService(type: "upsell");
    await getUpSellCustomiseDataService(template: template.toString());
    getToast(msg: "Changed Successfully");
    authController.loading.value = false;
  } else {
    errorSnackBar("Something went wrong", "Please try again");
    authController.loading.value = false;
  }
}
