import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mint_bird_app/screens/product/models/product_checkout_template_model.dart';

class CheckOutDesignController extends GetxController {
  RxString productId = "".obs;
  RxBool noticeBarText = false.obs;
  RxBool cartHeader = false.obs;
  RxBool sales = false.obs;
  RxBool badges = false.obs;
  RxBool image = false.obs;
  RxBool header = false.obs;
  RxBool bulletPoints = false.obs;
  RxBool testimonials = false.obs;
  Rx<ProductCheckOutTemplateModel> checkOutTemplateModel =
      ProductCheckOutTemplateModel().obs;
  RxString navigationImagePath = "".obs;
  RxString seal1ImagePath = "".obs;
  RxString seal2ImagePath = "".obs;
  RxString badge1ImagePath = "".obs;
  RxString badge2ImagePath = "".obs;
  RxString badge3ImagePath = "".obs;
  RxString imagePath = "".obs;
  RxString testimonialImagePath = "".obs;
  RxList<String> benefits = <String>[].obs;
  RxList<Map<String, String>> testimonialList = <Map<String, String>>[].obs;
  Rx<TextEditingController> titleController = TextEditingController().obs;
  Rx<TextEditingController> descController = TextEditingController().obs;
  Rx<TextEditingController> productFormHeader1Controller =
      TextEditingController().obs;
  Rx<TextEditingController> productFormHeader2Controller =
      TextEditingController().obs;
  Rx<TextEditingController> secureController = TextEditingController().obs;
  Rx<TextEditingController> moneyController = TextEditingController().obs;
}
