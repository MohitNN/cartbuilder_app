import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BumpOfferController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool doNotMissCheckBox = false.obs;
  RxDouble boxBorderWidth = 5.0.obs;
  RxList<int> boxBorderDash = [5,5].obs;

  Rx<Color> buttonColor = Color(0xfffddc49).obs;
  Rx<Color> borderColor = Color(0xfffe4c34).obs;
  Rx<Color> backgroundColor = Color(0xffFFF7E1).obs;
  Rx<Color> buttonTextColor = Color(0xff384954).obs;
  Rx<Color> titleTextColor = Color(0xffEB3A24).obs;
  Rx<Color> footerTextColor = Color(0xff000000).obs;

  Rx<TextEditingController> buttonTextController = TextEditingController().obs;
  Rx<TextEditingController> titleTextController = TextEditingController().obs;
  Rx<TextEditingController> footerTextController = TextEditingController().obs;
}
