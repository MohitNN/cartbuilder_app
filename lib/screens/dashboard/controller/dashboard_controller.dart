import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/screens/bump_offers/models/bump_offer_model.dart';
import 'package:mint_bird_app/screens/dashboard/model/all_products_model.dart';
import 'package:mint_bird_app/screens/dime_sales/models/dime_sales_model.dart';
import 'package:mint_bird_app/screens/downsell/models/user_downsell_model.dart';
import 'package:mint_bird_app/screens/funnel/model/user_funnel_model.dart';
import 'package:mint_bird_app/screens/product/models/tag_list_model.dart';
import 'package:mint_bird_app/screens/product/models/user_product_model.dart';
import 'package:mint_bird_app/screens/time_sales/models/time_sales_model.dart';
import 'package:mint_bird_app/screens/upsell/models/user_upsell_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/utils/app_strings.dart';

import '../../../main.dart';

class DashboardController extends GetxController {
  RxInt bottomIndex = 0.obs;
  RxString appBarTitle = AppString.home.obs;
  RxString searchQuery = "".obs;
  RxInt drawerSelectedIndex = 0.obs;
  RxInt drawerInd = 0.obs;
  Rx<PageController> pageController = PageController().obs;
  Rx<GlobalKey<ScaffoldState>> scaffoldKey = GlobalKey<ScaffoldState>().obs;
  RxBool isReport = false.obs;
  RxInt currentPage = 1.obs;
  RxInt lastPage = 0.obs;
  RxBool isSearch = false.obs;
  RxBool isLoading = false.obs;
  RxBool bottomLoader = false.obs;
  RxBool accountLoading = false.obs;
  RxString selectedTimeSaleId = "".obs;
  RxString selectedDimeSaleId = "".obs;
  RxList<TimesellUpsell> selectedTimeSales = <TimesellUpsell>[].obs;
  RxList<DimeSalesUpsell> selectedDimeSales = <DimeSalesUpsell>[].obs;
  RxString profilePicturePath =
      "https://miro.medium.com/max/785/0*Ggt-XwliwAO6QURi.jpg".obs;

  RxList<ProductData> listOfProduct = <ProductData>[].obs;
  RxList<UpSellDatum> listOfUpsell = <UpSellDatum>[].obs;
  RxList<DownSellDatum> listOfDownsell = <DownSellDatum>[].obs;
  RxList<FunnelDatum> listOfFunnel = <FunnelDatum>[].obs;
  RxList<BumpOffer> listOfBumpOffers = <BumpOffer>[].obs;
  RxList<DimeSalesUpsell> listOfDimeSale = <DimeSalesUpsell>[].obs;
  RxList<TimesellUpsell> listOfTimesell = <TimesellUpsell>[].obs;

  RxList<Tags> tagList = <Tags>[Tags(tagId: '0', tagName: 'Select Tag')].obs;
  RxString selectedTagList = "".obs;

  RxList<MapEntry<dynamic, dynamic>> chartData =
      <MapEntry<dynamic, dynamic>>[].obs;

  RxMap<String, dynamic> yPoints = <String, dynamic>{}.obs;
  RxInt maxValue = 10000.obs;
  RxInt minX = 1.obs;
  RxInt maxX = 31.obs;

  RxList<AllProduct> allProducts =
      <AllProduct>[AllProduct(id: "0", productName: "Select Product")].obs;
  RxString selectedProduct = "0".obs;

  getTagList() async {
    isLoading.value = true;
    var response = await http
        .get(Uri.parse(APIUtils.baseUrl + APIUtils.getTagList), headers: {
      "Authorization": "Bearer ${authController.userToken.value}",
    });
    Map<String, dynamic> decodedData = jsonDecode(response.body);
    print("//// $decodedData");
    if (response.statusCode == 200) {
      if (decodedData["code"] == 200) {
        tagList = TagListModel.fromJson(decodedData).response.obs;
        selectedTagList = tagList.first.tagId.obs;
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    }
  }
}
