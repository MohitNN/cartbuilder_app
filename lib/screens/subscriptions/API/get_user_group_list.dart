import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/subscriptions/controller/subscriptions_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';

getSubscriptionData() async {
  SubscriptionController subscriptionController =
      Get.put(SubscriptionController());

  subscriptionController.loading.value = true;
  var response = await http
      .get(Uri.parse(APIUtils.baseUrl + APIUtils.getSubscriptions), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  });

  Map<String, dynamic> decodedData = jsonDecode(response.body);
  print(decodedData);
  if (response.statusCode == 200) {
    if (decodedData["status"] == 'Success') {
      subscriptionController.subscription.value =
          decodedData['response']['subscriptions'].toString();
      subscriptionController.mrr.value = decodedData['response']['mrr'].toString();
      subscriptionController.yearlyRevenue.value =
          decodedData['response']['yearly_revenue'].toString();
      subscriptionController.loading.value = false;
    } else {
      subscriptionController.loading.value = false;
      errorSnackBar("Something went wrong", "Please try again after sometime");
    }
  }
}
