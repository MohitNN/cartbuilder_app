import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/time_sales/API/time_sale_list.dart';
import 'package:mint_bird_app/screens/time_sales/controller/timesell_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

Future<bool> updateTimeSalesProduct(String body) async {
  TimeSellController timeSellController = Get.put(TimeSellController());
  DashboardController dashboardController = Get.put(DashboardController());
  var response = await http.post(
      Uri.parse(APIUtils.baseUrl + APIUtils.updateTimeSaleProduct),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      },
      body: {
        "sales": body
      });
  print(body);
  print(response.statusCode);
  print(response.body);
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["status"] == "Success") {
      timeSellController.detailLoader.value = false;
      getToast(msg: "Updated Successfully");
      dashboardController.listOfTimesell.clear();
      dashboardController.currentPage.value = 1;
      dashboardController.lastPage.value = 0;
      getUserTimeSalesService();
      return true;
    } else {
      timeSellController.detailLoader.value = false;
      getToast(msg: "Something went wrong");
      return false;
    }
  } else {
    timeSellController.detailLoader.value = false;
    return false;
  }
}
