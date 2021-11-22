import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/auth/API/get_user_detail.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

updateProfileDetail({String imagePath}) async {
  DashboardController dashboardController = Get.put(DashboardController());
  dashboardController.accountLoading.value = true;
  var response = await http.post(
      Uri.parse(APIUtils.baseUrl + APIUtils.updateProfileDetail),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      },
      body: {
        'username': '',
        'name': '',
        'email': '',
        'phone': '',
        'address': '',
        'business_name': '',
      });

  print(response.statusCode);
  if (response.statusCode == 200) {
    await getUserDetails();
    getToast(msg: "Profile updated successfully");
    dashboardController.accountLoading.value = false;
  } else {
    dashboardController.accountLoading.value = false;
    errorSnackBar("Something went wrong!", "Please try again later");
  }
}
