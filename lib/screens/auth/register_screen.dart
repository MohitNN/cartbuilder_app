import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/auth/API/register_service.dart';
import 'package:mint_bird_app/screens/auth/login_screen.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/utils/validator.dart';
import 'package:mint_bird_app/widgets/custom_buttons.dart';
import 'package:mint_bird_app/widgets/custom_textfield.dart';

import '../../widgets/loaders.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formFieldKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mBgColor,
        body: Stack(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              color: mBgColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: Get.height / 3.5,
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: mPrimaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(100),
                            bottomRight: Radius.circular(100),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppString.logoImagesPath + "mint_bird_logo.png",
                            height: 150.0,
                            width: 150.0,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin:
                          EdgeInsets.only(top: 6.0, left: 25.0, bottom: 6.0),
                      child: Text(
                        "Register",
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: mPrimaryColor),
                      ),
                    ),
                    registerFormWidget()
                  ],
                ),
              ),
            ),
            Obx(() {
              return authController.loading.value ? blurLoader : SizedBox();
            })
          ],
        ));
  }

  Widget registerFormWidget() {
    return Container(
      child: Form(
        key: formFieldKey,
        child: Column(
          children: [
            CustomTextField(
              controller: nameController,
              hintText: "Name",
              enabled: true,
              obscureText: false,
              prefixIcon: Icon(
                Icons.person,
                size: 24,
                color: mIconColor,
              ),
              validator: (val) {
                return FieldValidator.validateValueIsEmpty(val);
              },
            ),
            CustomTextField(
              controller: emailController,
              hintText: "E-Mail Address",
              enabled: true,
              obscureText: false,
              prefixIcon: Icon(
                Icons.mail,
                size: 24,
                color: mIconColor,
              ),
              validator: (val) {
                return FieldValidator.validateEmail(val);
              },
            ),
            CustomTextField(
              controller: phoneController,
              hintText: "Phone",
              enabled: true,
              obscureText: false,
              prefixIcon: Icon(
                Icons.phone_android,
                size: 24,
                color: mIconColor,
              ),
              validator: (val) {
                return FieldValidator.validatePhone(val);
              },
            ),
            CustomTextField(
              controller: passwordController,
              hintText: "Password",
              enabled: true,
              obscureText: true,
              prefixIcon: Icon(
                Icons.lock,
                size: 24,
                color: mIconColor,
              ),
              validator: (val) {
                return FieldValidator.validatePassword(val);
              },
            ),
            CustomTextField(
              controller: confirmPasswordController,
              hintText: "Confirm Password",
              enabled: true,
              obscureText: true,
              prefixIcon: Icon(
                Icons.lock,
                size: 24,
                color: mIconColor,
              ),
              validator: (val) {
                return FieldValidator.validateConfirmPassword(
                    val, passwordController.text);
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
                      AppString.have_account,
                      style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: mPrimaryColor.withOpacity(0.5)),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.off(() => LoginScreen());
                    },
                    child: Container(
                      child: Text(
                        AppString.login,
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: mPrimaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: loginBottomGradient,
              ),
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: CustomButton(
                  width: MediaQuery.of(context).size.width,
                  height: 57.0,
                  text: "Register",
                  onPressed: () {
                    onClickRegister();
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

  void onClickRegister() {
    final form = formFieldKey.currentState;
    if (form.validate()) {
      registerService(emailController.text, passwordController.text,
          phoneController.text, nameController.text);
      form.save();
    }
  }
}
