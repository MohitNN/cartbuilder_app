import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/auth/login_screen.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/dashboard/tabs/account/API/update_profile_photo.dart';
import 'package:mint_bird_app/screens/dashboard/tabs/settings.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountTab extends StatefulWidget {
  @override
  _AccountTabState createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  DashboardController dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Obx(() {
      return Stack(
        children: [
          Container(
            height: (Get.height * 0.17),
            width: Get.width,
            decoration: BoxDecoration(
              color: mAccountHeaderColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(39),
              ),
            ),
          ),
          Container(
            color: mAccountHeaderColor,
            child: Padding(
              padding: EdgeInsets.only(
                left: 10,
                top: 12,
                right: 16,
                bottom: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      dashboardController.scaffoldKey.value.currentState
                          .openDrawer();
                    },
                    icon: Icon(
                      Icons.dehaze,
                      color: mbackColor,
                    ),
                  ),
                  PopupMenuButton<String>(
                    iconSize: 35,
                    icon: Icon(
                      Icons.more_horiz_rounded,
                      color: mbackColor,
                    ),
                    onSelected: (value) async {
                      if (value == "Logout") {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.clear();
                        Get.offAll(() => LoginScreen());
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return {'Logout', 'Settings'}.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 74.0, left: 24.0, right: 24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Stack(
                      children: <Widget>[
                        Obx(() {
                          return Container(
                            alignment: Alignment.center,
                            height: 96,
                            width: 96,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color: mBtnColor),
                            ),
                            foregroundDecoration: authController.userDetailModel
                                        .value.data.profilePic ==
                                    null
                                ? null
                                : BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "http://app.mintbird.com/public/img/profile/${authController.userDetailModel.value.data.profilePic}"),
                                        fit: BoxFit.cover)),
                            child: Text(
                              authController.userDetailModel.value.data.name[0]
                                  .toUpperCase(),
                              style: TextStyle(
                                color: mBtnColor,
                                fontSize: 30,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          );
                        }),
                        Positioned(
                          bottom: 1,
                          right: 1,
                          child: dashboardController.accountLoading.value
                              ? SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator())
                              : GestureDetector(
                                  onTap: () async {
                                    List<Media> res = await ImagesPicker.pick(
                                      count: 1,
                                      pickType: PickType.image,
                                    );
                                    if (res != null) {
                                      updateProfilePhoto(
                                          imagePath: res.first.path);
                                    }
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    child: Icon(
                                      Icons.photo_camera_outlined,
                                      color: mWhiteColor,
                                      size: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: mBtnColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () {
                      return Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: Text(
                          authController.userDetailModel.value.data?.name ??
                              "No name",
                          style: TextStyle(
                            color: mDrawerUnameColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      authController.userDetailModel.value.data.businessName ??
                          "",
                      style: TextStyle(
                        color: mDrawerSnameColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      accountItemCardWidget(
                        imageName: "ic_account_img1.png",
                        title: "Everlesson",
                      ),
                      accountItemCardWidget(
                        imageName: "ic_account_img2.png",
                        title: "Easylinks",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      accountItemCardWidget(
                        imageName: "ic_account_img3.png",
                        title: "Competeup.io",
                      ),
                      accountItemCardWidget(
                        imageName: "ic_account_img4.png",
                        title: "Easylinks",
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => Settings());
                      },
                      child: Container(
                        width: Get.width,
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: mWhiteColor,
                          border: Border.all(color: mborderColor, width: 1.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: Image.asset(
                                AppString.iconImagesPath + "ic_setting.png",
                                height: 30.0,
                                width: 30.0,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 17.0),
                              child: Text(
                                "Settings",
                                style: TextStyle(
                                    color: mTextColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16.0),
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: mDrawerSnameColor,
                              size: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: InkWell(
                      onTap: () async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.clear();
                        Get.offAll(() => LoginScreen());
                      },
                      child: Container(
                        width: Get.width,
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: mWhiteColor,
                          border: Border.all(color: mborderColor, width: 1.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: Image.asset(
                                AppString.iconImagesPath + "ic_logout.png",
                                height: 30.0,
                                width: 30.0,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 17.0),
                              child: Text(
                                "Log Out",
                                style: TextStyle(
                                    color: mTextColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }));
  }

  Widget accountItemCardWidget({String imageName, String title}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Container(
          height: Get.height * 0.18,
          width: Get.width * 0.37,
          decoration: BoxDecoration(
            color: mWhiteColor,
            border: Border.all(color: mborderColor, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Container(
            padding: const EdgeInsets.only(
              left: 25.0,
              top: 30.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AppString.imagesAssetPath + imageName,
                  height: 45.0,
                  width: 45.0,
                ),
                Container(
                  margin: EdgeInsets.only(top: 13.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: mTextColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
