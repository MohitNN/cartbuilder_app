import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/product/API/scarcity/scarcity_time_sale_update.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/screens/time_sales/controller/timesell_controller.dart';
import 'package:mint_bird_app/screens/time_sales/models/time_sell_detail_model.dart';
import 'package:mint_bird_app/screens/time_sales/widgets/time_sale_details_loading.dart';
import 'package:mint_bird_app/screens/upsell/widgets/show_color_picker.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/utils/validator.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';
import 'package:mint_bird_app/widgets/loaders.dart';
import 'package:mint_bird_app/widgets/second_textfield.dart';

class ScarcityTimeSaleDetail extends StatefulWidget {
  final String title;

  const ScarcityTimeSaleDetail({Key key, this.title}) : super(key: key);

  @override
  _ScarcityTimeSaleDetailState createState() => _ScarcityTimeSaleDetailState();
}

class _ScarcityTimeSaleDetailState extends State<ScarcityTimeSaleDetail> {
  ProductController productController = Get.put(ProductController());
  TimeSellController timeSellController = Get.put(TimeSellController());
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
              controller: timeSellController.nameController.value,
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(
        () {
          return timeSellController.isLoading.value
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
                                    top: 20.0,
                                    bottom: 6.0,
                                    left: 16,
                                    right: 16),
                                child: Text(
                                  "Time sale Name",
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
                                      timeSellController.nameController.value,
                                  hintText: "Time sale name",
                                  enabled: true,
                                  obscureText: false,
                                  validator: (val) {
                                    return FieldValidator.validateValueIsEmpty(
                                        val);
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "This Time Sale Sequence Will Run As Soon As it's Added To Your Campaign",
                                        style: GoogleFonts.roboto(),
                                      ),
                                    ),
                                    CupertinoSwitch(
                                        value:
                                            timeSellController.isActive.value,
                                        onChanged: (value) {
                                          timeSellController.isActive.value =
                                              value;
                                        }),
                                  ],
                                ),
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
                                          timeSellController.autoManual.value,
                                      onChanged: (value) {
                                        timeSellController.autoManual.value = 0;
                                      },
                                      title: Text("Auto Set"),
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                      value: 1,
                                      groupValue:
                                          timeSellController.autoManual.value,
                                      onChanged: (value) {
                                        timeSellController.autoManual.value = 1;
                                      },
                                      title: Text("Manually Set"),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              timeSellController.autoManual.value == 0
                                  ? Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Row(
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
                                                controller: timeSellController
                                                    .salesController.value,
                                                onChanged: (value) {
                                                  timeSellController.autoList
                                                      .first.sale = value;
                                                },
                                                validator: (val) {
                                                  return FieldValidator
                                                      .validateValueIsEmpty(
                                                          val);
                                                },
                                                enabled: true,
                                              )),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              DropdownButton(
                                                underline: SizedBox(),
                                                onChanged: (value) {
                                                  timeSellController.autoList
                                                      .first.hourDay = value;
                                                  timeSellController
                                                      .selectedTime
                                                      .value = value;
                                                  setState(() {});
                                                },
                                                items: List.generate(
                                                    3,
                                                    (index) => DropdownMenuItem(
                                                          child: Text(index == 0
                                                              ? "Minutes"
                                                              : index == 1
                                                                  ? "Hours"
                                                                  : "Days"),
                                                          value: index,
                                                        )),
                                                value: int.parse(
                                                    timeSellController
                                                        .autoList.first.hourDay
                                                        .toString()),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                " Price increase by \$ ",
                                                style: GoogleFonts.roboto(
                                                    fontSize: 16),
                                              ),
                                              Expanded(
                                                  child: SecondTextField(
                                                obscureText: false,
                                                hintText: "0",
                                                controller: timeSellController
                                                    .incrementController.value,
                                                onChanged: (value) {
                                                  timeSellController.autoList
                                                      .first.price = value;
                                                },
                                                validator: (val) {
                                                  return FieldValidator
                                                      .validateValueIsEmpty(
                                                          val);
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
                                        timeSellController.manualList.length ==
                                                0
                                            ? Text("No Manual Found")
                                            : ListView.separated(
                                                itemCount: timeSellController
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
                                                        padding: EdgeInsets
                                                            .symmetric(
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
                                                                child:
                                                                    Container(
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
                                                                  timeSellController
                                                                      .manualList[
                                                                          index]
                                                                      .sale
                                                                      .toString()),
                                                            )),
                                                            Text(timeSellController
                                                                        .manualList[
                                                                            index]
                                                                        .hourDay ==
                                                                    "0"
                                                                ? " Minutes"
                                                                : timeSellController
                                                                            .manualList[index]
                                                                            .hourDay ==
                                                                        "1"
                                                                    ? " Hours"
                                                                    : " Days"),
                                                            Text(
                                                              " Price increase by \$ ",
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
                                                                  border: Border
                                                                      .all(
                                                                          color:
                                                                              mborderColor),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3.0),
                                                                ),
                                                                child: Text(timeSellController
                                                                    .manualList[
                                                                        index]
                                                                    .price
                                                                    .toString()),
                                                              ),
                                                            ),
                                                            IconButton(
                                                                onPressed: () {
                                                                  timeSellController
                                                                          .addManualSale
                                                                          .value
                                                                          .text =
                                                                      timeSellController
                                                                          .manualList[
                                                                              index]
                                                                          .sale
                                                                          .toString();
                                                                  timeSellController
                                                                          .addManualPrice
                                                                          .value
                                                                          .text =
                                                                      timeSellController
                                                                          .manualList[
                                                                              index]
                                                                          .price
                                                                          .toString();
                                                                  timeSellController
                                                                          .addHoursDay
                                                                          .value =
                                                                      timeSellController
                                                                          .manualList[
                                                                              index]
                                                                          .hourDay
                                                                          .toString();

                                                                  editTimeSaleManualDialog(
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
                                                        alignment: Alignment
                                                            .centerRight,
                                                        padding: EdgeInsets
                                                            .symmetric(
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
                                                                    fontSize:
                                                                        16),
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
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              timeSellController
                                                  .addManualPrice.value
                                                  .clear();
                                              timeSellController
                                                  .addManualSale.value
                                                  .clear();
                                              editTimeSaleManualDialog(false);
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 20.0,
                                    bottom: 6.0,
                                    left: 16,
                                    right: 16),
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
                                  controller: timeSellController
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
                                    top: 20.0,
                                    bottom: 6.0,
                                    left: 16,
                                    right: 16),
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
                                  controller: timeSellController
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
                                            timeSellController
                                                .topBarColor.value = value;
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
                                              colorContainer(timeSellController
                                                  .topBarColor.value)
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
                                            timeSellController.textColor.value =
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
                                              colorContainer(timeSellController
                                                  .textColor.value)
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
                                      timeSellController.boldTextColor.value =
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
                                              colorContainer(timeSellController
                                                  .boldTextColor.value)
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
                                              timeSellController
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
                                                    timeSellController
                                                        .timerColor.value)
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
                                            timeSellController
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
                                              colorContainer(timeSellController
                                                  .timerTextColor.value)
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
                                            timeSellController
                                                .buttonColor.value = value;
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
                                              colorContainer(timeSellController
                                                  .buttonColor.value)
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
                                            timeSellController
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
                                              colorContainer(timeSellController
                                                  .buttonTextColor.value)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: SizedBox(),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      "Order Summary Timer",
                                      style: GoogleFonts.roboto(
                                        color: mTextboxTitleColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Off",
                                          style: GoogleFonts.roboto(
                                            color: mTextboxTitleColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                        CupertinoSwitch(
                                          value: timeSellController
                                              .summaryTimer.value,
                                          onChanged: (value) {
                                            timeSellController
                                                .summaryTimer.value = value;
                                          },
                                        ),
                                        Text(
                                          "On",
                                          style: GoogleFonts.roboto(
                                            color: mTextboxTitleColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              timeSellController.summaryTimer.value
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          top: 20.0,
                                          bottom: 6.0,
                                          left: 16,
                                          right: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Timer text",
                                            style: GoogleFonts.roboto(
                                              color: mTextboxTitleColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          SecondTextField(
                                            obscureText: false,
                                            hintText: "Timer Text",
                                            labelText: "Timer Text",
                                            controller: timeSellController
                                                .timerTextController.value,
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(),
                              GestureDetector(
                                onTap: () {
                                  Map<String, dynamic> body = {
                                    "product_id":
                                        "${productController.productId.value}",
                                    "_id":
                                        "${timeSellController.timeSaleId.value}",
                                    "top_bar_bold_text":
                                        "${timeSellController.tabBarBoldTextController.value.text}",
                                    "top_bar_regular_text":
                                        "${timeSellController.tabBarRegularTextController.value.text}",
                                    "sales": [
                                      {
                                        "active":
                                            timeSellController.isActive.value,
                                        "timesettime": timeSellController
                                                    .autoManual.value ==
                                                0
                                            ? "auto"
                                            : "manual",
                                        "auto": timeSellController.autoList,
                                        "manual": timeSellController.manualList,
                                        "time": DateTime.now().toString(),
                                        "manual_time":
                                            DateTime.now().toString(),
                                        "update_manual_time":
                                            DateTime.now().toString()
                                      }
                                    ]
                                  };
                                  if (timeSellController.autoManual.value ==
                                      1) {
                                    if (timeSellController.manualList.length ==
                                        0) {
                                      errorSnackBar(
                                          "Minimum 1 manual is required",
                                          "Please add at least 1 manual");
                                    } else {
                                      if (_formKey.currentState.validate()) {
                                        updateScarTimeSalesDetail(
                                            body: jsonEncode(body));
                                      }
                                    }
                                  } else {
                                    if (_formKey.currentState.validate()) {
                                      updateScarTimeSalesDetail(
                                          body: jsonEncode(body));
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
                                    child: timeSellController.detailLoader.value
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
                      ),
                    ),
                    Obx(
                      () {
                        return timeSellController.isLoading.value
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

  editTimeSaleManualDialog(bool isEdit, {int index}) {
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
              SizedBox(
                height: 16,
              ),
              Text(
                "For every ",
                style: GoogleFonts.roboto(fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              SecondTextField(
                obscureText: false,
                hintText: "0",
                controller: timeSellController.addManualSale.value,
                validator: (val) {
                  return FieldValidator.validateValueIsEmpty(val);
                },
                enabled: true,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: mtextBoxColor,
                  border: Border.all(color: mborderColor),
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: Obx(() => DropdownButton(
                      underline: SizedBox(),
                      onChanged: (value) {
                        timeSellController.addHoursDay.value = value.toString();
                      },
                      isExpanded: true,
                      items: List.generate(
                          3,
                          (index) => DropdownMenuItem(
                                child: Text(index == 0
                                    ? "Minutes"
                                    : index == 1
                                        ? "Hours"
                                        : "Days"),
                                value: index,
                              )),
                      value: int.parse(timeSellController.addHoursDay.value),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Price Increased by ",
                style: GoogleFonts.roboto(fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              SecondTextField(
                obscureText: false,
                hintText: "0",
                prefixText: "\$",
                controller: timeSellController.addManualPrice.value,
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
                              timeSellController.manualList.removeAt(index);
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
                        if (isEdit) {
                          timeSellController.manualList[index] = TimeSellManual(
                              gDimeDriectUpsell: false,
                              sale: int.parse(
                                  timeSellController.addManualSale.value.text),
                              price:
                                  timeSellController.addManualPrice.value.text,
                              behavior: 1,
                              hourDay: timeSellController.addHoursDay.value);
                        } else {
                          timeSellController.manualList.add(TimeSellManual(
                              gDimeDriectUpsell: false,
                              sale: int.parse(
                                  timeSellController.addManualSale.value.text),
                              price:
                                  timeSellController.addManualPrice.value.text,
                              behavior: 1,
                              hourDay: timeSellController.addHoursDay.value));
                        }
                        Get.back();
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

  Widget label(String title) {
    return Container(
      margin: EdgeInsets.only(
        top: 20.0,
        bottom: 6.0,
      ),
      child: Text(
        title,
        style: GoogleFonts.roboto(
          color: mTextboxTitleColor,
          fontWeight: FontWeight.w500,
          fontSize: 15.0,
        ),
      ),
    );
  }

  Widget colorContainer(Color color) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.blueGrey)),
    );
  }
}
