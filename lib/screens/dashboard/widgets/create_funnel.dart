import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/funnel/API/create_funnel_service.dart';
import 'package:mint_bird_app/screens/funnel/API/get_funnel.dart';
import 'package:mint_bird_app/screens/funnel/controller/funnel_controller.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/utils/validator.dart';
import 'package:mint_bird_app/widgets/border_button.dart';
import 'package:mint_bird_app/widgets/custom_buttons.dart';
import 'package:mint_bird_app/widgets/loaders.dart';
import 'package:mint_bird_app/widgets/second_textfield.dart';
import 'package:mint_bird_app/widgets/success_modal_sheet.dart';

final formFieldKey = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();

Widget createFunnel(BuildContext context) {
  FunnelController funnelController = Get.put(FunnelController());
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
                      "Create Funnel",
                      style: GoogleFonts.poppins(
                        color: mCustomizeTabText,
                        fontWeight: FontWeight.bold,
                        fontSize: 26.0,
                      ),
                    ),
                  ),
                  Text(
                    "Funnel Name",
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
                      hintText: "Funnel Name",
                      enabled: true,
                      obscureText: false,
                      validator: (val) {
                        return FieldValidator.validateValueIsEmpty(val);
                      },
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
                      items: List.generate(funnelController.funnelGroup.length,
                          (index) {
                        return DropdownMenuItem(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              funnelController.funnelGroup[index]["name"]
                                  .toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: mIconColor,
                              ),
                            ),
                          ),
                          value: funnelController.funnelGroup[index]["id"]
                              .toString(),
                        );
                      }),
                      onChanged: (value) {
                        funnelController.selectedGroup.value = value;
                      },
                      isExpanded: false,
                      value:
                          funnelController.funnelGroup.first["id"].toString(),
                      isDense: true,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Get.height / 5),
                    child: CustomButton(
                      width: Get.width,
                      height: 55.0,
                      text: "Save".toUpperCase(),
                      onPressed: () {
                        final form = formFieldKey.currentState;
                        if (form.validate()) {
                          form.save();
                          createFunnelService(
                            pName: nameController.text,
                          ).then((value) {
                            if (value) {
                              nameController.clear();
                              showSuccessModalSheet(context, "funnel");
                              dashboardController.lastPage.value = 0;
                              dashboardController.searchQuery.value = "";
                              dashboardController.listOfFunnel.clear();
                              dashboardController.currentPage.value = 1;
                              getUserFunnelService();
                            }
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
        return funnelController.isLoading.value ? blurLoader : SizedBox();
      })
    ],
  );
}
