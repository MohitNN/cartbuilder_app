import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mint_bird_app/screens/dime_sales/models/dime_sell_detail_model.dart';

class DimeSellController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool detailLoader = false.obs;
  Rx<Color> topBarColor = Color(0xffffffff).obs;
  Rx<Color> textColor = Color(0xffffffff).obs;
  Rx<Color> boldTextColor = Color(0xffffffff).obs;
  Rx<Color> timerColor = Color(0xffffffff).obs;
  Rx<Color> timerTextColor = Color(0xffffffff).obs;
  Rx<Color> buttonColor = Color(0xffffffff).obs;
  Rx<Color> buttonTextColor = Color(0xffffffff).obs;
  RxBool isActive = false.obs;
  RxBool isConfigured = false.obs;

  Rx<DimeSellData> dimeSellDetail = DimeSellData().obs;
  RxList<DimeSaleManual> manualList = <DimeSaleManual>[
    DimeSaleManual(gDimeDriectUpsell: false, sale: 1, price: "0", behavior: 1)
  ].obs;
  RxList<DimeSaleAuto> autoList = <DimeSaleAuto>[
    DimeSaleAuto(gDimeDriectUpsell: false, sale: "10", price: "1", behavior: 1)
  ].obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> salesController = TextEditingController().obs;
  Rx<TextEditingController> incrementController = TextEditingController().obs;
  Rx<TextEditingController> tabBarTextController = TextEditingController().obs;
  Rx<TextEditingController> tabBarBoldTextController =
      TextEditingController().obs;
  Rx<TextEditingController> tabBarRegularTextController =
      TextEditingController().obs;
  Rx<TextEditingController> addManualSale = TextEditingController().obs;
  Rx<TextEditingController> addManualPrice = TextEditingController().obs;
  RxInt autoManual = 0.obs;
  RxString dimeSaleId = "".obs;
}
