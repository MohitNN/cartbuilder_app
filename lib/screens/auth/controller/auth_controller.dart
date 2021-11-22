import 'dart:convert';

import 'package:get/get.dart';
import 'package:mint_bird_app/screens/auth/API/get_user_connected_account.dart';
import 'package:mint_bird_app/screens/auth/API/get_user_detail.dart';
import 'package:mint_bird_app/screens/auth/models/user_detail_model.dart';
import 'package:mint_bird_app/screens/auth/models/user_model.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/downsell/API/get_down_sell_groups_details.dart';
import 'package:mint_bird_app/screens/funnel/API/get_funnel_group.dart';
import 'package:mint_bird_app/screens/mange_tags/API/get_user_group_list.dart';
import 'package:mint_bird_app/screens/product/API/get_product_bump_offer_group_list.dart';
import 'package:mint_bird_app/screens/product/API/get_product_groups_details.dart';
import 'package:mint_bird_app/screens/upsell/API/get_upsell_groups_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  RxBool loading = false.obs;
  Rx<UserModel> userModel = UserModel().obs;
  RxString userToken = "".obs;
  Rx<UserDetailModel> userDetailModel = UserDetailModel().obs;
  DashboardController dashboardController = Get.put(DashboardController());

  getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString("userResponse") != null) {
      userModel.value =
          UserModel.fromJson(jsonDecode(pref.getString("userResponse")));
    }
    if (pref.getString("userToken") != null) {
      userToken.value = pref.getString("userToken");
      getUserDetails();
      dashboardController.getTagList();
      getUpsellGroupsDetailsService();
      getDownSellGroupsDetailsService();
      getUserConnectedAccountService();
      getProductGroupsDetailsService();
      getFunnelGroupService();
      getBumpOfferGroupListService();
      getUserGroupList();
    }
  }
}
