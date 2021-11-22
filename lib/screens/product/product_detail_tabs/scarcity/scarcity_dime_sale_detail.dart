import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/dime_sales/controller/dime_sell_controller.dart';
import 'package:mint_bird_app/screens/dime_sales/dime_sale_details.dart';
import 'package:mint_bird_app/screens/dime_sales/models/dime_sell_detail_model.dart';
import 'package:mint_bird_app/screens/product/API/scarcity/scarcity_dime_sale_update.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/screens/time_sales/widgets/time_sale_details_loading.dart';
import 'package:mint_bird_app/screens/upsell/widgets/show_color_picker.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/utils/validator.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';
import 'package:mint_bird_app/widgets/loaders.dart';
import 'package:mint_bird_app/widgets/second_textfield.dart';

class ScarcityDimeSaleDetails extends StatefulWidget {
  const ScarcityDimeSaleDetails({Key key}) : super(key: key);

  @override
  _ScarcityDimeSaleDetailsState createState() =>
      _ScarcityDimeSaleDetailsState();
}

class _ScarcityDimeSaleDetailsState extends State<ScarcityDimeSaleDetails> {
  ProductController productController = Get.put(ProductController());
  DimeSellController dimeSellController = Get.put(DimeSellController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _dialogFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: mbackColor,
              size: 20.0,
            )),
        title: Obx(
          () => Padding(
            padding: EdgeInsets.only(right: 44),
            child: TextField(
              textAlign: TextAlign.center,
              readOnly: true,
              style: GoogleFonts.roboto(
                color: mTextColor,
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),
              controller: dimeSellController.nameController.value,
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(
        () {
          return dimeSellController.isLoading.value
              ? timeSaleDetailsLoading()
              : Stack(
                  children: [
                    SingleChildScrollView(
                        child: Obx(
                      () => Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: 20.0, bottom: 6.0, left: 16, right: 16),
                              child: Text(
                                "Dime sale Name",
                                style: GoogleFonts.roboto(
                                  color: mTextboxTitleColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: SecondTextField(
                                controller:
                                    dimeSellController.nameController.value,
                                hintText: "Dime sale name",
                                enabled: true,
                                obscureText: false,
                                validator: (val) {
                                  return FieldValidator.validateValueIsEmpty(
                                      val);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "This Dime Sale Sequence Will Run As Soon As it's Added To Your Campaign",
                                      style: GoogleFonts.roboto(),
                                    ),
                                  ),
                                  CupertinoSwitch(
                                      value: dimeSellController.isActive.value,
                                      onChanged: (value) {
                                        dimeSellController.isActive.value =
                                            value;
                                      }),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Start Time (Set in campaign)",
                                style: GoogleFonts.roboto(fontSize: 18),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile(
                                    value: 0,
                                    groupValue:
                                        dimeSellController.autoManual.value,
                                    onChanged: (value) {
                                      dimeSellController.autoManual.value =
                                          value;
                                    },
                                    title: Text("Auto Set"),
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    value: 1,
                                    groupValue:
                                        dimeSellController.autoManual.value,
                                    onChanged: (value) {
                                      dimeSellController.autoManual.value =
                                          value;
                                    },
                                    title: Text("Manually Set"),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            dimeSellController.autoManual.value == 0
                                ? Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "For every ",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16),
                                            ),
                                            Expanded(
                                                child: SecondTextField(
                                              obscureText: false,
                                              hintText: "0",
                                              controller: dimeSellController
                                                  .salesController.value,
                                              validator: (val) {
                                                return FieldValidator
                                                    .validateValueIsEmpty(val);
                                              },
                                              onChanged: (value) {
                                                dimeSellController.autoList
                                                    .first.sale = value;
                                              },
                                              enabled: true,
                                            )),
                                            Text(
                                              " Sales increase by ",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16),
                                            ),
                                            Expanded(
                                                child: SecondTextField(
                                              obscureText: false,
                                              prefixText: "\$ ",
                                              hintText: "Enter Price",
                                              controller: dimeSellController
                                                  .incrementController.value,
                                              validator: (val) {
                                                return FieldValidator
                                                    .validateValueIsEmpty(val);
                                              },
                                              onChanged: (value) {
                                                dimeSellController.autoList
                                                    .first.price = value;
                                              },
                                              enabled: true,
                                            )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 16),
                                        child: MaterialButton(
                                          color: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          onPressed: () {},
                                          child: Text(
                                            "Automation",
                                            style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      dimeSellController.manualList.length == 0
                                          ? Text("No Manual Found")
                                          : ListView.separated(
                                              itemCount: dimeSellController
                                                  .manualList.length,
                                              shrinkWrap: true,
                                              padding: EdgeInsets.zero,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              separatorBuilder:
                                                  (context, index) {
                                                return Divider();
                                              },
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 16),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "For every ",
                                                            style: GoogleFonts
                                                                .roboto(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                          Expanded(
                                                              child: Container(
                                                            height: 40,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  mtextBoxColor,
                                                              border: Border.all(
                                                                  color:
                                                                      mborderColor),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          3.0),
                                                            ),
                                                            child: Text(
                                                                dimeSellController
                                                                    .manualList[
                                                                        index]
                                                                    .sale
                                                                    .toString()),
                                                          )),
                                                          Text(
                                                            " Sales increase by \$ ",
                                                            style: GoogleFonts
                                                                .roboto(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              height: 40,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    mtextBoxColor,
                                                                border: Border.all(
                                                                    color:
                                                                        mborderColor),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3.0),
                                                              ),
                                                              child: Text(
                                                                  dimeSellController
                                                                      .manualList[
                                                                          index]
                                                                      .price
                                                                      .toString()),
                                                            ),
                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                dimeSellController
                                                                        .addManualSale
                                                                        .value
                                                                        .text =
                                                                    dimeSellController
                                                                        .manualList[
                                                                            index]
                                                                        .sale
                                                                        .toString();
                                                                dimeSellController
                                                                        .addManualPrice
                                                                        .value
                                                                        .text =
                                                                    dimeSellController
                                                                        .manualList[
                                                                            index]
                                                                        .price
                                                                        .toString();

                                                                editManualDialog(
                                                                    true,
                                                                    index:
                                                                        index);
                                                              },
                                                              icon: Icon(
                                                                Icons.edit,
                                                                color: Colors
                                                                    .blueGrey
                                                                    .shade200,
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 16,
                                                              vertical: 6),
                                                      child: MaterialButton(
                                                        color: Colors.blue,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40)),
                                                        onPressed: () {},
                                                        child: Text(
                                                          "Automation",
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Center(
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          color: Colors.blue,
                                          child: Text(
                                            "Add Manual",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            dimeSellController
                                                .addManualPrice.value
                                                .clear();
                                            dimeSellController
                                                .addManualSale.value
                                                .clear();
                                            editManualDialog(false);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 20.0, bottom: 6.0, left: 16, right: 16),
                              child: Text(
                                "Bold Text for tab bar",
                                style: GoogleFonts.roboto(
                                  color: mTextboxTitleColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: SecondTextField(
                                controller: dimeSellController
                                    .tabBarBoldTextController.value,
                                hintText: "Bold Text for tab bar",
                                enabled: true,
                                obscureText: false,
                                validator: (val) {
                                  return FieldValidator.validateValueIsEmpty(
                                      val);
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 20.0, bottom: 6.0, left: 16, right: 16),
                              child: Text(
                                "Regular Text for tab bar",
                                style: GoogleFonts.roboto(
                                  color: mTextboxTitleColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: SecondTextField(
                                controller: dimeSellController
                                    .tabBarRegularTextController.value,
                                hintText: "Regular Text for tab bar",
                                enabled: true,
                                obscureText: false,
                                validator: (val) {
                                  return FieldValidator.validateValueIsEmpty(
                                      val);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        showColorPicker(onChanged: (value) {
                                          dimeSellController.topBarColor.value =
                                              value;
                                        }, onSet: () {
                                          Get.back();
                                        });
                                      },
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            label("Choose top bar color"),
                                            colorContainer(
                                                dimeSellController.topBarColor)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        showColorPicker(onChanged: (value) {
                                          dimeSellController.textColor.value =
                                              value;
                                        }, onSet: () {
                                          Get.back();
                                        });
                                      },
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            label("Choose text color"),
                                            colorContainer(
                                                dimeSellController.textColor)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: InkWell(
                                onTap: () {
                                  showColorPicker(onChanged: (value) {
                                    dimeSellController.boldTextColor.value =
                                        value;
                                  }, onSet: () {
                                    Get.back();
                                  });
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            label("Choose bold text color"),
                                            colorContainer(dimeSellController
                                                .boldTextColor)
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          showColorPicker(onChanged: (value) {
                                            dimeSellController
                                                .timerColor.value = value;
                                          }, onSet: () {
                                            Get.back();
                                          });
                                        },
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              label("Choose timer color"),
                                              colorContainer(
                                                  dimeSellController.timerColor)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        showColorPicker(onChanged: (value) {
                                          dimeSellController
                                              .timerTextColor.value = value;
                                        }, onSet: () {
                                          Get.back();
                                        });
                                      },
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            label("Choose timer text color"),
                                            colorContainer(dimeSellController
                                                .timerTextColor)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        showColorPicker(onChanged: (value) {
                                          dimeSellController.buttonColor.value =
                                              value;
                                        }, onSet: () {
                                          Get.back();
                                        });
                                      },
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            label("Choose button color"),
                                            colorContainer(
                                                dimeSellController.buttonColor)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        showColorPicker(onChanged: (value) {
                                          dimeSellController
                                              .buttonTextColor.value = value;
                                        }, onSet: () {
                                          Get.back();
                                        });
                                      },
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            label("Choose button text"),
                                            colorContainer(dimeSellController
                                                .buttonTextColor)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(child: SizedBox()),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Map<String, dynamic> body = {
                                  "product_id":
                                      "${productController.productId.value}",
                                  "_id":
                                      "${dimeSellController.dimeSaleId.value}",
                                  "top_bar_bold_text":
                                      "${dimeSellController.tabBarBoldTextController.value.text}",
                                  "top_bar_regular_text":
                                      "${dimeSellController.tabBarRegularTextController.value.text}",
                                  "sales": [
                                    {
                                      "active":
                                          dimeSellController.isActive.value,
                                      "timeset":
                                          dimeSellController.autoManual.value ==
                                                  0
                                              ? "auto"
                                              : "manual",
                                      "auto": dimeSellController.autoList,
                                      "manual": dimeSellController.manualList,
                                      "time": DateTime.now().toString(),
                                      "manual_time": DateTime.now().toString(),
                                      "update_manual_time":
                                          DateTime.now().toString()
                                    }
                                  ]
                                };
                                if (dimeSellController.autoManual.value == 1) {
                                  if (dimeSellController.manualList.length ==
                                      0) {
                                    errorSnackBar(
                                        "Minimum 1 manual is required",
                                        "Please add at least 1 manual");
                                  } else {
                                    if (_formKey.currentState.validate()) {
                                      updateScarCityDimeSalesDetail(
                                          productBody: jsonEncode(body));
                                    }
                                  }
                                } else {
                                  if (_formKey.currentState.validate()) {
                                    updateScarCityDimeSalesDetail(
                                        productBody: jsonEncode(body));
                                  }
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                    bottom: 20.0, top: 10.0, right: 16),
                                alignment: Alignment.topRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    border: Border.all(color: mborderColor),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 9.0, horizontal: 16.0),
                                  child: dimeSellController.detailLoader.value
                                      ? SizedBox(
                                          height: 25,
                                          width: 25,
                                          child: CircularProgressIndicator())
                                      : Image.asset(
                                          AppString.iconImagesPath +
                                              "ic_cloud_save.png",
                                          color: optionIconColor,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            )
                          ],
                        ),
                      ),
                    )),
                    Obx(
                      () {
                        return dimeSellController.isLoading.value
                            ? blurLoader
                            : SizedBox();
                      },
                    ),
                  ],
                );
        },
      ),
    );
  }

  editManualDialog(bool isEdit, {int index}) {
    Get.dialog(Dialog(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _dialogFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "${isEdit ? "Edit" : "Add"} Manual Dime Sale",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "For every ",
                style: GoogleFonts.roboto(fontSize: 16),
              ),
              SizedBox(height: 10),
              SecondTextField(
                obscureText: false,
                hintText: "0",
                controller: dimeSellController.addManualSale.value,
                validator: (val) {
                  return FieldValidator.validateValueIsEmpty(val);
                },
                enabled: true,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Sales Increased by ",
                style: GoogleFonts.roboto(fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              SecondTextField(
                obscureText: false,
                hintText: "0",
                prefixText: "\$",
                controller: dimeSellController.addManualPrice.value,
                validator: (val) {
                  return FieldValidator.validateValueIsEmpty(val);
                },
                enabled: true,
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  isEdit
                      ? Center(
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            color: Colors.redAccent,
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              dimeSellController.manualList.removeAt(index);
                              Get.back();
                            },
                          ),
                        )
                      : SizedBox(),
                  Center(
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      color: Colors.blue,
                      child: Text(
                        isEdit ? "Edit Manual" : "Add Manual",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          if (isEdit) {
                            dimeSellController.manualList[index] =
                                DimeSaleManual(
                                    gDimeDriectUpsell: false,
                                    sale: int.parse(dimeSellController
                                        .addManualSale.value.text),
                                    price: dimeSellController
                                        .addManualPrice.value.text,
                                    behavior: 1);
                          } else {
                            dimeSellController.manualList.add(DimeSaleManual(
                                gDimeDriectUpsell: false,
                                sale: int.parse(dimeSellController
                                    .addManualSale.value.text),
                                price: dimeSellController
                                    .addManualPrice.value.text,
                                behavior: 1));
                          }
                          Get.back();
                        } else {
                          errorSnackBar("Sales & Price is required",
                              "Please fill the values and try again");
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}

Widget label(String title) {
  return Container(
    margin: EdgeInsets.only(top: 20.0, bottom: 6.0),
    child: Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.roboto(
        color: mTextboxTitleColor,
        fontWeight: FontWeight.w500,
        fontSize: 15.0,
      ),
    ),
  );
}
