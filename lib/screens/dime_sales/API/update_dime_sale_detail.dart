import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dime_sales/API/update_dime_sale_products.dart';
import 'package:mint_bird_app/screens/dime_sales/controller/dime_sell_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

Future<bool> updateDimeSalesDetail({String productBody}) async {
  DimeSellController dimeSellController = Get.put(DimeSellController());
  dimeSellController.detailLoader.value = true;
  var response = await http
      .post(Uri.parse(APIUtils.baseUrl + APIUtils.updateDimeSale), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  }, body: {
    "id": dimeSellController.dimeSellDetail.value.id,
    "dimesale_name": dimeSellController.nameController.value.text,
    "bold_text_color":
        " ${dimeSellController.boldTextColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
    "button_color":
        "${dimeSellController.buttonColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
    "button_text_color":
        "${dimeSellController.buttonTextColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
    "text_color":
        "${dimeSellController.textColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
    "timer_color":
        "${dimeSellController.timerColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
    "timer_text_color":
        "${dimeSellController.timerTextColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
    "top_bar_color":
        "${dimeSellController.topBarColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
    "top_bar_bold_text": dimeSellController.tabBarBoldTextController.value.text,
    "top_bar_regular_text":
        dimeSellController.tabBarRegularTextController.value.text
  });

  print({
    "id": dimeSellController.dimeSellDetail.value.id,
    "dimesale_name": dimeSellController.nameController.value.text,
    "bold_text_color":
        " ${dimeSellController.boldTextColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
    "button_color":
        "${dimeSellController.buttonColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
    "button_text_color":
        "${dimeSellController.buttonTextColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
    "text_color":
        "${dimeSellController.textColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
    "timer_color":
        "${dimeSellController.timerColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
    "timer_text_color":
        "${dimeSellController.timerTextColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
    "top_bar_color":
        "${dimeSellController.topBarColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
    "top_bar_bold_text": dimeSellController.tabBarBoldTextController.value.text,
    "top_bar_regular_text":
        dimeSellController.tabBarRegularTextController.value.text
  });

  print(response.statusCode);
  print(response.body);
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["status"] == "Success") {
      updateDimeSalesProducts(productBody);
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
