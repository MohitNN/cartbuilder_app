import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dime_sales/controller/dime_sell_controller.dart';
import 'package:mint_bird_app/screens/dime_sales/models/dime_sell_detail_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

getUserDimeSaleDetailService(String id) async {
  DimeSellController dimeSellController = Get.put(DimeSellController());
  dimeSellController.isLoading.value = true;
  var response = await http.get(
      Uri.parse(APIUtils.baseUrl + APIUtils.getDimeSaleDetail + id),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (decodedData["code"] == 200) {
    DimeSellData dimeSellDetailModel =
        DimeSellDetailModel.fromJson(decodedData).response;
    dimeSellController.dimeSellDetail.value = dimeSellDetailModel;
    dimeSellController.nameController.value.text =
        dimeSellDetailModel.dimesaleName;
    if (dimeSellDetailModel.sales.length != 0) {
      dimeSellController.salesController.value.text =
          dimeSellDetailModel.sales.first.auto.first.sale.toString();
      dimeSellController.incrementController.value.text =
          dimeSellDetailModel.sales.first.auto.first.price;
      dimeSellController.manualList.value =
          dimeSellDetailModel.sales.first.manual;
      dimeSellController.autoList.value = dimeSellDetailModel.sales.first.auto;
      dimeSellController.isActive.value =
          dimeSellDetailModel.sales.first.active;
      dimeSellController.autoManual.value =
          dimeSellDetailModel.sales.first.timeset == "auto" ? 0 : 1;
      dimeSellController.isConfigured.value = true;
    } else {
      dimeSellController.isConfigured.value = false;
      dimeSellController.salesController.value.text = "10";
      dimeSellController.manualList.clear();
      dimeSellController.incrementController.value.clear();
    }
    dimeSellController.tabBarTextController.value.text =
        dimeSellDetailModel.topBarText;
    dimeSellController.tabBarBoldTextController.value.text =
        dimeSellDetailModel.topBarBoldText;
    dimeSellController.tabBarRegularTextController.value.text =
        dimeSellDetailModel.topBarRegularText;
    dimeSellController.topBarColor.value = Color(int.parse(
        dimeSellDetailModel.theme.topBarColor.replaceAll("#", "0xff")));
    dimeSellController.textColor.value = Color(
        int.parse(dimeSellDetailModel.theme.textColor.replaceAll("#", "0xff")));
    dimeSellController.boldTextColor.value = Color(int.parse(
        dimeSellDetailModel.theme.boldTextColor.replaceAll("#", "0xff")));
    dimeSellController.timerColor.value = Color(int.parse(
        dimeSellDetailModel.theme.timerColor.replaceAll("#", "0xff")));
    dimeSellController.timerTextColor.value = Color(int.parse(
        dimeSellDetailModel.theme.timerTextColor.replaceAll("#", "0xff")));
    dimeSellController.buttonColor.value = Color(int.parse(
        dimeSellDetailModel.theme.buttonColor.replaceAll("#", "0xff")));
    dimeSellController.buttonTextColor.value = Color(int.parse(
        dimeSellDetailModel.theme.buttonTextColor.replaceAll("#", "0xff")));
    dimeSellController.isLoading.value = false;
  } else {
    dimeSellController.isLoading.value = false;
  }
}
