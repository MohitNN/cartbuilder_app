import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mint_bird_app/screens/bump_offers/controller/bump_offer_controller.dart';
import 'package:mint_bird_app/screens/dime_sales/dime_sale_details.dart';
import 'package:mint_bird_app/screens/upsell/widgets/show_color_picker.dart';
import 'package:mint_bird_app/utils/m_colors.dart';

class CustomOfferBox extends StatelessWidget {
  final BumpOfferController bumpOfferController =
      Get.put(BumpOfferController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Container(
            width: Get.width * 0.85,
            decoration: bumpOfferController.boxBorderWidth.value != 0
                ? DottedDecoration(
                    strokeWidth: bumpOfferController.boxBorderWidth.value,
                    dash: bumpOfferController.boxBorderDash,
                    shape: Shape.box,
                    color: bumpOfferController.borderColor.value,
                  )
                : BoxDecoration(
                    border: Border.all(
                      width: 3.0,
                      color: bumpOfferController.borderColor.value,
                    ),
                  ),
            child: Container(
              color: bumpOfferController.backgroundColor.value,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: bumpOfferController.buttonColor.value,
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_right_alt,
                          color: Colors.red,
                          size: 30.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Obx(
                            () => GestureDetector(
                              onTap: () {
                                bumpOfferController.doNotMissCheckBox.value =
                                    !bumpOfferController
                                        .doNotMissCheckBox.value;
                              },
                              child: Container(
                                color: mWhiteColor,
                                height: 25,
                                width: 25,
                                alignment: Alignment.center,
                                child:
                                    bumpOfferController.doNotMissCheckBox.value
                                        ? Icon(
                                            Icons.done,
                                            color: Colors.red,
                                          )
                                        : Container(
                                            height: 25,
                                            width: 25,
                                          ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller:
                                bumpOfferController.buttonTextController.value,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(),
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Enter Missing content',
                            ),
                            expands: false,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: bumpOfferController.buttonTextColor.value,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      controller: bumpOfferController.titleTextController.value,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(),
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Enter Missing content',
                      ),
                      expands: false,
                      style: TextStyle(
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                        color: bumpOfferController.titleTextColor.value,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: bumpOfferController.footerTextController.value,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(),
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Enter Missing content',
                    ),
                    expands: false,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                      color: bumpOfferController.footerTextColor.value,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  showColorPicker(onChanged: (value) {
                    bumpOfferController.buttonColor.value = value;
                  }, onSet: () {
                    Get.back();
                  });
                },
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      label("Choose a button color"),
                      colorContainer(bumpOfferController.buttonColor),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: InkWell(
                onTap: () {
                  showColorPicker(onChanged: (value) {
                    bumpOfferController.borderColor.value = value;
                  }, onSet: () {
                    Get.back();
                  });
                },
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      label("Choose a Border color"),
                      colorContainer(bumpOfferController.borderColor),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  showColorPicker(onChanged: (value) {
                    bumpOfferController.backgroundColor.value = value;
                  }, onSet: () {
                    Get.back();
                  });
                },
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      label("Choose a background color"),
                      colorContainer(bumpOfferController.backgroundColor),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: InkWell(
                onTap: () {
                  showColorPicker(onChanged: (value) {
                    bumpOfferController.buttonTextColor.value = value;
                  }, onSet: () {
                    Get.back();
                  });
                },
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      label("Choose a button text color"),
                      colorContainer(bumpOfferController.buttonTextColor),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  showColorPicker(onChanged: (value) {
                    bumpOfferController.titleTextColor.value = value;
                  }, onSet: () {
                    Get.back();
                  });
                },
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      label("Choose a title text color"),
                      colorContainer(bumpOfferController.titleTextColor),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: InkWell(
                onTap: () {
                  showColorPicker(onChanged: (value) {
                    bumpOfferController.footerTextColor.value = value;
                  }, onSet: () {
                    Get.back();
                  });
                },
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      label("Choose a footer text color"),
                      colorContainer(bumpOfferController.footerTextColor),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        label("Choose a Border Type"),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  bumpOfferController.boxBorderDash = [15, 5].obs;
                  bumpOfferController.boxBorderWidth.value = 8.0;
                },
                child: Container(
                  height: Get.width * 0.2,
                  width: Get.width * 0.2,
                  color: mborderColor,
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: DottedDecoration(
                      strokeWidth: 6,
                      dash: [15, 5],
                      shape: Shape.box,
                      color: bumpOfferController.borderColor.value,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  bumpOfferController.boxBorderDash = [5, 5].obs;
                  bumpOfferController.boxBorderWidth.value = 5.0;
                },
                child: Container(
                  height: Get.width * 0.2,
                  width: Get.width * 0.2,
                  color: mborderColor,
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: DottedDecoration(
                      strokeWidth: 3.0,
                      dash: [5, 5],
                      shape: Shape.box,
                      color: bumpOfferController.borderColor.value,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  bumpOfferController.boxBorderWidth.value = 0.0;
                },
                child: Container(
                  height: Get.width * 0.2,
                  width: Get.width * 0.2,
                  color: mborderColor,
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 3.0,
                        color: bumpOfferController.borderColor.value,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
