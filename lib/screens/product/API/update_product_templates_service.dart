import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/screens/product/controller/check_out_design_controller.dart';
import 'package:mint_bird_app/screens/product/models/product_checkout_template_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

import '../../../main.dart';
import 'product_chekout_template_detail_service.dart';

Future<bool> updateProductTemplatesService(
    {bool navigationBar,
    bool cartHeader,
    bool seals,
    bool badges,
    bool editImage,
    bool formHeader,
    bool bulletPoints,
    bool testimonial,
    String templateEditType,
    String productTitle,
    String productDescription,
    String modalName,
    String productFormHeader1,
    String productFromHeader2,
    String productLabelOne,
    String productLabelTwo,
    List bulletPointList,
    List testimonialList}) async {
  CheckOutDesignController checkOutDesignController =
      Get.put(CheckOutDesignController());
  Map<String, dynamic> body = {
    "id": checkOutDesignController.checkOutTemplateModel.value.response.id,
  };
  if (modalName != null) body.putIfAbsent("modal_name", () => modalName);
  ProductCheckOutTemplateModel model =
      checkOutDesignController.checkOutTemplateModel.value;
  ModalStatus modalStatus = model.response.modalStatus;
  body.putIfAbsent(
      "badges",
      () => badges == null
          ? modalStatus.badges.toString()
          : badges
              ? "1"
              : "0");
  body.putIfAbsent(
      "bullet_points",
      () => bulletPoints == null
          ? modalStatus.bulletPoints.toString()
          : bulletPoints
              ? "1"
              : "0");
  body.putIfAbsent(
      "cart_header",
      () => cartHeader == null
          ? modalStatus.cartHeader.toString()
          : cartHeader
              ? "1"
              : "0");
  body.putIfAbsent(
      "seals",
      () => seals == null
          ? modalStatus.seals.toString()
          : seals
              ? "1"
              : "0");
  body.putIfAbsent(
      "testimonial",
      () => testimonial == null
          ? modalStatus.testimonial.toString()
          : testimonial
              ? "1"
              : "0");
  body.putIfAbsent(
      "form_header",
      () => formHeader == null
          ? modalStatus.formHeader.toString()
          : formHeader
              ? "1"
              : "0");
  body.putIfAbsent(
      "image",
      () => editImage == null
          ? modalStatus.image.toString()
          : editImage
              ? "1"
              : "0");
  body.putIfAbsent(
      "navigation_bar",
      () => navigationBar == null
          ? modalStatus.navigationBar.toString()
          : navigationBar
              ? "1"
              : "0");
  if (templateEditType != null)
    body.putIfAbsent("template_edit_type", () => templateEditType);
  if (productTitle != null)
    body.putIfAbsent("product_title", () => productTitle);
  if (productDescription != null)
    body.putIfAbsent("product_description", () => productDescription);
  if (productFormHeader1 != null)
    body.putIfAbsent("product_form_header_one", () => productFormHeader1);
  if (productFromHeader2 != null)
    body.putIfAbsent("product_form_header_two", () => productFromHeader2);
  if (productLabelOne != null)
    body.putIfAbsent("product_label_one", () => productLabelOne);
  if (productLabelTwo != null)
    body.putIfAbsent("product_label_two", () => productLabelTwo);
  if (bulletPointList != null) {
    body.putIfAbsent("list_length", () => bulletPointList.length.toString());
    for (int i = 0; i < bulletPointList.length; i++) {
      body.putIfAbsent("product_list$i", () => bulletPointList[i]);
    }
  }

  if (testimonialList != null) {
    body.putIfAbsent("client_length", () => testimonialList.length.toString());
    for (int i = 0; i < testimonialList.length; i++) {
      body.putIfAbsent("client_title$i", () => testimonialList[i]["name"]);
      body.putIfAbsent("client_description$i", () => testimonialList[i]["msg"]);
      // body.putIfAbsent("client_image${i}_flag", () => null);
      // body.putIfAbsent("client_image$i", () => null);
    }
  }

  authController.loading.value = true;
  var response =
      await http.post(Uri.parse(APIUtils.baseUrl + APIUtils.saveTemplate),
          headers: {
            "Authorization": "Bearer ${authController.userToken.value}",
          },
          body: body);
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["status"] == true) {
      authController.loading.value = false;
      getToast(msg: "Changes saved");
      getCheckoutTemplateDetailService(
          id: checkOutDesignController.productId.value);
      return true;
    } else {
      authController.loading.value = false;
      getToast(msg: "Something went wrong");
      return false;
    }
  } else {
    authController.loading.value = false;
    getToast(msg: "Something went wrong");
    return false;
  }
}

sendImageInTemplate(
    {String templateEditType,
    String productLabelOne,
    String productLabelTwo,
    List<Map<String, String>> testimonialList}) async {
  CheckOutDesignController cK = Get.put(CheckOutDesignController());
  authController.loading.value = true;
  Uri url = Uri.parse(APIUtils.baseUrl + APIUtils.saveTemplate);
  Map<String, String> headers = {
    "Authorization": "Bearer ${authController.userToken.value}",
  };
  var request = http.MultipartRequest("POST", url);
  request.headers.addAll(headers);
  request.fields.addIf(true, "id", cK.checkOutTemplateModel.value.response.id);
  request.fields.addIf(true, "template_edit_type", templateEditType);

  // NAVIGATION IMAGE SEND
  if (!cK.navigationImagePath.value.contains(APIUtils.imageBaseUrl) &&
      cK.navigationImagePath.value != null) {
    request.files.add(await http.MultipartFile.fromPath(
        "navigation_image", cK.navigationImagePath.value));
  }

  // SEAL IMAGES
  if (productLabelOne != null)
    request.fields.addIf(cK.productFormHeader1Controller.value.text != null,
        "product_label_one", cK.productFormHeader1Controller.value.text);
  if (cK.productFormHeader1Controller.value.text != null)
    request.fields.addIf(cK.productFormHeader1Controller.value.text != null,
        "product_label_two", cK.productFormHeader1Controller.value.text);
  if (!cK.seal1ImagePath.value.contains(APIUtils.imageBaseUrl) &&
      cK.seal1ImagePath.value != null) {
    request.files.add(await http.MultipartFile.fromPath(
        "product_label_image_one", cK.seal1ImagePath.value));
  }
  if (!cK.seal2ImagePath.value.contains(APIUtils.imageBaseUrl) &&
      cK.seal2ImagePath.value != null) {
    request.files.add(await http.MultipartFile.fromPath(
        "product_label_image_two", cK.seal2ImagePath.value));
  }
  //
  // // BADGES
  if (!cK.badge1ImagePath.value.contains(APIUtils.imageBaseUrl) &&
      cK.badge1ImagePath.value != null) {
    request.files.add(await http.MultipartFile.fromPath(
        "product_badge_one", cK.badge1ImagePath.value));
  }
  if (!cK.badge2ImagePath.value.contains(APIUtils.imageBaseUrl) &&
      cK.badge2ImagePath.value != null) {
    request.files.add(await http.MultipartFile.fromPath(
        "product_badge_two", cK.badge2ImagePath.value));
  }
  if (!cK.badge3ImagePath.value.contains(APIUtils.imageBaseUrl) &&
      cK.badge3ImagePath.value != null) {
    request.files.add(await http.MultipartFile.fromPath(
        "product_badge_three", cK.badge3ImagePath.value));
  }
  //
  //EDIT IMAGE
  if (!cK.imagePath.value.contains(APIUtils.imageBaseUrl) &&
      cK.imagePath.value != null) {
    request.files.add(
        await http.MultipartFile.fromPath("product_image", cK.imagePath.value));
  }
  //
  // //TESTIMONIALS
  if (testimonialList != null) {
    for (int i = 0; i < testimonialList.length; i++) {
      if (testimonialList[i]["name"] != null) {
        request.fields.addIf(testimonialList[i]["name"] != null,
            "client_title$i", testimonialList[i]["name"]);
      }
      if (testimonialList[i]["msg"] != null) {
        request.fields.addIf(testimonialList[i]["msg"] != null,
            "client_description$i", testimonialList[i]["msg"]);
      }
      if (testimonialList[i]["image"] != null &&
          !testimonialList[i]["image"].contains(APIUtils.imageBaseUrl)) {
        request.files.addIf(
            testimonialList[i]["image"] != null &&
                !testimonialList[i]["image"].contains(APIUtils.imageBaseUrl),
            await http.MultipartFile.fromPath(
                "client_image$i", testimonialList[i]["image"]));
      }
    }
  }

  var response = await request.send();
  if (response.statusCode == 200) {
    Get.back();
  } else {
    errorSnackBar("Something went wrong!", "Please try again later");
  }
  authController.loading.value = false;
}
