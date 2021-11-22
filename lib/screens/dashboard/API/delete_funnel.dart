import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/funnel/API/get_funnel.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';

deleteFunnel(String funnelId) async {
  DashboardController dashboardController = Get.put(DashboardController());
  var response = await http.delete(
    Uri.parse(
      APIUtils.baseUrl + APIUtils.deleteFunnel + funnelId,
    ),
    headers: {
      "Authorization": "Bearer ${authController.userToken.value}",
    },
  );
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    appSnackBar("Deleted Successfully", "Funnel is deleted successfully");
    dashboardController.lastPage.value = 99;
    dashboardController.currentPage.value = 1;
    dashboardController.listOfFunnel.clear();
    getUserFunnelService();
  } else {
    errorSnackBar("Something went wrong", "Please try again!");
  }
}
