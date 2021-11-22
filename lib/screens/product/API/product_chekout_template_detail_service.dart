import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/product/controller/check_out_design_controller.dart';
import 'package:mint_bird_app/screens/product/models/product_checkout_template_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

getCheckoutTemplateDetailService({String id}) async {
  authController.loading.value = true;
  CheckOutDesignController cK = Get.put(CheckOutDesignController());
  var response = await http.post(
      Uri.parse(APIUtils.baseUrl + APIUtils.getCheckoutDetails),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      },
      body: {
        "product_id": id
      });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (decodedData["code"] == 200) {
    cK.checkOutTemplateModel.value =
        ProductCheckOutTemplateModel.fromJson(decodedData);
    ProductCheckOutTemplateModel model = cK.checkOutTemplateModel.value;
    ModalStatus modalStatus = model.response.modalStatus;
    TemplateCode templateCode =
        cK.checkOutTemplateModel.value.response.templateCode;
    cK.noticeBarText.value = modalStatus.navigationBar == 1 ? true : false;
    cK.cartHeader.value = modalStatus.cartHeader == 1 ? true : false;
    cK.sales.value = modalStatus.seals == 1 ? true : false;
    cK.badges.value = modalStatus.badges == 1 ? true : false;
    cK.image.value = modalStatus.image == 1 ? true : false;
    cK.header.value = modalStatus.formHeader == 1 ? true : false;
    cK.bulletPoints.value = modalStatus.bulletPoints == 1 ? true : false;
    cK.testimonials.value = modalStatus.testimonial == 1 ? true : false;
    cK.titleController.value.text = templateCode.productTitle ?? "";
    cK.descController.value.text = templateCode.productDescription ?? "";
    cK.productFormHeader1Controller.value.text =
        templateCode.productFormHeaderOne ?? "";
    cK.productFormHeader2Controller.value.text =
        templateCode.productFormHeaderTwo ?? "";
    cK.secureController.value.text = templateCode.productLabelOne;
    cK.moneyController.value.text = templateCode.productLabelTwo;
    cK.benefits.clear();
    templateCode.productList.forEach((element) {
      if (element != null) {
        cK.benefits.add(element);
      }
    });
    cK.testimonialList.clear();
    templateCode.productClientTestimonial.forEach((element) {
      if (element.clientTitle != null) {
        if (element.clientImage != null) {
          cK.testimonialList.add({
            "name": element.clientTitle,
            "msg": element.clientDescription,
            "image": APIUtils.imageBaseUrl + element.clientImage,
          });
        } else {
          cK.testimonialList.add({
            "name": element.clientTitle,
            "msg": element.clientDescription,
          });
        }
      }
    });
    if (templateCode.navigationImage != null) {
      cK.navigationImagePath.value =
          APIUtils.imageBaseUrl + templateCode.navigationImage;
    }
    if (templateCode.productLabelImageOne != null) {
      cK.seal1ImagePath.value =
          APIUtils.imageBaseUrl + templateCode.productLabelImageOne;
    }
    if (templateCode.productLabelImageOne != null) {
      cK.seal2ImagePath.value =
          APIUtils.imageBaseUrl + templateCode.productLabelImageTwo;
    }
    if (templateCode.productBadgeOne != null) {
      cK.badge1ImagePath.value =
          APIUtils.imageBaseUrl + templateCode.productBadgeOne;
    }
    if (templateCode.productBadgeTwo != null) {
      cK.badge2ImagePath.value =
          APIUtils.imageBaseUrl + templateCode.productBadgeTwo;
    }
    if (templateCode.productBadgeThree != null) {
      cK.badge3ImagePath.value =
          APIUtils.imageBaseUrl + templateCode.productBadgeThree;
    }
    if (templateCode.productImage != null) {
      cK.imagePath.value = APIUtils.imageBaseUrl + templateCode.productImage;
    }
    cK.productId.value = model.response.productId;
  }
  authController.loading.value = false;
}
