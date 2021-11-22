import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/auth/login_screen.dart';
import 'package:mint_bird_app/screens/dashboard/tabs/settings.dart';
import 'package:mint_bird_app/screens/downsell/API/get_user_downsell.dart';
import 'package:mint_bird_app/screens/funnel/API/get_funnel.dart';
import 'package:mint_bird_app/screens/mange_tags/manege_tags.dart';
import 'package:mint_bird_app/screens/product/API/get_user_product.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/screens/reporting/tabs/report_dashboard.dart';
import 'package:mint_bird_app/screens/subscriptions/subscriptions.dart';
import 'package:mint_bird_app/screens/upsell/API/get_user_upsell.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../controller/dashboard_controller.dart';

Widget appDrawer() {
  ProductController productController = Get.put(ProductController());
  DashboardController dashboardController = Get.put(DashboardController());
  return Container(
    width: Get.width / 1.5,
    child: Drawer(
      child: Column(
        children: [
          _createHeader(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25),
                    InkWell(
                      onTap: () {
                        Get.back();
                        dashboardController.pageController.value.animateToPage(
                            3,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease);
                        dashboardController.bottomIndex.value = 3;
                        dashboardController.drawerSelectedIndex.value = 99;
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 84,
                              width: 84,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: mBtnColor,
                                  width: 1.5,
                                ),
                              ),
                              child: Text(
                                authController.userDetailModel.value.data ==
                                        null
                                    ? ''
                                    : authController
                                        .userDetailModel.value.data.name[0]
                                        .toUpperCase(),
                                style: TextStyle(
                                  color: mBtnColor,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Obx(
                              () {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      authController.userDetailModel.value?.data
                                                  ?.name ==
                                              null
                                          ? "No name"
                                          : authController
                                              .userDetailModel.value.data.name,
                                      style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        color: mPrimaryColor1,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    authController.userDetailModel.value.data
                                                .businessName ==
                                            null
                                        ? SizedBox()
                                        : Text(
                                            authController.userDetailModel.value
                                                    .data.businessName ??
                                                "",
                                            style: GoogleFonts.roboto(
                                              fontSize: 15,
                                              color: mDrawerSnameColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                  ],
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    _createDrawerItem(
                        icon: "ic_home.png",
                        text: 'Home',
                        isSelected: 0,
                        onTap: () {
                          Get.back();
                          dashboardController.pageController.value
                              .animateToPage(0,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInCubic);
                          dashboardController.bottomIndex.value = 0;
                          dashboardController.drawerSelectedIndex.value = 0;
                        }),
                    _createDrawerItem(
                        icon: "ic_product.png",
                        isSelected: 1,
                        text: 'Order Forms',
                        onTap: () {
                          Get.back();
                          getUserProductService();
                          dashboardController.pageController.value
                              .animateToPage(1,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInCubic);

                          dashboardController.bottomIndex.value = 1;
                          dashboardController.drawerSelectedIndex.value = 1;
                          productController.isProductTabSelected.value = 0;
                        }),
                    _createDrawerItem(
                        icon: "ic_funnel.png",
                        isSelected: 2,
                        text: 'Funnel',
                        onTap: () {
                          Get.back();
                          getUserFunnelService();
                          dashboardController.pageController.value
                              .animateToPage(2,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.ease);
                          dashboardController.bottomIndex.value = 2;
                          dashboardController.drawerSelectedIndex.value = 2;
                        }),
                    _createDrawerItem(
                        icon: "ic_upsell.png",
                        text: 'UpSells',
                        isSelected: 3,
                        onTap: () {
                          Get.back();
                          getUserUpSellService();
                          dashboardController.pageController.value
                              .animateToPage(1,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInCubic);
                          dashboardController.bottomIndex.value = 1;
                          dashboardController.drawerSelectedIndex.value = 3;
                          productController.isProductTabSelected.value = 1;
                        }),
                    _createDrawerItem(
                        icon: "ic_downsell.png",
                        text: 'DownSells',
                        isSelected: 4,
                        onTap: () {
                          Get.back();
                          getUserDownSellService();
                          dashboardController.pageController.value
                              .animateToPage(1,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInCubic);
                          dashboardController.bottomIndex.value = 1;
                          dashboardController.drawerSelectedIndex.value = 4;
                          productController.isProductTabSelected.value = 2;
                        }),
                    _createDrawerItem(
                        icon: "ic_tags.png",
                        text: 'Manage Tags',
                        isSelected: 5,
                        onTap: () {
                          Get.back();
                          dashboardController.isReport.value = true;
                          dashboardController.drawerSelectedIndex.value = 5;
                          dashboardController.bottomIndex.value = 0;
                          Get.to(ManageTags());
                        }),
                    _createDrawerItem(
                        icon: "ic_subscription_home.png",
                        text: 'Subscriptions',
                        isSelected: 6,
                        onTap: () {
                          Get.back();
                          dashboardController.isReport.value = true;
                          dashboardController.drawerSelectedIndex.value = 6;
                          dashboardController.bottomIndex.value = 3;
                          Get.to(Subscriptions());
                        }),
                    _createDrawerItem(
                        icon: "ic_reporting.png",
                        text: 'Reporting',
                        isSelected: 7,
                        onTap: () {
                          Get.back();
                          dashboardController.isReport.value = true;
                          dashboardController.drawerSelectedIndex.value = 7;
                          dashboardController.bottomIndex.value = 3;
                          Get.to(ReportDashBoard());
                          // dashboardController.pageController.value.animateToPage(
                          //     4,
                          //     duration: Duration(milliseconds: 300),
                          //     curve: Curves.ease);
                        }),
                    Divider(
                      height: 1.5,
                      thickness: 1.5,
                      color: mAccountHeaderColor,
                    ),
                    _createDrawerItem(
                        icon: "ic_dashboard.png",
                        text: 'App Center',
                        isSelected: 8,
                        onTap: () {
                          Get.back();
                          dashboardController.drawerSelectedIndex.value = 8;
                        }),
                    _createDrawerItem(
                        icon: "ic_notification.png",
                        text: 'Notification',
                        isSelected: 9,
                        onTap: () {
                          Get.back();
                          dashboardController.drawerSelectedIndex.value = 9;
                        }),
                    _createDrawerItem(
                        icon: "ic_setting.png",
                        text: 'Settings',
                        isSelected: 10,
                        onTap: () {
                          Get.to(() => Settings());
                          dashboardController.drawerSelectedIndex.value = 10;
                        }),
                    _createDrawerItem(
                        icon: "ic_logout.png",
                        text: 'Log out',
                        isSelected: 11,
                        onTap: () async {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.clear();
                          Get.offAll(() => LoginScreen());
                        }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _createHeader() {
  return Container(
    height: 100,
    padding: EdgeInsets.only(top: 30.0, left: 10.0),
    decoration: BoxDecoration(
      color: mPrimaryColor,
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(30.0),
      ),
    ),
    child: Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: mBgColor,
              size: 20,
            ),
          ),
        ),
        Center(
          child: Image.asset(
            AppString.iconImagesPath + 'ic_bird.png',
            height: 35,
            width: 40,
          ),
        )
      ],
    ),
  );
}

Widget _createDrawerItem({
  String icon,
  String text,
  GestureTapCallback onTap,
  int isSelected,
}) {
  DashboardController dashboardController = Get.put(DashboardController());

  return Obx(() {
    return Container(
      decoration: BoxDecoration(
        color: dashboardController.drawerSelectedIndex.value == isSelected
            ? mBtnColor.withOpacity(0.08)
            : Colors.transparent,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(11),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.horizontal(left: Radius.circular(11)),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 18.0,
              horizontal: 23.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  AppString.iconImagesPath + icon,
                  height: 24,
                  width: 24,
                  color: dashboardController.drawerSelectedIndex.value ==
                          isSelected
                      ? mBtnColor
                      : mDrawerSnameColor,
                ),
                SizedBox(width: 27.0),
                Text(
                  text,
                  style: GoogleFonts.roboto(
                    fontSize: 19,
                    color: dashboardController.drawerSelectedIndex.value ==
                            isSelected
                        ? mBtnColor
                        : mDrawerSnameColor,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  });
}
