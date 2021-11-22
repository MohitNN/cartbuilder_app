import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/funnel/API/get_funnel_proudtcs.dart';
import 'package:mint_bird_app/screens/funnel/controller/funnel_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';

updateFunnelFlow(String upsellId, String downsellId) async {
  FunnelController funnelController = Get.put(FunnelController());
  funnelController.isLoading.value = true;

  Map<String, dynamic> upsellBody = {
    "funnel_id": funnelController.funnelId.value,
    "upsell_id": upsellId,
    "upsell_index": funnelController.newFunnelProductList.length.toString(),
    "type": "upsell"
  };
  Map<String, dynamic> downsellBody = {
    "funnel_id": funnelController.funnelId.value,
    "upsell_id": funnelController.selectedUpsellId.value,
    "upsell_index": funnelController.selectedUpsellIndex.value.toString(),
    "downsell_id": downsellId,
    "type": "downsell"
  };

  var mainBody = downsellId == null ? upsellBody : downsellBody;
  var response = await http.post(
      Uri.parse(
        APIUtils.baseUrl + APIUtils.updateFunnelFlow,
      ),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      },
      body: mainBody);
  print(APIUtils.baseUrl + APIUtils.updateFunnelFlow);
  print({
    "Authorization": "Bearer ${authController.userToken.value}",
  });
  print(response.statusCode);
  print(mainBody);

  if (response.statusCode == 200) {
    funnelController.isLoading.value = false;
    funnelController.isDownsellOpen.value = false;
    funnelController.isUpsellOpen.value = false;
    getFunnelProducts();
  } else {
    funnelController.isLoading.value = false;
    errorSnackBar("Something went wrong", "Please try again!");
  }
}
