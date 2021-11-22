import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mint_bird_app/screens/upsell/models/customise/upsell_customise_data_model.dart'
    as uC;

class UpsellCustomiseController extends GetxController {
  Rx<Color> pickerColor = Color(0xff2e5472).obs;
  Rx<TextEditingController> noticeBarController = TextEditingController().obs;
  Rx<TextEditingController> headerTitleController = TextEditingController().obs;
  Rx<TextEditingController> headerDescController = TextEditingController().obs;
  Rx<TextEditingController> videoController = TextEditingController().obs;
  Rx<TextEditingController> otoController = TextEditingController().obs;
  Rx<TextEditingController> thankYouController = TextEditingController().obs;
  Rx<TextEditingController> waitAMinuteController = TextEditingController().obs;
  Rx<TextEditingController> instantButtonController =
      TextEditingController().obs;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;
  Rx<TextEditingController> upgradeController = TextEditingController().obs;
  Rx<TextEditingController> copyRightController = TextEditingController().obs;
  Rx<TextEditingController> lifeTimeController = TextEditingController().obs;
  Rx<TextEditingController> centerContent1Controller =
      TextEditingController().obs;
  Rx<TextEditingController> centerContent2Controller =
      TextEditingController().obs;
  Rx<TextEditingController> otoBlock1Controller = TextEditingController().obs;
  Rx<TextEditingController> otoBlock2Controller = TextEditingController().obs;
  Rx<TextEditingController> bulletHeadlineController =
      TextEditingController().obs;
  Rx<TextEditingController> specialOfferController =
      TextEditingController().obs;
  RxString imagePath = "".obs;
  RxList<Map<String, String>> bulletList = <Map<String, String>>[].obs;
  RxString bulletImagePath = "".obs;
  RxString bannerImagePath = "".obs;

  RxList<String> benefits = <String>[].obs;

  Rx<uC.Response> uCData = uC.Response().obs;
}
