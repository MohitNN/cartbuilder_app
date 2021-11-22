import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/funnel/API/get_funnel.dart';
import 'package:mint_bird_app/screens/product/API/get_user_product.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';

Widget bottomNavigationBar() {
  DashboardController dashboardController = Get.put(DashboardController());

  final iconList = <String>[
    AppString.iconImagesPath + "ic_home.png",
    AppString.iconImagesPath + "ic_product.png",
    AppString.iconImagesPath + "ic_funnel.png",
    AppString.iconImagesPath + "ic_account.png",
  ];

  final stringIconList = <String>[
    "Home",
    "Library",
    "Sale Funnel",
    "Account",
  ];

  return AnimatedBottomNavigationBar.builder(
      elevation: 40.0,
      itemCount: iconList.length,
      tabBuilder: (int index, bool isActive) {
        return Obx(
          () {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                dashboardController.bottomIndex.value == index
                    ? Container(
                        color: mBtnColor,
                        width: 20.0,
                        height: 2.0,
                      )
                    : Container(
                        width: 20.0,
                        height: 2.0,
                      ),
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  child: Image.asset(
                    iconList[index],
                    height: 20.0,
                    width: 20.0,
                    color: dashboardController.bottomIndex.value == index
                        ? mBtnColor
                        : mIconColor.withOpacity(0.5),
                  ),
                ),
                SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    stringIconList[index],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: dashboardController.bottomIndex.value == index
                          ? mBtnColor
                          : mIconColor.withOpacity(0.5),
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
      backgroundColor: mWhiteColor,
      activeIndex: dashboardController.bottomIndex.value,
      splashColor: mPrimaryColor,
      splashSpeedInMilliseconds: 100,
      notchSmoothness: NotchSmoothness.softEdge,
      gapLocation: GapLocation.center,
      notchMargin: 10,
      gapWidth: 40,
      leftCornerRadius: 35,
      rightCornerRadius: 35,
      onTap: (index) {
        dashboardController.pageController.value.animateToPage(index,
            duration: Duration(milliseconds: 300), curve: Curves.ease);
        dashboardController.bottomIndex.value = index;
        if (index == 1) {
          dashboardController.searchQuery.value = "";
          dashboardController.currentPage.value = 1;
          getUserProductService();
        } else {
          dashboardController.listOfFunnel.clear();
          dashboardController.currentPage.value = 1;
          dashboardController.lastPage.value = 0;
          dashboardController.searchQuery.value = "";
          getUserFunnelService();
        }
      });
}
