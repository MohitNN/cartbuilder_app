import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/time_sales/controller/timesell_controller.dart';
import 'package:mint_bird_app/screens/time_sales/models/time_sell_detail_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

getUserTimeSaleDetailService(String id) async {
  TimeSellController timeSellController = Get.put(TimeSellController());
  timeSellController.isLoading.value = true;
  var response = await http.get(
      Uri.parse(APIUtils.baseUrl + APIUtils.getTimeSaleDetail + id),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  print(response.statusCode);
  print(response.body);
  if (decodedData["code"] == 200) {
    TimeSellData timeSellDetailModel =
        TimeSellDetailModel.fromJson(decodedData).response;
    timeSellController.timeSellDetail.value = timeSellDetailModel;
    timeSellController.nameController.value.text =
        timeSellDetailModel.timesaleName;
    if (timeSellDetailModel.sales.length != 0) {
      timeSellController.salesController.value.text =
          timeSellDetailModel.sales.first.auto.first.sale.toString();
      timeSellController.incrementController.value.text =
          timeSellDetailModel.sales.first.auto.first.price;
      timeSellController.autoManual.value =
          timeSellDetailModel.sales.first.timesettime == "manual" ? 1 : 0;
      timeSellController.selectedTime.value =
          timeSellDetailModel.sales.first.auto.first.hourDay == "0" ? 0 : 1;
      timeSellController.manualList.value =
          timeSellDetailModel.sales.first.manual;
      timeSellController.autoList.value = timeSellDetailModel.sales.first.auto;
      timeSellController.isActive.value =
          timeSellDetailModel.sales.first.active;
      timeSellController.isConfigured.value = true;
    } else {
      timeSellController.isConfigured.value = false;
      timeSellController.salesController.value.text = "1";
      timeSellController.incrementController.value.text = "1";
      timeSellController.autoManual.value = 0;
      timeSellController.selectedTime.value = 0;
    }
    timeSellController.tabBarTextController.value.text =
        timeSellDetailModel.topBarText;
    timeSellController.tabBarBoldTextController.value.text =
        timeSellDetailModel.topBarBoldText;
    timeSellController.tabBarRegularTextController.value.text =
        timeSellDetailModel.topBarRegularText;
    timeSellController.topBarColor.value = Color(int.parse(
        timeSellDetailModel.theme.topBarColor.replaceAll("#", "0xff")));
    timeSellController.textColor.value = Color(
        int.parse(timeSellDetailModel.theme.textColor.replaceAll("#", "0xff")));
    timeSellController.boldTextColor.value = Color(int.parse(
        timeSellDetailModel.theme.boldTextColor.replaceAll("#", "0xff")));
    timeSellController.timerColor.value = Color(int.parse(
        timeSellDetailModel.theme.timerColor.replaceAll("#", "0xff")));
    timeSellController.timerTextColor.value = Color(int.parse(
        timeSellDetailModel.theme.timerTextColor.replaceAll("#", "0xff")));
    timeSellController.buttonColor.value = Color(int.parse(
        timeSellDetailModel.theme.buttonColor.replaceAll("#", "0xff")));
    timeSellController.buttonTextColor.value = Color(int.parse(
        timeSellDetailModel.theme.buttonTextColor.replaceAll("#", "0xff")));
    timeSellController.timerTextController.value.text =
        timeSellDetailModel.orderSummaryTimerText;
    timeSellController.summaryTimer.value =
        timeSellDetailModel.isOrderSummaryTimer == "true" ? true : false;
    timeSellController.isLoading.value = false;
  } else {
    timeSellController.isLoading.value = false;
  }
}
