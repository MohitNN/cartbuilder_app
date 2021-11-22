import 'package:flutter/material.dart';
import 'package:get/get.dart';

errorSnackBar(title, msg) {
  Get.snackbar(title, msg,
      backgroundColor: Colors.redAccent,
      borderRadius: 0,
      margin: EdgeInsets.zero,
      icon: Icon(
        Icons.warning,
        color: Colors.white,
      ),
      shouldIconPulse: true,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white);
}

appSnackBar(title, msg) {
  Get.snackbar(title, msg,
      backgroundColor: Colors.green,
      borderRadius: 0,
      margin: EdgeInsets.zero,
      icon: Icon(
        Icons.check_circle,
        color: Colors.white,
      ),
      shouldIconPulse: true,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white);
}
