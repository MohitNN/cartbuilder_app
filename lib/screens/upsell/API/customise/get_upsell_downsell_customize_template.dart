import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/upsell/controller/upsell_controller.dart';
import 'package:mint_bird_app/screens/upsell/controller/upsell_customise_controller.dart';
import 'package:mint_bird_app/screens/upsell/models/customise/upsell_customise.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

getUpSellDownSellTemplateService({String type}) async {
  UpsellController upsellController = Get.put(UpsellController());
  UpsellCustomiseController uCC = Get.put(UpsellCustomiseController());
  authController.loading.value = true;
  var response = await http.post(
      Uri.parse(APIUtils.baseUrl + APIUtils.getUpSellDownSellCustomise),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      },
      body: {
        "template_id":
            upsellController.selectedCheckoutTemplate.value.toString(),
        "type": type,
        "upsell_downsell_id": upsellController.upSellId.value,
      });

  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (decodedData["code"] == 200) {
    UpsellCustomise model = UpsellCustomise.fromJson(decodedData);
    TemplateCode templateCode = model.response.templateCode;
    upsellController.toEditId.value = model.response.id;
    ModalStatus mS = model.response.modalStatus;
    upsellController.isNavigationBar.value =
        mS.navigationBar == 1 || mS.navigationBar == "1" ? true : false;
    upsellController.isHeader.value = mS.header == 1 ? true : false;
    upsellController.isVideo.value = mS.video == 1 ? true : false;
    upsellController.isBullets.value = mS.bullets == 1 ? true : false;
    upsellController.isOto.value = mS.oto == 1 ? true : false;
    upsellController.isOtoBlock.value = mS.oto == 1 ? true : false;
    upsellController.isThankYou.value = mS.thankYou == 1 ? true : false;
    upsellController.isDescription.value =
        mS.descriptionText == 1 || mS.descriptionText == "1" ? true : false;
    upsellController.isUpgrade.value =
        mS.upgradeText == 1 || mS.upgradeText == "1" ? true : false;
    upsellController.isFooterLogo.value =
        mS.footerLogo == 1 || mS.footerLogo == "1" ? true : false;
    upsellController.isCopyRight.value = mS.copyright == 1 ? true : false;
    upsellController.isWaitAMinuteText.value =
        mS.waitAMinute == 1 ? true : false;
    upsellController.isGetInstantButton.value =
        mS.instantButton == 1 ? true : false;
    upsellController.isSpecialOfferText.value =
        mS.specialOffer == 1 ? true : false;
    upsellController.isCenterContent.value =
        mS.centerContent == 1 ? true : false;
    upsellController.isLifeTimeText.value = mS.lifetimeText == 1 ? true : false;
    upsellController.isTimer.value = mS.timer == 1 ? true : false;
    upsellController.isOneTimeOnlyOfferText.value =
        mS.oneTimeOnlyOffer == 1 ? true : false;
    upsellController.isImage.value = mS.oneTimeImage == 1 ? true : false;

    // REMAINING
    upsellController.isOtoBlock.value = mS.oto == 1 ? true : false;
    upsellController.isGetInstantSectionText.value =
        mS.instantButton == 1 ? true : false;
    upsellController.isOfferText.value = mS.specialOffer == 1 ? true : false;
    uCC.pickerColor.value = model.response.templateTheme == null
        ? upsellController.selectedCheckoutTemplate.value == 1
            ? Color(0xff27277D)
            : upsellController.selectedCheckoutTemplate.value == 2
                ? Color(0xff2C9EA3)
                : Color(0xff1db8ce)
        : Color(
            int.parse(model.response.templateTheme.replaceAll("#", "0xff")));

    // TEXTS
    uCC.noticeBarController.value.text = templateCode.funnelNavigationOne ?? "";
    uCC.headerTitleController.value.text = templateCode.funnelHeaderOne ?? "";
    uCC.headerDescController.value.text = templateCode.funnelHeaderTwo ?? "";
    uCC.videoController.value.text = templateCode.funnelVideoOne ?? "";
    uCC.otoController.value.text = templateCode.funnelButtonOne ?? "";
    uCC.thankYouController.value.text = templateCode.funnelButtonTwo ?? "";
    uCC.headerTitleController.value.text = templateCode.funnelHeaderOne ?? "";
    uCC.headerDescController.value.text = templateCode.funnelHeaderTwo ?? "";
    uCC.descriptionController.value.text =
        templateCode.funnelDescriptionTextOne ?? "";
    uCC.upgradeController.value.text = templateCode.funnelUpgradeTextOne ?? "";
    uCC.copyRightController.value.text =
        templateCode.funnelCopyrightTextOne ?? "";
    uCC.waitAMinuteController.value.text =
        templateCode.funnelWaitMinuteTextOne ?? "";
    uCC.instantButtonController.value.text =
        templateCode.funnelInstantButtonOne ?? "";
    uCC.specialOfferController.value.text =
        templateCode.funnelOfferTextOne ?? "";
    uCC.centerContent1Controller.value.text =
        templateCode.funnelCenterTitleOne ?? "";
    uCC.centerContent2Controller.value.text =
        templateCode.funnelCenetrDescriptionOne ?? "";
    uCC.lifeTimeController.value.text =
        templateCode.funnelLifetimeTextOne ?? "";
    uCC.otoBlock1Controller.value.text = templateCode.funnelOtoButtonOne ?? "";
    uCC.otoBlock2Controller.value.text =
        templateCode.funnelOtoButtonDescriptionOne ?? "";
    uCC.bulletHeadlineController.value.text =
        templateCode.funnelBulletTitle ?? "";
    templateCode.funnelBullet.clear();
    templateCode.funnelBullet.forEach((element) {
      uCC.bulletList.add({
        "name": element.title,
        "msg": element.description,
        "image": APIUtils.imageBaseUrl + element.image
      });
    });

    authController.loading.value = false;
  } else {
    authController.loading.value = false;
  }
}
