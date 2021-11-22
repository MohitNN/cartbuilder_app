import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/product/API/scarcity/scarcity_time_sale_product.dart';
import 'package:mint_bird_app/screens/time_sales/controller/timesell_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

Future<bool> updateScarTimeSalesDetail({String body}) async {
  TimeSellController timeSellController = Get.put(TimeSellController());
  // ProductController productController = Get.put(ProductController());
  timeSellController.detailLoader.value = true;
  var response = await http.post(
      Uri.parse(APIUtils.baseUrl + APIUtils.updateScarcityTime),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      },
      body: {
        // "product_id": productController.productId.value,
        "id": timeSellController.timeSaleId.value,
        "timesale_name": timeSellController.nameController.value.text,
        "is_order_summary_timer":
            timeSellController.summaryTimer.value.toString(),
        "order_summary_timer_text":
            timeSellController.timerTextController.value.text,
        "bold_text_color":
            " ${timeSellController.boldTextColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
        "button_color":
            "${timeSellController.buttonColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
        "button_text_color":
            "${timeSellController.buttonTextColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
        "text_color":
            "${timeSellController.textColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
        "timer_color":
            "${timeSellController.timerColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
        "timer_text_color":
            "${timeSellController.timerTextColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
        "top_bar_color":
            "${timeSellController.topBarColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
        "top_bar_text": timeSellController.tabBarTextController.value.text,
        "top_bar_bold_text":
            timeSellController.tabBarBoldTextController.value.text,
        "top_bar_regular_text":
            timeSellController.tabBarRegularTextController.value.text
      });

  print({
    // "product_id": productController.productId.value,
    "id": timeSellController.timeSaleId.value,
    "timesale_name": timeSellController.nameController.value.text,
    "bold_text_color":
        " ${timeSellController.boldTextColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
    "button_color":
        "${timeSellController.buttonColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
    "button_text_color":
        "${timeSellController.buttonTextColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
    "text_color":
        "${timeSellController.textColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
    "timer_color":
        "${timeSellController.timerColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
    "timer_text_color":
        "${timeSellController.timerTextColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
    "top_bar_color":
        "${timeSellController.topBarColor.toString().replaceAll("Color(0xff", "#").replaceAll(")", "")}",
    "top_bar_text": timeSellController.tabBarTextController.value.text,
    "top_bar_bold_text": timeSellController.tabBarBoldTextController.value.text,
    "top_bar_regular_text":
        timeSellController.tabBarRegularTextController.value.text
  });
  print(response.statusCode);
  print(response.body);
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["status"] == "Success") {
      updateScarTimeSalesProduct(body);
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
