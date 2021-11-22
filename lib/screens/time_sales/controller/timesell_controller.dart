import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mint_bird_app/screens/time_sales/models/time_sell_detail_model.dart';

class TimeSellController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool detailLoader = false.obs;
  Rx<Color> topBarColor = Color(0xffffffff).obs;
  Rx<Color> textColor = Color(0xffffffff).obs;
  Rx<Color> boldTextColor = Color(0xffffffff).obs;
  Rx<Color> timerColor = Color(0xffffffff).obs;
  Rx<Color> timerTextColor = Color(0xffffffff).obs;
  Rx<Color> buttonColor = Color(0xffffffff).obs;
  Rx<Color> buttonTextColor = Color(0xffffffff).obs;
  RxInt selectedTime = 0.obs;
  RxInt autoManual = 0.obs;
  RxBool isConfigured = false.obs;
  RxBool summaryTimer = false.obs;
  Rx<TimeSellData> timeSellDetail = TimeSellData().obs;
  RxBool isActive = false.obs;
  RxList<TimeSellManual> manualList = <TimeSellManual>[
    TimeSellManual(
        gDimeDriectUpsell: false,
        sale: 60,
        price: "10",
        behavior: 1,
        hourDay: "1")
  ].obs;
  RxList<TimeSaleAuto> autoList = <TimeSaleAuto>[
    TimeSaleAuto(
        gDimeDriectUpsell: false,
        sale: 60,
        price: "10",
        behavior: 1,
        hourDay: "1")
  ].obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> salesController = TextEditingController().obs;
  Rx<TextEditingController> incrementController = TextEditingController().obs;
  Rx<TextEditingController> tabBarTextController = TextEditingController().obs;
  Rx<TextEditingController> timerTextController = TextEditingController().obs;
  Rx<TextEditingController> tabBarBoldTextController =
      TextEditingController().obs;
  Rx<TextEditingController> tabBarRegularTextController =
      TextEditingController().obs;
  Rx<TextEditingController> addManualSale = TextEditingController().obs;
  Rx<TextEditingController> addManualPrice = TextEditingController().obs;
  RxInt selectedIndex = 0.obs;
  RxString addHoursDay = "0".obs;
  RxString timeSaleId = "".obs;
}
