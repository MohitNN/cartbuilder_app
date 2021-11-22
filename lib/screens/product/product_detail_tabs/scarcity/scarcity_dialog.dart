import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/product/API/scarcity/assign_sale_to_product.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';
import 'package:mint_bird_app/widgets/border_button.dart';
import 'package:mint_bird_app/widgets/custom_buttons.dart';

import '../../../../utils/m_colors.dart';
import '../../../../widgets/loaders.dart';

TextEditingController productNameController = TextEditingController();
TextEditingController productPriceController = TextEditingController();
TextEditingController productDescriptController = TextEditingController();
final formFieldKey = GlobalKey<FormState>();

Widget createScarcity(BuildContext context) {
  DashboardController dashboardController = Get.put(DashboardController());
  ProductController productController = Get.put(ProductController());
  PageController pageController = PageController();

  return Obx(() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: myellowColor,
            borderRadius: BorderRadius.circular(21.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: mWhiteColor,
              borderRadius: BorderRadius.circular(21.0),
            ),
            margin: EdgeInsets.only(top: 5.0),
            child: Form(
              key: formFieldKey,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 22.0,
                  right: 22.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.36,
                        vertical: 15.0,
                      ),
                      child: Divider(
                        color: mborderColor,
                        thickness: 3.0,
                        height: 3.0,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0, bottom: 23.0),
                      child: Text(
                        "Create Scarcity Sale",
                        style: GoogleFonts.poppins(
                          color: mCustomizeTabText,
                          fontWeight: FontWeight.bold,
                          fontSize: 26.0,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Choose Your Campaign Type",
                        style: GoogleFonts.roboto(
                          color: mTextboxTitleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                            value: 0,
                            groupValue: productController.timeDime.value,
                            onChanged: (value) {
                              pageController.animateToPage(value,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.ease);
                              productController.timeDime.value = value;
                            }),
                        Text("Time Sale"),
                        Radio(
                            value: 1,
                            groupValue: productController.timeDime.value,
                            onChanged: (value) {
                              pageController.animateToPage(value,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.ease);
                              productController.timeDime.value = value;
                            }),
                        Text("Dime Sale"),
                      ],
                    ),
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Choose Time Sale Group",
                                style: GoogleFonts.roboto(
                                  color: mTextboxTitleColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(6)),
                                child: DropdownButton<String>(
                                  underline: SizedBox(),
                                  isExpanded: true,
                                  value: productController
                                      .selectedTimeSaleGroup.value
                                      .toString(),
                                  onChanged: (value) {
                                    dashboardController.selectedTimeSales
                                        .clear();
                                    dashboardController
                                        .selectedTimeSaleId.value = "";
                                    productController
                                        .selectedTimeSaleGroup.value = value;
                                    dashboardController.listOfTimesell
                                        .forEach((element) {
                                      var name = productController
                                          .timeSalesGroup
                                          .firstWhere((element1) =>
                                              element1["id"] == value);
                                      print("g = ${element.groupName}");
                                      print("n = ${name["name"]}");
                                      print(element.groupName == name["name"]);
                                      if (element.groupName == name["name"]) {
                                        dashboardController.selectedTimeSales
                                            .add(element);
                                      }
                                    });
                                    if (dashboardController
                                            .selectedTimeSales.length !=
                                        0) {
                                      dashboardController
                                              .selectedTimeSaleId.value =
                                          dashboardController
                                              .selectedTimeSales.first.id;
                                    }
                                  },
                                  items: List.generate(
                                      productController.timeSalesGroup.length,
                                      (index) => DropdownMenuItem(
                                            child: Text(productController
                                                .timeSalesGroup[index]["name"]
                                                .toString()),
                                            value: productController
                                                .timeSalesGroup[index]["id"]
                                                .toString(),
                                          )),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Obx(() {
                                return dashboardController
                                            .selectedTimeSales.length ==
                                        0
                                    ? SizedBox()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Choose Scarcity Sale Group",
                                            style: GoogleFonts.roboto(
                                              color: mTextboxTitleColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            child: DropdownButton<String>(
                                              underline: SizedBox(),
                                              isExpanded: true,
                                              value: dashboardController
                                                  .selectedTimeSaleId.value,
                                              onChanged: (value) {
                                                dashboardController
                                                    .selectedTimeSaleId
                                                    .value = value;
                                              },
                                              items: List.generate(
                                                  dashboardController
                                                      .selectedTimeSales.length,
                                                  (index) => DropdownMenuItem(
                                                        child: Text(
                                                            dashboardController
                                                                .selectedTimeSales[
                                                                    index]
                                                                .timesaleName
                                                                .toString()),
                                                        value: dashboardController
                                                            .selectedTimeSales[
                                                                index]
                                                            .id,
                                                      )),
                                            ),
                                          )
                                        ],
                                      );
                              }),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Choose Dime Sale Group",
                                style: GoogleFonts.roboto(
                                  color: mTextboxTitleColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(6)),
                                child: DropdownButton<String>(
                                  underline: SizedBox(),
                                  isExpanded: true,
                                  value: productController
                                      .selectedDimeSaleGroup.value
                                      .toString(),
                                  onChanged: (value) {
                                    dashboardController.selectedDimeSales
                                        .clear();
                                    dashboardController
                                        .selectedDimeSaleId.value = "";
                                    productController
                                        .selectedDimeSaleGroup.value = value;
                                    dashboardController.listOfDimeSale
                                        .forEach((element) {
                                      var name = productController
                                          .dimeSalesGroup
                                          .firstWhere((element1) =>
                                              element1["id"] == value);
                                      print(element.groupName);
                                      print(name["name"]);
                                      if (element.groupName == name["name"]) {
                                        dashboardController.selectedDimeSales
                                            .add(element);
                                      }
                                    });
                                    if (dashboardController
                                            .selectedDimeSales.length !=
                                        0) {
                                      dashboardController
                                              .selectedDimeSaleId.value =
                                          dashboardController
                                              .selectedDimeSales.first.id;
                                    }
                                  },
                                  items: List.generate(
                                      productController.dimeSalesGroup.length,
                                      (index) => DropdownMenuItem(
                                            child: Text(productController
                                                .dimeSalesGroup[index]["name"]
                                                .toString()),
                                            value: productController
                                                .dimeSalesGroup[index]["id"]
                                                .toString(),
                                          )),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Obx(() {
                                return dashboardController
                                            .selectedDimeSales.length ==
                                        0
                                    ? SizedBox()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Choose Scarcity Sale Group",
                                            style: GoogleFonts.roboto(
                                              color: mTextboxTitleColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            child: DropdownButton<String>(
                                              underline: SizedBox(),
                                              isExpanded: true,
                                              value: dashboardController
                                                  .selectedDimeSaleId.value,
                                              onChanged: (value) {
                                                dashboardController
                                                    .selectedDimeSaleId
                                                    .value = value;
                                              },
                                              items: List.generate(
                                                  dashboardController
                                                      .selectedDimeSales.length,
                                                  (index) => DropdownMenuItem(
                                                        child: Text(
                                                            dashboardController
                                                                .selectedDimeSales[
                                                                    index]
                                                                .dimesaleName
                                                                .toString()),
                                                        value: dashboardController
                                                            .selectedDimeSales[
                                                                index]
                                                            .id,
                                                      )),
                                            ),
                                          )
                                        ],
                                      );
                              }),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: CustomButton(
                        width: Get.width,
                        height: 55.0,
                        text: "CREATE SCARCITY".toUpperCase(),
                        onPressed: () {
                          if (productController.timeDime.value == 0) {
                            if (dashboardController
                                    .selectedTimeSaleId.value.length >
                                0) {
                              assignSaleToProductService();
                            } else {
                              errorSnackBar("Time sale not selected",
                                  "Please select at least one time sale");
                            }
                          } else {
                            if (dashboardController
                                    .selectedDimeSaleId.value.length >
                                0) {
                              assignSaleToProductService();
                            } else {
                              errorSnackBar("Dime sale not selected",
                                  "Please select at least one dime sale");
                            }
                          }
                        },
                        textColor: mWhiteColor,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12.0, bottom: 20.0),
                      child: BorderButton(
                        width: Get.width,
                        height: 55.0,
                        text: "Cancel".toUpperCase(),
                        onPressed: () {
                          Get.back();
                        },
                        textColor: mDisableTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Obx(() {
          return dashboardController.isLoading.value ? blurLoader : SizedBox();
        })
      ],
    );
  });
}

TextStyle getDefaultTextStyle(double size, Color color, {fontweight}) {
  return GoogleFonts.roboto(
    fontSize: size,
    color: color,
    fontWeight: fontweight == null ? FontWeight.w400 : fontweight,
  );
}
