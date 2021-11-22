import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/bump_offers/models/bump_offer_model.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

getUserBumpOffersService() async {
  DashboardController dashboardController = Get.put(DashboardController());
  dashboardController.isLoading.value = true;
  var response = await http.get(
      Uri.parse(APIUtils.baseUrl +
          APIUtils.getBumpOffers +
          "${dashboardController.searchQuery.value.length > 0 ? "?search=${dashboardController.searchQuery.value}" : ""}" +
          "${dashboardController.currentPage.value == 1 && dashboardController.searchQuery.value.length > 0 ? "" : "?page=${dashboardController.currentPage.value}"}"),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (decodedData["code"] == 200) {
    BumpOfferModel bumpOfferModel = BumpOfferModel.fromJson(decodedData);
    dashboardController.lastPage.value = bumpOfferModel.lastPage;
    dashboardController.currentPage.value =
        dashboardController.currentPage.value + 1;
    bumpOfferModel.bumpOffer.forEach((element) {
      dashboardController.listOfBumpOffers.add(element);
    });
    dashboardController.isLoading.value = false;
    dashboardController.bottomLoader.value = false;
  } else {
    dashboardController.isLoading.value = false;
    dashboardController.bottomLoader.value = false;
  }
}
