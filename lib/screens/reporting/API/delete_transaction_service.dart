import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/reporting/API/get_transaction_service.dart';
import 'package:mint_bird_app/screens/reporting/controller/reporting_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

deleteTransactionServices(String id) async {
  ReportingController reportingController = Get.put(ReportingController());
  reportingController.loading.value = true;
  var response = await http.get(
      Uri.parse(APIUtils.baseUrl + APIUtils.deleteTransaction + "/$id"),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["code"] == 200) {
      reportingController.loading.value = false;
      getTransactionServices();
      getToast(msg: "Deleted successfully");
    } else {
      reportingController.loading.value = false;
      errorSnackBar("Something went wrong", "Please try again after sometime");
    }
  }
}
