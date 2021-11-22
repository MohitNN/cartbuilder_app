import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/dashboard/model/dashboard_chart.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

getChartDataService() async {
  DashboardController dashboardController = Get.put(DashboardController());
  dashboardController.isLoading.value = true;
  var response = await http.post(
    Uri.parse(APIUtils.baseUrl + APIUtils.getChartData),
    headers: {
      "Authorization": "Bearer ${authController.userToken.value}",
    },
    body: {"product_name": dashboardController.selectedProduct.value},
  );
  print("HHH ::: ${response.statusCode}");
  print("HHH ::: ${response.body}");
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (decodedData["code"] == 200) {
    DashboardChart dashboardChart = DashboardChart.fromJson(decodedData);
    if (dashboardChart.response == null) {
      dashboardController.chartData.clear();
      errorToast(msg: "Data is not available");
    } else {
      dashboardController.chartData.value =
          dashboardChart.response.entries.toList();
      int index = dashboardController.chartData.first.key.lastIndexOf("-");
      dashboardController.minX.value = int.parse(
          "${dashboardController.chartData.first.key[index + 1]}${dashboardController.chartData.first.key[index + 2]}");
      dashboardController.maxX.value = int.parse(
          "${dashboardController.chartData.last.key[index + 1]}${dashboardController.chartData.last.key[index + 2]}");
      dashboardController.yPoints.value = dashboardChart.xPoints;
      dashboardController.maxValue.value = dashboardChart.maxValue;
    }
    dashboardController.isLoading.value = false;
  } else {
    dashboardController.isLoading.value = false;
  }
}
