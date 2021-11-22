import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/screens/auth/models/user_model.dart';
import 'package:mint_bird_app/screens/dashboard/API/get_all_products.dart';
import 'package:mint_bird_app/screens/dashboard/API/get_chart_data.dart';
import 'package:mint_bird_app/screens/dashboard/dashboard.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

registerService(
    String email, String password, String mobile, String name) async {
  authController.loading.value = true;
  var response = await http
      .post(Uri.parse(APIUtils.baseUrl + APIUtils.register), headers: {
    "Authorization": APIUtils.bearerToken,
  }, body: {
    "email": email,
    "password": password,
    "mobile": mobile,
    "name": name,
    "password_confirmation": password
  });

  if (response.statusCode == 200) {
    Map<String, dynamic> decodedData = jsonDecode(response.body);
    if (decodedData["code"] == 200) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("userResponse", response.body);
      authController.userModel.value = UserModel.fromJson(decodedData);
      pref.setString("userId", authController.userModel.value.data.id);
      pref.setBool("userLogged", true);
      authController.loading.value = false;
      getChartDataService();
      getAllProductsService();

      Get.offAll(() => DashBoard());
    } else if (decodedData["code"] == 422) {
      authController.loading.value = false;
      errorSnackBar(
          "Email is Already been taken", "Please try different email");
    }
  } else {
    authController.loading.value = false;
    errorSnackBar("Something went wrong", "Please try again after some time");
  }
}
