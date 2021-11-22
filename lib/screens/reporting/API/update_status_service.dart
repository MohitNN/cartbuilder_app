import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/screens/reporting/controller/reporting_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

import '../../../main.dart';

updateStatusService() async {
  ReportingController reportingController = Get.put(ReportingController());
  reportingController.loading.value = true;

  var response = await http.get(
      Uri.parse(APIUtils.baseUrl +
          APIUtils.updateStatus +
          "/${reportingController.transactionId.value}/${reportingController.tsStatus.value}"),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });
  print(response.statusCode);
  print(response.body);
  Map<String, dynamic> decodedData = jsonDecode(response.body);

  if (response.statusCode == 200) {
    if (decodedData["code"] == 200) {
      getToast(msg: "Status updated successfully");
    } else {
      errorSnackBar("Something went wrong", "Please try again after sometime");
    }
  } else {
    errorSnackBar("Something went wrong", "Please try again after sometime");
  }
  reportingController.loading.value = false;
}
