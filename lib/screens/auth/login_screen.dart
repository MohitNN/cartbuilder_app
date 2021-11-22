import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/auth/API/login_service.dart';
import 'package:mint_bird_app/screens/auth/forgot_password.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/utils/validator.dart';
import 'package:mint_bird_app/widgets/custom_buttons.dart';
import 'package:mint_bird_app/widgets/custom_textfield.dart';

import '../../main.dart';
import '../../widgets/loaders.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formFieldKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: mBgColor,
      body: Stack(
        children: [
          Container(
            width: Get.width,
            color: mBgColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                Expanded(child: loginFormWidget()),
              ],
            ),
          ),
          Obx(
            () {
              return authController.loading.value ? blurLoader : SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget loginFormWidget() {
    return Form(
      key: formFieldKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            controller: emailController,
            hintText: "Username",
            enabled: true,
            obscureText: false,
            prefixIcon: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
              child: Image.asset(
                AppString.iconImagesPath + "ic_user.png",
                width: 4,
                height: 4,
                color: mIconColor,
                fit: BoxFit.fill,
              ),
            ),
            validator: (val) {
              if (val.isEmpty) {
                return "Email is Required";
              }
              return null;
            },
          ),
          CustomTextField(
            controller: passwordController,
            hintText: "Password",
            enabled: true,
            obscureText: true,
            prefixIcon: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
              child: Image.asset(
                AppString.iconImagesPath + "ic_password.png",
                width: 4,
                height: 4,
                color: mIconColor,
                fit: BoxFit.fill,
              ),
            ),
            suffixIcon: InkWell(
              onTap: () {
                Get.to(() => ForgotPassword());
              },
              child: Container(
                  margin: EdgeInsets.only(top: 12.0),
                  child: Text(
                    "Forgot?",
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: mPrimaryColor1,
                    ),
                  )),
            ),
            validator: (val) {
              return FieldValidator.validatePassword(val);
            },
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    AppString.dont_have_account,
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: mDrawerUnameColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(RegisterScreen());
                  },
                  child: Container(
                    child: Text(
                      AppString.signUP,
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: mPrimaryColor1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Spacer(),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  gradient: loginBottomGradient,
                ),
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: CustomButton(
                    width: MediaQuery.of(context).size.width,
                    height: 57.0,
                    text: "LOGIN",
                    onPressed: () {
                      onClickLogin();
                    },
                    textColor: mWhiteColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onClickLogin() {
    final form = formFieldKey.currentState;
    if (form.validate()) {
      form.save();
      loginService(emailController.text, passwordController.text);
    }
  }
}
