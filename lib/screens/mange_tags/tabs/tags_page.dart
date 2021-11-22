import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/mange_tags/API/create_tag_service.dart';
import 'package:mint_bird_app/screens/mange_tags/API/delete_tag_service.dart';
import 'package:mint_bird_app/screens/mange_tags/API/get_transaction_service.dart';
import 'package:mint_bird_app/screens/mange_tags/API/update_tag_service.dart';
import 'package:mint_bird_app/screens/mange_tags/controller/manege_tags_controller.dart';
import 'package:mint_bird_app/screens/mange_tags/models/user_tag_list_model.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/utils/validator.dart';
import 'package:mint_bird_app/widgets/custom_buttons.dart';
import 'package:mint_bird_app/widgets/loaders.dart';
import 'package:mint_bird_app/widgets/second_textfield.dart';

class UserTagsListPage extends StatefulWidget {
  @override
  _UserTagsListPageState createState() => _UserTagsListPageState();
}

class _UserTagsListPageState extends State<UserTagsListPage> {
  final ManageTagController manageTagController =
      Get.put(ManageTagController());

  @override
  void initState() {
    manageTagController.selectedUserGroupList.value =
        manageTagController.userGroupList.first.id;
    getUserTagList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: mPrimaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          manageTagController.tagNameController.value.text = '';
          showDialog(
              context: context,
              builder: (context) {
                manageTagController.userGroupList.forEach((element) {
                  if (element.groupName == 'Default')
                    manageTagController.selectedUserGroupList.value =
                        element.id;
                });

                return Dialog(
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  insetPadding: EdgeInsets.only(
                    left: 14.0,
                    right: 14.0,
                    top: Get.height * 0.163,
                    bottom: Get.height * 0.02,
                  ),
                  child: addEditTagDialog(
                    manageTagController,
                    'Add',
                  ),
                );
              });
        },
      ),
      body: Obx(
        () => manageTagController.loading.value
            ? appLoader
            : ListView.builder(
                padding: EdgeInsets.only(top: 16),
                itemBuilder: (context, index) {
                  return userTagCard(context,
                      manageTagController.userTags[index], manageTagController);
                },
                itemCount: manageTagController.userTags.length,
              ),
      ),
    );
  }
}

Widget userTagCard(
  context,
  UserTag data,
  ManageTagController manageTagController,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 22.0),
    child: Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    data.tagName ?? '',
                    style: GoogleFonts.roboto(
                      fontSize: 17,
                      color: mTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  width: Get.width / 4,
                  decoration: BoxDecoration(
                    color: myellowColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                      child: FittedBox(
                        child: Text(
                          '#Tagged  :  ' + data.tagCount.toString(),
                          style: GoogleFonts.mavenPro(
                            fontWeight: FontWeight.w500,
                            color: priceTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        manageTagController.tagNameController.value.text =
                            data.tagName.toString();
                        manageTagController.selectedUserGroupList.value =
                            data.groupId.toString();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                elevation: 1.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                insetPadding: EdgeInsets.only(
                                  left: 14.0,
                                  right: 14.0,
                                  top: Get.height * 0.163,
                                  bottom: Get.height * 0.02,
                                ),
                                child: addEditTagDialog(
                                  manageTagController,
                                  'Edit',
                                  tagId: data.id,
                                ),
                              );
                            });
                      },
                      icon: Icon(
                        Icons.edit,
                        color: priceTextColor,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                elevation: 1.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                insetPadding: EdgeInsets.only(
                                  left: 14.0,
                                  right: 14.0,
                                  top: Get.height * 0.163,
                                  bottom: Get.height * 0.02,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Obx(
                                    () => Stack(
                                      children: [
                                        SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.all(15.0),
                                                child: Text(
                                                  "Are you sure to delete this tag?",
                                                  style: GoogleFonts.poppins(
                                                    color: mCustomizeTabText,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24.0,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 20.0),
                                                child: CustomButton(
                                                  width: Get.width,
                                                  height: 55.0,
                                                  text: "Delete".toUpperCase(),
                                                  onPressed: () {
                                                    deleteTagService(data.id);
                                                  },
                                                  textColor: mWhiteColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (manageTagController.loading.value)
                                          BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaY: 5, sigmaX: 5),
                                            child: Container(
                                              alignment: Alignment.center,
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              child: appLoader,
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: priceTextColor,
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Group : ${data.groupName}",
                    style: GoogleFonts.mavenPro(
                        fontSize: 15, color: mFunnelLableColor),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Date Added : 14/02/2020",
                    style: GoogleFonts.mavenPro(
                        fontSize: 15, color: mFunnelLableColor),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 11),
        Divider()
      ],
    ),
  );
}

Widget addEditTagDialog(
  ManageTagController manageTagController,
  String status, {
  String tagId = '',
}) {
  return Padding(
    padding: EdgeInsets.all(12.0),
    child: Obx(
      () => Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Text(
                    "Add Tag",
                    style: GoogleFonts.poppins(
                      color: mCustomizeTabText,
                      fontWeight: FontWeight.bold,
                      fontSize: 26.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0, bottom: 6.0),
                  child: Text(
                    "Tag Name",
                    style: GoogleFonts.roboto(
                      color: mTextboxTitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                SecondTextField(
                  controller: manageTagController.tagNameController.value,
                  hintText: "Tag Name",
                  enabled: true,
                  obscureText: false,
                  validator: (val) {
                    return FieldValidator.validateValueIsEmpty(val);
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0, bottom: 6.0),
                  child: Text(
                    "Select Group",
                    style: GoogleFonts.roboto(
                      color: mTextboxTitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  width: Get.width,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: mborderColor, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: mborderColor, width: 1.0),
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
                    hint: Text(
                      'Select Group',
                      style: TextStyle(color: Colors.blue),
                    ),
                    items: List.generate(
                        manageTagController.userGroupList.length, (index) {
                      return DropdownMenuItem(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            manageTagController.userGroupList[index].groupName
                                .toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: mIconColor,
                            ),
                          ),
                        ),
                        value: manageTagController.userGroupList[index].id
                            .toString(),
                      );
                    }),
                    onChanged: (value) {
                      manageTagController.selectedUserGroupList.value = value;
                    },
                    isExpanded: false,
                    value: manageTagController.selectedUserGroupList.value,
                    isDense: true,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  child: CustomButton(
                    width: Get.width,
                    height: 55.0,
                    text: "Save".toUpperCase(),
                    onPressed: () {
                      if (manageTagController.selectedUserGroupList.value !=
                              '' &&
                          manageTagController.tagNameController.value.text !=
                              '')
                        (status == 'Add')
                            ? createTagService()
                            : updateTagService(tagId);
                    },
                    textColor: mWhiteColor,
                  ),
                ),
              ],
            ),
          ),
          if (manageTagController.loading.value)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.5),
                child: appLoader,
              ),
            )
        ],
      ),
    ),
  );
}
