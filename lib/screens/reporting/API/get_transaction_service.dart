import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/reporting/controller/reporting_controller.dart';
import 'package:mint_bird_app/screens/reporting/models/transaction_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';

getTransactionServices() async {
  ReportingController reportingController = Get.put(ReportingController());
  reportingController.loading.value = true;
  var response = await http.get(
      Uri.parse(
        APIUtils.baseUrl +
            APIUtils.getTransaction +
            "?page=${reportingController.currentPage.value}",
      ),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["code"] == 200) {
      reportingController.lastPage.value =
          TransactionModel.fromJson(decodedData).data.records.lastPage;
      TransactionModel.fromJson(decodedData)
          .data
          .records
          .data
          .forEach((element) {
        reportingController.recordList.add(element);
      });
      reportingController.currentPage.value =
          reportingController.currentPage.value + 1;
      reportingController.bottomLoader.value = false;
      reportingController.loading.value = false;
    } else {
      reportingController.loading.value = false;
      reportingController.bottomLoader.value = false;
      errorSnackBar("Something went wrong", "Please try again after sometime");
    }
  }
}
