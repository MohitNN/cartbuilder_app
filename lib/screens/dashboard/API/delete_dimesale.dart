import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/dime_sales/API/get_dime_sales.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';

deleteDimeSale(String dimeSaleId) async {
  DashboardController dashboardController = Get.put(DashboardController());
  var response = await http.post(
      Uri.parse(
        APIUtils.baseUrl + APIUtils.deleteDimeSale,
      ),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      },
      body: {
        "id": dimeSaleId
      });
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    appSnackBar("Deleted Successfully", "Dime Sale is deleted successfully");
    dashboardController.lastPage.value = 99;
    dashboardController.currentPage.value = 1;
    dashboardController.listOfDimeSale.clear();
    getUserDimeSalesService();
  } else {
    errorSnackBar("Something went wrong", "Please try again!");
  }
}
