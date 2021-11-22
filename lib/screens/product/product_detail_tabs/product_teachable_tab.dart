import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/product/API/teachable_service_apis.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/screens/upsell/upsell_detail_tabs/membership_platform_list_widget.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';

import '../../../widgets/loaders.dart';

addTeachable(SelectedProductDeliveryOptions data) async {
  Get.dialog(
    Dialog(
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      insetPadding:
          EdgeInsets.only(left: 16.0, right: 16.0, top: 95.0, bottom: 20.0),
      child: ProductTeachableTab(data),
    ),
  );
}

class ProductTeachableTab extends StatefulWidget {
  final SelectedProductDeliveryOptions data;

  ProductTeachableTab(this.data);

  @override
  _ProductTeachableTabState createState() => _ProductTeachableTabState();
}

class _ProductTeachableTabState extends State<ProductTeachableTab> {
  ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    getChooseAccountListTeachableService();
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 15.0, bottom: 6.0),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    height: Get.height * 0.1,
                    width: Get.width * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.data.label,
                        ),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4.0, top: 15.0, bottom: 6.0),
                  child: new Text(
                    "Choose Account",
                    style: GoogleFonts.roboto(
                      color: mTextboxTitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4.0, top: 10.0, bottom: 6.0),
                  decoration: BoxDecoration(
                    color: mWhiteColor,
                    border: Border.all(color: mborderColor),
                  ),
                  child: Obx(
                        () => DropdownButtonFormField<String>(
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
                          ),
                        ),
                      ),
                      style: TextStyle(color: mBlackColor, fontSize: 16),
                      iconSize: 32,
                      items: List.generate(
                        productController.chooseAccountTeachable.length,
                            (index) {
                          return DropdownMenuItem(
                            child: Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text(
                                productController.chooseAccountTeachable[index]
                                ["name"]
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: mIconColor,
                                ),
                              ),
                            ),
                            value: productController
                                .chooseAccountTeachable[index]["id"]
                                .toString(),
                          );
                        },
                      ),
                      onChanged: (value) {
                        productController.selectedChooseAccount.value = value;
                        getChooseCourseListTeachableService(value);
                      },
                      isExpanded: false,
                      value: productController
                          .chooseAccountTeachable.first["id"]
                          .toString(),
                      isDense: true,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4.0, top: 15.0, bottom: 6.0),
                  child: Text(
                    "Choose Course",
                    style: GoogleFonts.roboto(
                      color: mTextboxTitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4.0, top: 10.0, bottom: 16.0),
                  decoration: BoxDecoration(
                    color: mWhiteColor,
                    border: Border.all(color: mborderColor),
                  ),
                  child: Obx(
                        () => productController.chooseCourseLoading.value
                        ? Container(
                      height: 50,
                      child: appLoader,
                    )
                        : DropdownButtonFormField<String>(
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
                          ),
                        ),
                      ),
                      style: TextStyle(color: mBlackColor, fontSize: 16),
                      iconSize: 32,
                      items: List.generate(
                          productController.chooseCourseTeachable.length,
                              (index) {
                            return DropdownMenuItem(
                              child: Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  productController
                                      .chooseCourseTeachable[index]["name"]
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: mIconColor,
                                  ),
                                ),
                              ),
                              value: productController
                                  .chooseCourseTeachable[index]["id"]
                                  .toString(),
                            );
                          }),
                      onChanged: (value) {
                        productController.selectedCourseTeachable.value =
                            value;
                      },
                      isExpanded: false,
                      value: productController
                          .chooseCourseTeachable.length ==
                          0
                          ? null
                          : productController
                          .chooseCourseTeachable.first["id"]
                          .toString(),
                      isDense: true,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => saveTeachableService(),
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(bottom: 20.0, top: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: mborderColor),
                      ),
                      padding: EdgeInsets.only(
                          top: 15.0, bottom: 15.0, left: 30.0, right: 30.0),
                      child: Image.asset(
                        AppString.iconImagesPath + "ic_savecloud.png",
                        width: 20,
                        height: 20,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Obx(
              () {
            return productController.chooseAccountLoadingTeachable.value
                ? BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
              child: Container(
                height: 350,
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.5),
                child: appLoader,
              ),
            )
                : SizedBox();
          },
        ),
      ],
    );
  }
}

class CourseLevelSelection extends StatefulWidget {
  @override
  _CourseLevelSelectionState createState() => _CourseLevelSelectionState();
}

class _CourseLevelSelectionState extends State<CourseLevelSelection> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
