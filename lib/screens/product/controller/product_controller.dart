import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:mint_bird_app/screens/product/models/scarcity/scarcity_products_model.dart';
import 'package:rxdart/rxdart.dart';

class ProductController extends GetxController {
  RxString productUpSellDownSell = "".obs;

  RxBool productStatusSwitch = false.obs;
  RxBool addToFunnelSwitch = false.obs;
  RxBool liveModeSwitch = false.obs;
  RxBool applyCouponSwitch = false.obs;
  RxBool disableShippingSwitch = false.obs;
  RxBool billingShippingFirstSwitch = false.obs;
  RxBool disableThumbnailSwitch = false.obs;
  RxBool originalPrice = false.obs;
  RxInt isProductTabSelected = 0.obs;
  RxInt successTabIndex = 0.obs;
  RxInt checkOutTabIndex = 0.obs;
  RxInt selectedSuccessTemplate = 0.obs;
  RxInt selectedCheckoutTemplate = 0.obs;
  RxString selectedGroupValue = ''.obs;
  RxString selectedFunnelValue = ''.obs;
  RxString selectedGroupId = ''.obs;
  RxList<Map> productGroup = [{}].obs;
  RxList<Map> funnelList = [{}].obs;
  RxBool isLoading = false.obs;
  RxBool isDialogLoading = false.obs;
  RxString selectedGroup = "".obs;
  RxString selectedBumpOfferGroup = "".obs;
  RxList<Map> bumpOfferGroups = [{}].obs;
  RxList<Map> bumpOffers = [{}].obs;
  RxDouble productLoads = 0.0.obs;
  RxInt timeDime = 0.obs;
  var scarcityModel = ScarcityProductsModel().obs;

  RxInt twoStepForm = 0.obs;

  RxString productId = ''.obs;
  RxBool requireName = false.obs;
  RxBool requirePhone = false.obs;

  /// EverLesson
  RxList<Map> chooseAccountEverLesson = [{}].obs;
  RxString selectedChooseAccount = "".obs;
  RxBool chooseAccountLoading = false.obs;

  RxList<Map> chooseMembershipEverLesson = [{}].obs;
  RxString selectedMemberShip = "".obs;
  RxBool chooseMemberShipLoading = false.obs;

  RxList<Map> chooseLevelEverLesson = [{}].obs;
  RxString selectedLevel = "".obs;
  RxBool chooseLevelLoading = false.obs;

  RxList<Map> chooseCourseEverLesson = [{}].obs;
  RxString selectedCourse = "".obs;
  RxBool chooseCourseLoading = false.obs;

  RxList<Map> chooseActionOptionEverLesson = [{}].obs;
  RxString selectedActionOption = "".obs;
  RxBool chooseActionOptionLoading = false.obs;

  RxString selectedCourseLevel = "course".obs;
  RxString selectedBumpOffer = "".obs;

  RxList<Map> dimeSalesGroup = [{}].obs;
  RxList<Map> timeSalesGroup = [{}].obs;
  RxString selectedDimeSaleGroup = "".obs;
  RxString selectedTimeSaleGroup = "".obs;

  /// Teachable
  RxList<Map> chooseAccountTeachable = [{}].obs;
  RxString selectedChooseAccountTeachable = "".obs;
  RxBool chooseAccountLoadingTeachable = false.obs;

  RxList<Map> chooseCourseTeachable = [{}].obs;
  RxString selectedCourseTeachable = "".obs;
  RxBool chooseCourseLoadingTeachable = false.obs;

  /// Lifter LMS
  RxList<Map> chooseAccountLifterLMS = [{}].obs;
  RxString selectedChooseAccountLifterLMS = "".obs;
  RxBool chooseAccountLoadingLifterLMS = false.obs;

  RxString selectedCourseMemberShip = "course".obs;

  RxList<Map> chooseCourseLifterLMS = [{}].obs;
  RxString selectedCourseLifterLMS = "".obs;
  RxBool chooseCourseLoadingLifterLMS = false.obs;

  RxList<Map> chooseMembershipLifterLMS = [{}].obs;
  RxString selectedMemberShipLifterLMS = "".obs;
  RxBool chooseMemberShipLoadingLifterLMS = false.obs;

  void updateProductTabSelected(int selectedTab) {
    isProductTabSelected.value = selectedTab;
    update();
  }
}

class GetProductDataBloc {
  StreamController<File> productImageController = PublishSubject<File>();
  StreamController<bool> productDisplayImageController = PublishSubject<bool>();

  Stream<File> get productImageStream => productImageController.stream;

  Stream<bool> get productDisplayImageStream =>
      productDisplayImageController.stream;

  Sink<File> get productImageSink => productImageController.sink;

  Sink<bool> get productDisplayImageSink => productDisplayImageController.sink;

  setProductImage(File image) => productImageSink.add(image);

  setProductDisplayImage(bool image) => productDisplayImageSink.add(image);

  void dispose() {
    productImageController.close();
    productDisplayImageController.close();
  }
}

final GetProductDataBloc getProductDataBloc = GetProductDataBloc();
