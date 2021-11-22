import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/screens/funnel/controller/funnel_controller.dart';
import 'package:mint_bird_app/screens/upsell/API/get_user_upsell.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

import '../../../main.dart';
import 'get_funnel.dart';

Future addUpsellFunnelProducts(
    {@required String upsellId,
    @required int upsellIndex,
    String downSellId}) async {
  FunnelController funnelController = Get.put(FunnelController());
  print(
      '---${funnelController.funnelId.value} ::: $upsellId ::: $upsellIndex ::: $downSellId');
  funnelController.isLoading.value = true;
  Map<String, String> headers = {
    "Authorization": "Bearer ${authController.userToken.value}",
  };

  Map map = {
    'funnel_id': funnelController.funnelId.value,
    'upsell_id': upsellId,
    'upsell_index': (downSellId == null)
        ? upsellIndex.toString()
        : (upsellIndex - 1).toString(),
    'type': (downSellId == null) ? 'upsell' : 'downsell',
    'downsell_id': (downSellId == null) ? '' : downSellId,
  };

  var response = await http.post(
    Uri.parse(APIUtils.baseUrl + APIUtils.updateFunnelProducts),
    headers: headers,
    body: map,
  );

  if (response.statusCode == 200) {
    await getUserFunnelService();
    funnelController.isLoading.value = false;
    // Get.back();
    getUserUpSellService();
    getToast(msg: "Updated successfully");
  } else {
    funnelController.isLoading.value = false;
    errorSnackBar("Something went wrong", "Please try again");
  }
}
