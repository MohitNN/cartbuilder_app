import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/product/API/create_product_service.dart';
import 'package:mint_bird_app/screens/product/API/get_user_product.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/utils/validator.dart';
import 'package:mint_bird_app/widgets/border_button.dart';
import 'package:mint_bird_app/widgets/custom_buttons.dart';
import 'package:mint_bird_app/widgets/second_textfield.dart';
import 'package:mint_bird_app/widgets/success_modal_sheet.dart';

import '../../../utils/m_colors.dart';
import '../../../widgets/loaders.dart';

TextEditingController productNameController = TextEditingController();
TextEditingController productPriceController = TextEditingController();
TextEditingController productDescriptController = TextEditingController();
final formFieldKey = GlobalKey<FormState>();

Widget createProduct(BuildContext context) {
  DashboardController dashboardController = Get.put(DashboardController());
  ProductController productController = Get.put(ProductController());
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
                    margin: EdgeInsets.only(top: 15.0, bottom: 23.0),
                    child: Text(
                      "Create Order Form",
                      style: GoogleFonts.poppins(
                        color: mCustomizeTabText,
                        fontWeight: FontWeight.bold,
                        fontSize: 26.0,
                      ),
                    ),
                  ),
                  Text(
                    "Order Form Name",
                    style: GoogleFonts.roboto(
                      color: mTextboxTitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: SecondTextField(
                      controller: productNameController,
                      hintText: "Order form name",
                      enabled: true,
                      obscureText: false,
                      validator: (val) {
                        return FieldValidator.validateValueIsEmpty(val);
                      },
                    ),
                  ),
                  Text(
                    "Order Form Price",
                    style: GoogleFonts.roboto(
                      color: mTextboxTitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
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
                            keyboardType: TextInputType.number,
                            controller: productPriceController,
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
                    "Order Form Description",
                    style: GoogleFonts.roboto(
                      color: mTextboxTitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 20.0),
                    child: SecondTextField(
                      controller: productDescriptController,
                      hintText: "Describe your order form here…",
                      enabled: true,
                      maxline: 4,
                      obscureText: false,
                      validator: (val) {
                        return FieldValidator.validateValueIsEmpty(val);
                      },
                    ),
                  ),
                  /* Text(
                    "Select group",
                    style: GoogleFonts.roboto(
                      color: mTextboxTitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
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
                                color: mIconColor,
                                size: 20.0,
                              ))),
                      style: TextStyle(color: mBlackColor, fontSize: 16),
                      iconSize: 32,
                      items: List.generate(
                          productController.productGroup.length, (index) {
                        return DropdownMenuItem(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              productController.productGroup[index]["name"]
                                  .toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: mIconColor,
                              ),
                            ),
                          ),
                          value: productController.productGroup[index]["id"]
                              .toString(),
                        );
                      }),
                      onChanged: (value) {
                        productController.selectedGroup.value = value;
                      },
                      isExpanded: false,
                      value:
                          productController.productGroup.first["id"].toString(),
                      isDense: true,
                    ),
                  ),*/
                  Text(
                    "Order Form Status",
                    style: GoogleFonts.roboto(
                      color: mTextboxTitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, bottom: 32.0),
                    child: Row(
                      children: [
                        Text(
                          "Test Mode",
                          style: GoogleFonts.roboto(
                            color: mTextboxHintColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 14.0,
                          ),
                        ),
                        Obx(
                          () {
                            return Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                activeColor: mBtnColor,
                                onChanged: (val) => productController
                                    .productStatusSwitch.value = val,
                                value:
                                    productController.applyCouponSwitch.value,
                              ),
                            );
                          },
                        ),
                        Text(
                          "Live",
                          style: GoogleFonts.roboto(
                            color: mTextboxHintColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: CustomButton(
                      width: Get.width,
                      height: 55.0,
                      text: "CREATE ORDER FORM".toUpperCase(),
                      onPressed: () {
                        final form = formFieldKey.currentState;
                        if (form.validate()) {
                          form.save();
                          createProductService(
                            pName: productNameController.text,
                            pPrice: productPriceController.text,
                            pDescription: productDescriptController.text,
                            pStatus: productController.productStatusSwitch.value
                                ? "1"
                                : "0",
                            checkOutPageUrl: productDescriptController.text,
                          ).then((value) {
                            if (value) {
                              productNameController.clear();
                              productPriceController.clear();
                              productDescriptController.clear();
                              productController.productStatusSwitch.value =
                                  false;
                              showSuccessModalSheet(context, "Order Form");
                              dashboardController.searchQuery.value = "";
                              dashboardController.listOfProduct.clear();
                              dashboardController.currentPage.value = 1;
                              getUserProductService();
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
        return productController.isLoading.value ? blurLoader : SizedBox();
      })
    ],
  );
}

TextStyle getDefaultTextStyle(double size, Color color, {fontweight}) {
  return GoogleFonts.roboto(
    fontSize: size,
    color: color,
    fontWeight: fontweight == null ? FontWeight.w400 : fontweight,
  );
}
