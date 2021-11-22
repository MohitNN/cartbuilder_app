import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/subscriptions/controller/subscriptions_controller.dart';
import 'package:mint_bird_app/screens/subscriptions/models/subscription_list_data_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';

getSubscriptionsServices() async {
  SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  subscriptionController.loading.value = true;
  print('***');

  print(APIUtils.baseUrl +
      APIUtils.getTransaction +
      "?page=${subscriptionController.currentPage.value}");
  var response = await http.get(
      Uri.parse(
        APIUtils.baseUrl +
            APIUtils.getSubscriptionsList +
            "?page=${subscriptionController.currentPage.value}",
      ),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["code"] == 200) {
      subscriptionController.lastPage.value =
          SubscriptionsListDataModel.fromJson(decodedData).response.lastPage;
      SubscriptionsListDataModel.fromJson(decodedData)
          .response
          .data
          .forEach((element) {
        subscriptionController.subscriptionsDetailList.add(element);
      });
      subscriptionController.currentPage.value =
          subscriptionController.currentPage.value + 1;
      subscriptionController.bottomLoader.value = false;
      subscriptionController.loading.value = false;
    } else {
      subscriptionController.loading.value = false;
      subscriptionController.bottomLoader.value = false;
      errorSnackBar("Something went wrong", "Please try again after sometime");
    }
  }
}
