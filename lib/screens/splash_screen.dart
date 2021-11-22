import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mint_bird_app/screens/dashboard/API/get_all_products.dart';
import 'package:mint_bird_app/screens/dashboard/API/get_chart_data.dart';
import 'package:mint_bird_app/screens/dashboard/dashboard.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final formFieldKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigate();
  }

  navigate() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Future.delayed(Duration(seconds: 3), () {
      if (pref.getBool("userLogged") ?? false) {
        getChartDataService();
        getAllProductsService();
        Get.off(() => DashBoard());
      } else {
        Get.off(() => LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(),
          child: Image(
            image: AssetImage(AppString.gifImagesPath + "ic_splash_anim.gif"),
            fit: BoxFit.fill,
          )),
    );
  }
}
