import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/time_sales/API/time_sale_list.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';

deleteTimeSale(String timeSaleId) async {
  DashboardController dashboardController = Get.put(DashboardController());
  var response = await http.post(
      Uri.parse(
        APIUtils.baseUrl + APIUtils.deleteTimeSale,
      ),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      },
      body: {
        "id": timeSaleId
      });
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    appSnackBar("Deleted Successfully", "Time Sale is deleted successfully");
    dashboardController.lastPage.value = 99;
    dashboardController.currentPage.value = 1;
    dashboardController.listOfTimesell.clear();
    getUserTimeSalesService();
  } else {
    errorSnackBar("Something went wrong", "Please try again!");
  }
}
