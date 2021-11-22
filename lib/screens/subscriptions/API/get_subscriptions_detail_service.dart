import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/screens/subscriptions/controller/subscriptions_controller.dart';
import 'package:mint_bird_app/screens/subscriptions/models/subscription_detail_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';

import '../../../main.dart';

getSubscriptionsDetailServices(id) async {
  SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  subscriptionController.loading.value = true;

  var response = await http.get(
      Uri.parse(APIUtils.baseUrl + APIUtils.transactionDetail + "/$id"),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["code"] == 200) {
      subscriptionController.subscriptionsDetails.value =
          SubscriptionsDetailListDataModel.fromJson(decodedData);
      print(
          "*-*-*-**  ${subscriptionController.subscriptionsDetails.value.data.transaction.id}");
    } else {
      errorSnackBar("Something went wrong", "Please try again after sometime");
    }
  } else {
    errorSnackBar("Something went wrong", "Please try again after sometime");
  }
  subscriptionController.loading.value = false;
}
