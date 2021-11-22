import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/product/API/ever_lesson_service_apis.dart';
import 'package:mint_bird_app/screens/upsell/upsell_detail_tabs/membership_platform_list_widget.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';

import '../../../widgets/loaders.dart';
import '../API/ever_lesson_service_apis.dart';
import '../controller/product_controller.dart';

addEverLesson(SelectedProductDeliveryOptions data) async {
  Get.dialog(
    Dialog(
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      insetPadding:
          EdgeInsets.only(left: 16.0, right: 16.0, top: 95.0, bottom: 20.0),
      child: ProductAddEverLesson(data),
    ),
  );
}

// ignore: must_be_immutable
class ProductAddEverLesson extends StatelessWidget {
  ProductController productController = Get.put(ProductController());
  final SelectedProductDeliveryOptions data;

  ProductAddEverLesson(this.data);

  final String course = 'course';
  final String level = 'level';

  @override
  Widget build(BuildContext context) {
    getChooseAccountListService();
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
                          data.label,
                        ),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4.0, top: 15.0, bottom: 6.0),
                  child: Text(
                    "Choose Account",
                    style: GoogleFonts.roboto(
                      color: mTextboxTitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4.0, bottom: 6.0),
                  decoration: BoxDecoration(
                    color: mWhiteColor,
                    border: Border.all(color: mborderColor),
                    borderRadius: BorderRadius.circular(5.0),
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
                        productController.chooseAccountEverLesson.length,
                        (index) {
                          return DropdownMenuItem(
                            child: Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text(
                                productController.chooseAccountEverLesson[index]
                                        ["name"]
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: mIconColor,
                                ),
                              ),
                            ),
                            value: productController
                                .chooseAccountEverLesson[index]["id"]
                                .toString(),
                          );
                        },
                      ),
                      onChanged: (value) {
                        productController.selectedChooseAccount.value = value;
                        getChooseMemberShipListService(value);
                      },
                      isExpanded: false,
                      value: productController
                          .chooseAccountEverLesson.first["id"]
                          .toString(),
                      isDense: true,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4.0, top: 10.0, bottom: 6.0),
                  child: Text(
                    "Choose Membership",
                    style: GoogleFonts.roboto(
                      color: mTextboxTitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4.0, bottom: 6.0),
                  decoration: BoxDecoration(
                    color: mWhiteColor,
                    border: Border.all(color: mborderColor),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Obx(
                    () => productController.chooseMemberShipLoading.value
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
                            hint: Text('Choose MemberShip'),
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
                                productController.chooseMembershipEverLesson
                                    .length, (index) {
                              return DropdownMenuItem(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    productController
                                        .chooseMembershipEverLesson[index]
                                            ["name"]
                                        .toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: mIconColor,
                                    ),
                                  ),
                                ),
                                value: productController
                                    .chooseMembershipEverLesson[index]["id"]
                                    .toString(),
                              );
                            }),
                            onChanged: (value) {
                              productController.selectedMemberShip.value =
                                  value;
                              getChooseLevelListService(
                                value,
                                productController.selectedChooseAccount.value,
                              );
                              getChooseCourseListService(
                                value,
                                productController.selectedChooseAccount.value,
                              );
                            },
                            isExpanded: true,
                            value: productController
                                        .chooseMembershipEverLesson.length ==
                                    0
                                ? null
                                : productController
                                    .chooseMembershipEverLesson.first["id"]
                                    .toString(),
                            isDense: true,
                          ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4.0, top: 15.0, bottom: 6.0),
                  child: Row(
                    children: [
                      Obx(
                        () => Radio(
                          value: course,
                          groupValue:
                              productController.selectedCourseLevel.value,
                          onChanged: (val) {
                            productController.selectedCourseLevel.value = val;
                          },
                        ),
                      ),
                      Text(
                        "Course",
                        style: GoogleFonts.roboto(
                          color: mTextboxTitleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                      ),
                      Obx(
                        () => Radio(
                          value: level,
                          groupValue:
                              productController.selectedCourseLevel.value,
                          onChanged: (val) {
                            productController.selectedCourseLevel.value = val;
                          },
                        ),
                      ),
                      Text(
                        "Level",
                        style: GoogleFonts.roboto(
                          color: mTextboxTitleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4.0, top: 10.0, bottom: 6.0),
                  child: Obx(
                    () => Text(
                      "Choose ${productController.selectedCourseLevel.value}",
                      style: GoogleFonts.roboto(
                        color: mTextboxTitleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4.0, bottom: 16.0),
                  decoration: BoxDecoration(
                    color: mWhiteColor,
                    border: Border.all(color: mborderColor),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Obx(
                    () => (productController.selectedCourseLevel.value ==
                            course)
                        ? productController.chooseCourseLoading.value
                            ? Container(
                                height: 50,
                                child: appLoader,
                              )
                            : DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: mborderColor, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: mborderColor, width: 1.0),
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
                                style:
                                    TextStyle(color: mBlackColor, fontSize: 16),
                                iconSize: 32,
                                items: List.generate(
                                    productController.chooseCourseEverLesson
                                        .length, (index) {
                                  return DropdownMenuItem(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Text(
                                        productController
                                            .chooseCourseEverLesson[index]
                                                ["name"]
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: mIconColor,
                                        ),
                                      ),
                                    ),
                                    value: productController
                                        .chooseCourseEverLesson[index]["id"]
                                        .toString(),
                                  );
                                }),
                                onChanged: (value) {
                                  productController.selectedCourse.value =
                                      value;
                                  getChooseActionOptionListService(
                                    accountId: productController
                                        .selectedChooseAccount.value,
                                    courseId:
                                        productController.selectedCourse.value,
                                    memberShipId: productController
                                        .selectedMemberShip.value,
                                  );
                                },
                                isExpanded: false,
                                value: productController
                                            .chooseCourseEverLesson.length ==
                                        0
                                    ? null
                                    : productController
                                        .chooseCourseEverLesson.first["id"]
                                        .toString(),
                                isDense: true,
                              )
                        : productController.chooseLevelLoading.value
                            ? Container(
                                height: 50,
                                child: appLoader,
                              )
                            : DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: mborderColor, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: mborderColor, width: 1.0),
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
                                style:
                                    TextStyle(color: mBlackColor, fontSize: 16),
                                iconSize: 32,
                                items: List.generate(
                                    productController
                                        .chooseLevelEverLesson.length, (index) {
                                  return DropdownMenuItem(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Text(
                                        productController
                                            .chooseLevelEverLesson[index]
                                                ["name"]
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: mIconColor,
                                        ),
                                      ),
                                    ),
                                    value: productController
                                        .chooseLevelEverLesson[index]["id"]
                                        .toString(),
                                  );
                                }),
                                onChanged: (value) {
                                  productController.selectedLevel.value = value;
                                },
                                isExpanded: false,
                                value: productController
                                            .chooseLevelEverLesson.length ==
                                        0
                                    ? null
                                    : productController
                                        .chooseLevelEverLesson.first["id"]
                                        .toString(),
                                isDense: true,
                              ),
                  ),
                ),
                Obx(
                  () => (productController.selectedCourseLevel.value == course)
                      ? Container(
                          margin: EdgeInsets.only(
                              left: 4.0, top: 15.0, bottom: 6.0),
                          child: Text(
                            "Choose Action Option",
                            style: GoogleFonts.roboto(
                              color: mTextboxTitleColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                            ),
                          ),
                        )
                      : Container(),
                ),
                Obx(
                  () => (productController.selectedCourseLevel.value == course)
                      ? Container(
                          margin: EdgeInsets.only(left: 4.0, bottom: 16.0),
                          decoration: BoxDecoration(
                            color: mWhiteColor,
                            border: Border.all(color: mborderColor),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: productController
                                  .chooseActionOptionLoading.value
                              ? Container(
                                  height: 50,
                                  child: appLoader,
                                )
                              : DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: mborderColor, width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: mborderColor, width: 1.0),
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
                                  style: TextStyle(
                                      color: mBlackColor, fontSize: 16),
                                  iconSize: 32,
                                  items: List.generate(
                                    productController
                                        .chooseActionOptionEverLesson.length,
                                    (index) {
                                      return DropdownMenuItem(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 8),
                                          child: Text(
                                            productController
                                                .chooseActionOptionEverLesson[
                                                    index]["name"]
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: mIconColor,
                                            ),
                                          ),
                                        ),
                                        value: productController
                                            .chooseActionOptionEverLesson[index]
                                                ["id"]
                                            .toString(),
                                      );
                                    },
                                  ),
                                  onChanged: (value) {
                                    productController
                                        .selectedActionOption.value = value;
                                  },
                                  isExpanded: false,
                                  value: productController
                                      .chooseActionOptionEverLesson.first["id"]
                                      .toString(),
                                  isDense: true,
                                ),
                        )
                      : Container(),
                ),
                GestureDetector(
                  onTap: () => saveEverLessonService(),
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
            return productController.chooseAccountLoading.value
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
