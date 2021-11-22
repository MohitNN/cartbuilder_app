import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/bump_offers/controller/bump_offer_controller.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

Future<bool> updateBumpOfferService({
  String offerName,
  String price,
  String bumpId,
}) async {
  ProductController productController = Get.put(ProductController());
  DashboardController dashboardController = Get.put(DashboardController());
  BumpOfferController bumpOfferController = Get.put(BumpOfferController());
  productController.isLoading.value = true;

  var response = await http.post(
    Uri.parse(APIUtils.baseUrl + APIUtils.updateBumpOfferDetail + bumpId),
    headers: {
      "Authorization": "Bearer ${authController.userToken.value}",
    },
    body: {
      "offer_name": offerName,
      "offer_price": price,
      "group": productController.selectedBumpOfferGroup.value,
      "header_title": bumpOfferController.buttonTextController.value.text,
      "header_description": bumpOfferController.footerTextController.value.text,
      "footer_text": bumpOfferController.titleTextController.value.text,
      "button_color": bumpOfferController.buttonColor.value
          .toString()
          .replaceAll("Color(0xff", "#")
          .replaceAll(")", ""),
      "border_color": bumpOfferController.borderColor.value
          .toString()
          .replaceAll("Color(0xff", "#")
          .replaceAll(")", ""),
      "border_type": bumpOfferController.boxBorderWidth.value == 0.0
          ? "solid"
          : bumpOfferController.boxBorderWidth.value == 5.0
              ? "dotted"
              : "dashed",
      "background_color": bumpOfferController.backgroundColor.value
          .toString()
          .replaceAll("Color(0xff", "#")
          .replaceAll(")", ""),
      "headingtext_color": bumpOfferController.buttonTextColor.value
          .toString()
          .replaceAll("Color(0xff", "#")
          .replaceAll(")", ""),
      "footertext_color": bumpOfferController.footerTextColor.value
          .toString()
          .replaceAll("Color(0xff", "#")
          .replaceAll(")", ""),
      "middletext_color": bumpOfferController.titleTextColor.value
          .toString()
          .replaceAll("Color(0xff", "#")
          .replaceAll(")", ""),
      "offer_tag": dashboardController.selectedTagList.value,
    },
  );

  print(response.statusCode);
  print(response.body);
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["status"] == true) {
      productController.isLoading.value = false;
      getToast(msg: "BumpOffer update successfully!");
      Get.back();
      return true;
    } else {
      productController.isLoading.value = false;
      getToast(msg: "Something went wrong");
      return false;
    }
  } else {
    productController.isLoading.value = false;
    return false;
  }
}
