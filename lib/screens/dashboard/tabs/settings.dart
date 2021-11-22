import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/auth/change_password.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';

class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 145,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(39)),
              color: mPrimaryColor1,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: mAccountHeaderColor,
                      size: 26,
                    ),
                    onPressed: () {
                      Get.back();
                    }),
                Text(
                  "SETTINGS",
                  style: GoogleFonts.poppins(
                      color: mBgColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                IconButton(
                    icon: Icon(
                      Icons.more_horiz_rounded,
                      color: mAccountHeaderColor,
                      size: 30,
                    ),
                    onPressed: () {}),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: () {
              Get.to(() => ChangePassword());
            },
            child: Container(
              width: Get.width,
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: mWhiteColor,
                border: Border.all(color: mborderColor, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Image.asset(
                          AppString.iconImagesPath + "ic_password.png",
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 12.0),
                        child: Text(
                          "Change Password",
                          style: TextStyle(
                              color: mTextColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0),
                        ),
                      )
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: mDrawerSnameColor,
                    size: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
