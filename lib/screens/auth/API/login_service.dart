import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/screens/dashboard/API/get_all_products.dart';
import 'package:mint_bird_app/screens/dashboard/API/get_chart_data.dart';
import 'package:mint_bird_app/screens/dashboard/dashboard.dart';
import 'package:mint_bird_app/screens/downsell/API/get_down_sell_groups_details.dart';
import 'package:mint_bird_app/screens/mange_tags/API/get_user_group_list.dart';
import 'package:mint_bird_app/screens/product/API/get_product_bump_offer_group_list.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../product/API/get_product_groups_details.dart';
import '../../upsell/API/get_upsell_groups_details.dart';
import 'get_user_connected_account.dart';
import 'get_user_detail.dart';

loginService(String email, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  authController.loading.value = true;
  var response = await http.post(
    Uri.parse(APIUtils.baseUrl + APIUtils.login),
    headers: {
      "Authorization": APIUtils.bearerToken,
    },
    body: {
      "email": email,
      "password": password,
    },
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> decodedData = jsonDecode(response.body);
    if (decodedData["code"] == 200) {
      prefs.setString("userToken", decodedData["access_token"]);
      authController.userToken.value = decodedData["access_token"];
      await getUserDetails();
      prefs.setBool("userLogged", true);
      authController.loading.value = false;
      getProductGroupsDetailsService();
      getUpsellGroupsDetailsService();
      getDownSellGroupsDetailsService();
      getUserConnectedAccountService();
      getBumpOfferGroupListService();
      getUserGroupList();
      getChartDataService();
      getAllProductsService();
      Get.offAll(() => DashBoard());
    } else if (decodedData["code"] == 422) {
      authController.loading.value = false;
      errorSnackBar("Invalid Credentials", decodedData["message"]);
    }
  } else {
    authController.loading.value = false;
    errorSnackBar("Something went wrong", "Please try again after some time");
  }
}
