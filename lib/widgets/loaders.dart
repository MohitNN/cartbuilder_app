import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

Widget appLoader = Container(
  alignment: Alignment.center,
  child: Lottie.asset("assets/animations/loader.json", width: Get.width / 3),
);
Widget blurLoader = BackdropFilter(
  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
  child: Container(alignment: Alignment.center, child: appLoader),
);
