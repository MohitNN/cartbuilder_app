import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/upsell/API/customise/get_upsell_downsell_customize_template.dart';
import 'package:mint_bird_app/screens/upsell/controller/upsell_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

Future<bool> saveUpsellCustomiseTemplate(
    {String modalName,
    String navigationBar,
    String header,
    String video,
    String descriptionText,
    String upgradeText,
    String footerLogo,
    String copyRight,
    String waitAMinute,
    String instantButton,
    String offer,
    String centerContent,
    String lifeTime,
    String oneTimeOnlyOffer,
    String oneTimeImage,
    String timer,
    String bullets,
    String oto,
    String thankYou,
    String color,
    String templateEditType,
    String funnelNavigationOne,
    String funnelHeaderOne,
    String funnelHeaderTwo,
    String funnelVideoOne,
    String funnelButtonOne,
    String funnelButtonTwo,
    String funnelDescriptionText1,
    String funnelUpgradeText1,
    String funnelCopyrightText1,
    String funnelWaitAMinuteTextOne,
    String funnelInstantButtonOne,
    String funnelOfferTextOne,
    String funnelCenterTitleOne,
    String funnelCenterDescriptionOne,
    String funnelLifetimeTextOne,
    String funnelOtoButtonOne,
    String funnelOtoButtonDescriptionOne}) async {
  authController.loading.value = true;
  UpsellController upsellController = Get.put(UpsellController());
  Map<String, String> body = {
    "product_id": upsellController.toEditId.value,
  };
  if (navigationBar != null)
    body.putIfAbsent("navigation_bar", () => navigationBar);
  if (header != null) body.putIfAbsent("header", () => header);
  if (video != null) body.putIfAbsent("video", () => video);
  if (descriptionText != null)
    body.putIfAbsent("description_text", () => descriptionText);
  if (upgradeText != null) body.putIfAbsent("upgrade_text", () => upgradeText);
  if (footerLogo != null) body.putIfAbsent("footer_logo", () => footerLogo);
  if (copyRight != null) body.putIfAbsent("copyright", () => copyRight);
  if (waitAMinute != null) body.putIfAbsent("wait_a_minute", () => waitAMinute);
  if (instantButton != null)
    body.putIfAbsent("instant_button", () => instantButton);
  if (offer != null) body.putIfAbsent("special_offer", () => offer);
  if (centerContent != null)
    body.putIfAbsent("center_content", () => centerContent);
  if (lifeTime != null) body.putIfAbsent("lifetime_text", () => lifeTime);
  if (oneTimeOnlyOffer != null)
    body.putIfAbsent("one_time_only_offer", () => oneTimeOnlyOffer);
  if (oneTimeImage != null)
    body.putIfAbsent("one_time_image", () => oneTimeImage);
  if (timer != null) body.putIfAbsent("timer", () => timer);
  if (bullets != null) body.putIfAbsent("bullets", () => bullets);
  if (oto != null) body.putIfAbsent("oto", () => oto);
  if (thankYou != null) body.putIfAbsent("thank_you", () => thankYou);
  if (modalName != null) body.putIfAbsent("modal_name", () => modalName);
  //Color
  if (color != null) body.putIfAbsent("theme", () => color);
  //Texts
  if (templateEditType != null)
    body.putIfAbsent("template_edit_type", () => templateEditType);
  if (funnelNavigationOne != null)
    body.putIfAbsent("funnel_navigation_one", () => funnelNavigationOne);
  if (funnelHeaderOne != null)
    body.putIfAbsent("funnel_header_one", () => funnelHeaderOne);
  if (funnelHeaderTwo != null)
    body.putIfAbsent("funnel_header_two", () => funnelHeaderTwo);
  if (funnelVideoOne != null)
    body.putIfAbsent("funnel_video_one", () => funnelVideoOne);
  if (funnelButtonOne != null)
    body.putIfAbsent("funnel_button_one", () => funnelButtonOne);
  if (funnelButtonTwo != null)
    body.putIfAbsent("funnel_button_two", () => funnelButtonTwo);
  if (funnelDescriptionText1 != null)
    body.putIfAbsent(
        "funnel_description_text_one", () => funnelDescriptionText1);
  if (funnelUpgradeText1 != null)
    body.putIfAbsent("funnel_upgrade_text_one", () => funnelUpgradeText1);
  if (funnelCopyrightText1 != null)
    body.putIfAbsent("funnel_copyright_text_one", () => funnelCopyrightText1);
  if (funnelWaitAMinuteTextOne != null)
    body.putIfAbsent(
        "funnel_wait_minute_text_one", () => funnelWaitAMinuteTextOne);
  if (funnelInstantButtonOne != null)
    body.putIfAbsent("funnel_instant_button_one", () => funnelInstantButtonOne);
  if (funnelOfferTextOne != null)
    body.putIfAbsent("funnel_offer_text_one", () => funnelOfferTextOne);
  if (funnelCenterTitleOne != null)
    body.putIfAbsent("funnel_center_title_one", () => funnelCenterTitleOne);
  if (funnelCenterDescriptionOne != null)
    body.putIfAbsent(
        "funnel_cenetr_description_one", () => funnelCenterDescriptionOne);
  if (funnelLifetimeTextOne != null)
    body.putIfAbsent("funnel_lifetime_text_one", () => funnelLifetimeTextOne);
  if (funnelOtoButtonOne != null)
    body.putIfAbsent("funnel_oto_button_one", () => funnelOtoButtonOne);
  if (funnelOtoButtonDescriptionOne != null)
    body.putIfAbsent("funnel_oto_button_description_one",
        () => funnelOtoButtonDescriptionOne);
  var response =
      await http.post(Uri.parse(APIUtils.baseUrl + APIUtils.saveFunnelTemplate),
          headers: {
            "Authorization": "Bearer ${authController.userToken.value}",
          },
          body: body);

  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (decodedData["code"] == 200) {
    getUpSellDownSellTemplateService(type: "upsell");
    authController.loading.value = false;
    getToast(msg: "Updated successfully");
    return true;
  } else {
    authController.loading.value = false;
    getToast(msg: "Something went wrong");
    return false;
  }
}

void saveColorInTemplate(color) async {
  authController.loading.value = true;

  UpsellController upsellController = Get.put(UpsellController());

  Map<String, dynamic> body = {
    "template_id": upsellController.toEditId.value,
    "theme": color
  };
  Get.back();
  var response = await http.post(
      Uri.parse(APIUtils.baseUrl + APIUtils.saveColorFunnelTemplate),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      },
      body: body);

  if (response.statusCode == 200) {
  } else {
    errorSnackBar("Something went wrong", "Please try again later");
  }
  authController.loading.value = false;
}

sendImageInUpsellTemplate(
    {String templateEditType,
    List<Map<String, String>> bulletList,
    String funnelBulletTitle}) async {
  UpsellController upsellController = Get.put(UpsellController());
  authController.loading.value = true;
  Uri url = Uri.parse(APIUtils.baseUrl + APIUtils.saveFunnelTemplate);
  Map<String, String> headers = {
    "Authorization": "Bearer ${authController.userToken.value}",
  };
  var request = http.MultipartRequest("POST", url);
  request.headers.addAll(headers);
  request.fields.addIf(true, "product_id", upsellController.toEditId.value);
  request.fields.addIf(true, "template_edit_type", templateEditType);
  request.fields.addIf(true, "funnel_bullet_title", funnelBulletTitle);
  request.fields.addIf(true, "bullet_length", bulletList.length.toString());

  if (bulletList != null) {
    for (int i = 0; i < bulletList.length; i++) {
      if (bulletList[i]["name"] != null) {
        request.fields.addIf(bulletList[i]["name"] != null, "bullet_title$i",
            bulletList[i]["name"]);
      }
      if (bulletList[i]["msg"] != null) {
        request.fields.addIf(bulletList[i]["msg"] != null,
            "bullet_description$i", bulletList[i]["msg"]);
      }
      if (bulletList[i]["image"] != null &&
          !bulletList[i]["image"].contains(APIUtils.imageBaseUrl)) {
        request.files.addIf(
            bulletList[i]["image"] != null &&
                !bulletList[i]["image"].contains(APIUtils.imageBaseUrl),
            await http.MultipartFile.fromPath(
                "bullet_image$i", bulletList[i]["image"]));
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
