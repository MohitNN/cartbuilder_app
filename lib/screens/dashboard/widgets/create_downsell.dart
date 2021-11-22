import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/downsell/API/create_downselll_service.dart';
import 'package:mint_bird_app/screens/downsell/API/get_user_downsell.dart';
import 'package:mint_bird_app/screens/downsell/controller/downsell_controller.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/utils/validator.dart';
import 'package:mint_bird_app/widgets/border_button.dart';
import 'package:mint_bird_app/widgets/custom_buttons.dart';
import 'package:mint_bird_app/widgets/loaders.dart';
import 'package:mint_bird_app/widgets/second_textfield.dart';
import 'package:mint_bird_app/widgets/success_modal_sheet.dart';

final formFieldKey = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();
TextEditingController priceController = TextEditingController();

Widget createDownsell(BuildContext contextDownSell) {
  DownSellController downsellController = Get.put(DownSellController());
  DashboardController dashboardController = Get.put(DashboardController());
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          color: mPurple,
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
              child: ListView(
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
                    margin: EdgeInsets.only(top: 15.0, bottom: 32.0),
                    child: Text(
                      "Create Downsell",
                      style: GoogleFonts.poppins(
                        color: mCustomizeTabText,
                        fontWeight: FontWeight.bold,
                        fontSize: 26.0,
                      ),
                    ),
                  ),
                  Text(
                    "Downsell Name",
                    style: GoogleFonts.roboto(
                      color: mTextboxTitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 28.0),
                    child: SecondTextField(
                      controller: nameController,
                      hintText: "Downsell Name",
                      enabled: true,
                      obscureText: false,
                      validator: (val) {
                        return FieldValidator.validateValueIsEmpty(val);
                      },
                    ),
                  ),
                  Text(
                    "Downsell Price",
                    style: GoogleFonts.roboto(
                      color: mTextboxTitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 28.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            color: mWhiteColor,
                            border: Border.all(color: mborderColor),
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          child: Icon(
                            Icons.attach_money,
                            color: dollarIconColor,
                            size: 18.0,
                          ),
                        ),
                        Expanded(
                          child: SecondTextField(
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            hintText: "",
                            enabled: true,
                            obscureText: false,
                            validator: (val) {
                              return FieldValidator.validateValueIsEmpty(val);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Select Group",
                    style: GoogleFonts.roboto(
                      color: mTextboxTitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(2.0),
                    margin: EdgeInsets.only(top: 15.0),
                    width: Get.width,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: mborderColor, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: mborderColor, width: 1.0),
                        ),
                      ),
                      focusColor: mBlackColor,
                      dropdownColor: mWhiteColor,
                      iconEnabledColor: mPrimaryColor,
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: dollarIconColor,
                            size: 20.0,
                          ),
                        ),
                      ),
                      style: TextStyle(color: mBlackColor, fontSize: 16),
                      iconSize: 32,
                      items: List.generate(
                          downsellController.downSellGroup.length, (index) {
                        return DropdownMenuItem(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              downsellController.downSellGroup[index]["name"]
                                  .toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: mIconColor,
                              ),
                            ),
                          ),
                          value: downsellController.downSellGroup[index]["id"]
                              .toString(),
                        );
                      }),
                      onChanged: (value) {
                        downsellController.selectedGroup.value = value;
                      },
                      isExpanded: false,
                      value: downsellController.downSellGroup.first["id"]
                          .toString(),
                      isDense: true,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 70.0),
                    child: CustomButton(
                      width: Get.width,
                      height: 55.0,
                      text: "Save".toUpperCase(),
                      onPressed: () {
                        final form = formFieldKey.currentState;
                        if (form.validate()) {
                          form.save();
                          createDownSellService(
                            pName: nameController.text,
                            pPrice: priceController.text,
                          ).then((value) {
                            if (value) {
                              nameController.clear();
                              priceController.clear();
                              showSuccessModalSheet(
                                  contextDownSell, "downsell");
                            }
                            dashboardController.searchQuery.value = "";
                            dashboardController.listOfDownsell.clear();
                            dashboardController.currentPage.value = 1;
                            getUserDownSellService();
                          });
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
        if (downsellController.isLoading.value) {
          return blurLoader;
        } else {
          return SizedBox();
        }
      }),
    ],
  );
}
