import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mint_bird_app/utils/m_colors.dart';

import 'custom_buttons.dart';

showSuccessModalSheet(context, title) {
  showModalBottomSheet<int>(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: mWhiteColor,
          borderRadius: BorderRadius.circular(21.0),
        ),
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Lottie.asset(
                "assets/animations/success_min.json",
                repeat: false,
                height: 174.0,
                width: 174.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Success!',
                style: TextStyle(
                  fontSize: 31,
                  color: mFunnelLableColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 52),
              child: Text(
                'You have created your $title. You will find all of the ${title}s that have been added to your sales $title library.',
                style: TextStyle(
                  fontSize: 16,
                  color: mFunnelLableColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: CustomButton(
                width: Get.width / 1.3,
                height: 56.0,
                text: "DONE".toUpperCase(),
                onPressed: () {
                  Get.back();
                },
                textColor: mWhiteColor,
              ),
            ),
          ],
        ),
      );
    },
  );
}
