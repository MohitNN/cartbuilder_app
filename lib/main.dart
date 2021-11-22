import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mint_bird_app/screens/auth/controller/auth_controller.dart';

import 'screens/splash_screen.dart';

AuthController authController = Get.put(AuthController());
void main() {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();
  authController.getUserData();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mint Bird',
      home: SplashScreen(),
    );
  }
}
