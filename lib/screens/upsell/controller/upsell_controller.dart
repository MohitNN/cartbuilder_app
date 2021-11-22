import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class UpsellController extends GetxController {
  RxBool upsellStatusSwitch = false.obs;

  List<String> upSellDropDownVal = ["Select a Group", "one", "Two", "Three"];
  String selectedUpSellVal = "Select a Group";
  RxInt selectedCheckoutTemplate = 0.obs;
  RxList<String> dumData = [
    "Upsell #01 (\$67.00)",
    "Downsell #01 (\$47.00)",
    "Upsell #02 (\$97.00)"
  ].obs;

  RxList<Map> upSellGroup = [{}].obs;
  RxBool isLoading = false.obs;
  RxString selectedGroup = "".obs;
  RxString selectedGroupId = ''.obs;
  RxString selectedTypeOfDelivery = "".obs;
  RxBool displayThumbnailSwitch = false.obs;
  RxInt customizeTabIndex = 0.obs;

  RxString toEditId = "".obs;
  RxString upSellId = "".obs;

  RxBool isPrimaryTemplateColor = false.obs;
  RxBool isNavigationBar = false.obs;
  RxBool isHeader = false.obs;
  RxBool isVideo = false.obs;
  RxBool isBullets = false.obs;
  RxBool isOto = false.obs;
  RxBool isThankYou = false.obs;
  RxBool isDescription = false.obs;
  RxBool isUpgrade = false.obs;
  RxBool isFooterLogo = false.obs;
  RxBool isCopyRight = false.obs;
  RxBool isWaitAMinuteText = false.obs;
  RxBool isGetInstantButton = false.obs;
  RxBool isSpecialOfferText = false.obs;
  RxBool isCenterContent = false.obs;
  RxBool isLifeTimeText = false.obs;
  RxBool isOtoBlock = false.obs;
  RxBool isOneTimeOnlyOfferText = false.obs;
  RxBool isImage = false.obs;
  RxBool isGetInstantSectionText = false.obs;
  RxBool isOfferText = false.obs;
  RxBool isTimer = false.obs;
  RxBool isBanner = true.obs;

  RxDouble upsellLoads = 0.0.obs;

  updateSelUpSellDropDownVal(String value) {
    selectedUpSellVal = value;
  }
}

class GetUpsellDataBloc {
  StreamController<File> upsellImageController = PublishSubject<File>();
  StreamController<bool> upsellDisplayImageController = PublishSubject<bool>();

  Stream<File> get upsellImageStream => upsellImageController.stream;

  Stream<bool> get upsellDisplayImageStream =>
      upsellDisplayImageController.stream;

  Sink<File> get upsellImageSink => upsellImageController.sink;

  Sink<bool> get upsellDisplayImageSink => upsellDisplayImageController.sink;

  setUpsellImage(File image) => upsellImageSink.add(image);

  setUpsellDisplayImage(bool image) => upsellDisplayImageSink.add(image);

  void dispose() {
    upsellImageController.close();
    upsellDisplayImageController.close();
  }
}

final GetUpsellDataBloc getUpsellDataBloc = GetUpsellDataBloc();
