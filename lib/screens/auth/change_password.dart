import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/auth/API/forgot_password_service.dart';
import 'package:mint_bird_app/screens/auth/login_screen.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/widgets/custom_buttons.dart';
import 'package:mint_bird_app/widgets/custom_textfield.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

import '../../main.dart';
import '../../widgets/loaders.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final formFieldKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: mBgColor,
      body: Container(
        height: Get.height,
        width: Get.width,
        color: mBgColor,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: Get.height / 3.3,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: mPrimaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(70),
                        bottomRight: Radius.circular(70),
                      )),
                  child: Image.asset(
                    AppString.logoImagesPath + "mint_bird_logo.png",
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                loginFormWidget(),
              ],
            ),
            Obx(() {
              return authController.loading.value
                  ? BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.white.withOpacity(0.5),
                        child: appLoader,
                      ),
                    )
                  : SizedBox();
            })
          ],
        ),
      ),
    );
  }

  Widget loginFormWidget() {
    return Expanded(
      flex: 1,
      child: Form(
        key: formFieldKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 6.0, left: 28.0, bottom: 6.0),
              child: Text(
                "Forgot Password",
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: mPrimaryColor),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            CustomTextField(
              controller: emailController,
              hintText: "Enter email",
              enabled: true,
              obscureText: false,
              prefixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
                child: Image.asset(
                  AppString.iconImagesPath + "ic_user.png",
                  width: 4,
                  height: 4,
                  fit: BoxFit.fill,
                ),
              ),
              validator: (val) {
                if (val.isEmpty) {
                  return "email is Required";
                }
                return null;
              },
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                gradient: loginBottomGradient,
              ),
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: CustomButton(
                  width: MediaQuery.of(context).size.width,
                  height: 55.0,
                  text: "Send email",
                  onPressed: () {
                    onClickForgotPwd();
                  },
                  textColor: mWhiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onClickForgotPwd() {
    final form = formFieldKey.currentState;
    if (form.validate()) {
      form.save();
      forgotPasswordService(emailController.text).then((value) {
        getToast(msg: value["message"]);
        if (value["status"] == true) {
          Get.to(() => LoginScreen());
        }
      });
    }
  }
}
