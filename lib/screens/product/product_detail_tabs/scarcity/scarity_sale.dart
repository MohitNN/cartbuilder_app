import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/dime_sales/API/get_dime_sales.dart';
import 'package:mint_bird_app/screens/dime_sales/API/get_dimesales_grop_list.dart';
import 'package:mint_bird_app/screens/dime_sales/controller/dime_sell_controller.dart';
import 'package:mint_bird_app/screens/product/API/scarcity/delete_added_sale.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/screens/product/models/scarcity/scarcity_products_model.dart';
import 'package:mint_bird_app/screens/product/product_detail_tabs/scarcity/scarcity_dialog.dart';
import 'package:mint_bird_app/screens/product/product_detail_tabs/scarcity/scarcity_dime_sale_detail.dart';
import 'package:mint_bird_app/screens/product/product_detail_tabs/scarcity/scarcity_time_sale_details.dart';
import 'package:mint_bird_app/screens/time_sales/API/get_timesales_grop_list.dart';
import 'package:mint_bird_app/screens/time_sales/API/time_sale_list.dart';
import 'package:mint_bird_app/screens/time_sales/controller/timesell_controller.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/widgets/delete_popup.dart';
import 'package:mint_bird_app/widgets/loaders.dart';

class ScarcitySale extends StatefulWidget {
  @override
  _ScarcitySaleState createState() => _ScarcitySaleState();
}

class _ScarcitySaleState extends State<ScarcitySale> {
  ProductController productController = Get.put(ProductController());
  DashboardController dashboardController = Get.put(DashboardController());
  DimeSellController dimeSellController = Get.put(DimeSellController());
  TimeSellController timeSellController = Get.put(TimeSellController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        floatingActionButton:
            productController.scarcityModel.value.data?.timesale == null &&
                    productController.scarcityModel.value.data?.dimesale == null
                ? FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () async {
                      dashboardController.selectedTimeSales.clear();
                      dashboardController.selectedDimeSales.clear();
                      productController.timeDime.value = 0;
                      dashboardController.listOfTimesell.clear();
                      dashboardController.listOfDimeSale.clear();
                      dashboardController.selectedTimeSaleId.value = "";
                      dashboardController.selectedDimeSaleId.value = "";
                      await getTimeSalesGroupListService();
                      await getDimeSalesGroupListService();
                      await getUserAllTimeSalesService();
                      await getUserAllDimeSalesService();
                      productController.selectedTimeSaleGroup.value =
                          productController.timeSalesGroup.first["id"];
                      dashboardController.listOfTimesell.forEach((element) {
                        var name = productController.timeSalesGroup.firstWhere(
                            (element1) =>
                                element1["id"] ==
                                productController.selectedTimeSaleGroup.value);
                        if (element.groupName == name["name"]) {
                          if (!dashboardController.selectedTimeSales
                              .contains(element)) {
                            dashboardController.selectedTimeSales.add(element);
                          }
                        }
                      });
                      if (dashboardController.selectedTimeSales.length != 0) {
                        dashboardController.selectedTimeSaleId.value =
                            dashboardController.selectedTimeSales.first.id;
                      }
                      productController.selectedDimeSaleGroup.value =
                          productController.dimeSalesGroup.first["id"];
                      dashboardController.listOfDimeSale.forEach((element) {
                        var name = productController.dimeSalesGroup.firstWhere(
                            (element1) =>
                                element1["id"] ==
                                productController.selectedDimeSaleGroup.value);
                        if (element.groupName == name["name"]) {
                          dashboardController.selectedDimeSales.add(element);
                        }
                      });
                      if (dashboardController.selectedDimeSales.length != 0) {
                        dashboardController.selectedDimeSaleId.value =
                            dashboardController.selectedDimeSales.first.id;
                      }
                      showDialog(
                          barrierDismissible: false,
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
                              child: createScarcity(context),
                            );
                          });
                    },
                    backgroundColor: mPrimaryColor,
                  )
                : null,
        body: dashboardController.isLoading.value ||
                productController.isLoading.value
            ? blurLoader
            : productController.scarcityModel.value.data.timesale == null &&
                    productController.scarcityModel.value.data.dimesale == null
                ? Center(
                    child: Text("No Sales Found"),
                  )
                : Column(
                    children: [
                      productController.scarcityModel.value.data.timesale ==
                              null
                          ? SizedBox()
                          : scarCityCard(
                              productController
                                  .scarcityModel.value.data.timesale,
                              0),
                      productController.scarcityModel.value.data.dimesale ==
                              null
                          ? SizedBox()
                          : scarCityDimeCard(
                              productController
                                  .scarcityModel.value.data.dimesale,
                              0),
                    ],
                  ),
      ),
    );
  }

  Widget scarCityCard(ScarTimesale data, index) {
    return InkWell(
      onTap: () {
        if (data.sales.length != 0) {
          timeSellController.salesController.value.text =
              data.sales.first.auto.first.sale.toString();
          timeSellController.incrementController.value.text =
              data.sales.first.auto.first.price;
          timeSellController.autoManual.value =
              data.sales.first.timesettime == "manual" ? 1 : 0;
          timeSellController.selectedTime.value =
              data.sales.first.auto.first.hourDay == "0" ? 0 : 1;
          timeSellController.manualList.value = data.sales.first.manual;
          timeSellController.autoList.value = data.sales.first.auto;
          timeSellController.isActive.value = data.sales.first.active;
        } else {
          timeSellController.salesController.value.text = "1";
          timeSellController.incrementController.value.text = "1";
          timeSellController.autoManual.value = 0;
          timeSellController.selectedTime.value = 0;
        }
        timeSellController.tabBarTextController.value.text = data.topBarText;
        timeSellController.tabBarBoldTextController.value.text =
            data.topBarBoldText;
        timeSellController.tabBarRegularTextController.value.text =
            data.topBarRegularText;
        timeSellController.topBarColor.value =
            Color(int.parse(data.theme.topBarColor.replaceAll("#", "0xff")));
        timeSellController.textColor.value =
            Color(int.parse(data.theme.textColor.replaceAll("#", "0xff")));
        timeSellController.boldTextColor.value =
            Color(int.parse(data.theme.boldTextColor.replaceAll("#", "0xff")));
        timeSellController.timerColor.value =
            Color(int.parse(data.theme.timerColor.replaceAll("#", "0xff")));
        timeSellController.timerTextColor.value =
            Color(int.parse(data.theme.timerTextColor.replaceAll("#", "0xff")));
        timeSellController.buttonColor.value =
            Color(int.parse(data.theme.buttonColor.replaceAll("#", "0xff")));
        timeSellController.buttonTextColor.value = Color(
            int.parse(data.theme.buttonTextColor.replaceAll("#", "0xff")));
        timeSellController.timeSaleId.value = data.id;
        timeSellController.nameController.value.text =
            productController.scarcityModel.value.data.timeSaleName;
        timeSellController.summaryTimer.value =
            data.isOrderSummaryTimer == "true" ? true : false;
        timeSellController.timerTextController.value.text =
            data.orderSummaryTimerText;
        Get.to(() => ScarcityTimeSaleDetail());
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 22.0, vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              productController
                                  .scarcityModel.value.data.timeSaleName,
                              style: GoogleFonts.roboto(
                                fontSize: 17,
                                color: mTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Obx(() {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Image.asset(
                                AppString.iconImagesPath + 'ic_eye.png',
                                width: 15.0,
                                height: 15.0,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  authController.userDetailModel.value.data
                                              .username ==
                                          "chad"
                                      ? "${index == 0 ? 864 : index == 1 ? 1268 : index == 2 ? 620 : 553}"
                                      : "${data.countViews == null ? '0' : data.countViews}",
                                  style: GoogleFonts.mavenPro(
                                      fontSize: 15, color: mFunnelLableColor),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                deletePopUp(
                    title: "Time Sale",
                    onDelete: () {
                      deleteAddedSale(data.id, "timesale");
                    })
              ],
            ),
            SizedBox(height: 11),
            Divider()
          ],
        ),
      ),
    );
  }

  Widget scarCityDimeCard(ScarDimesale data, index) {
    return InkWell(
      onTap: () {
        dimeSellController.nameController.value.text =
            productController.scarcityModel.value.data.dimeSaleName;
        if (data.sales.length != 0) {
          dimeSellController.salesController.value.text =
              data.sales.first.auto.first.sale.toString();
          dimeSellController.incrementController.value.text =
              data.sales.first.auto.first.price;
          dimeSellController.manualList.value = data.sales.first.manual;
          dimeSellController.autoList.value = data.sales.first.auto;
          dimeSellController.isActive.value = data.sales.first.active;
          dimeSellController.autoManual.value =
              data.sales.first.timeset == "auto" ? 0 : 1;
        } else {
          dimeSellController.salesController.value.text = "10";
          dimeSellController.manualList.clear();
          dimeSellController.incrementController.value.clear();
        }
        dimeSellController.tabBarTextController.value.text = data.topBarText;
        dimeSellController.tabBarBoldTextController.value.text =
            data.topBarBoldText;
        dimeSellController.tabBarRegularTextController.value.text =
            data.topBarRegularText;
        dimeSellController.topBarColor.value =
            Color(int.parse(data.theme.topBarColor.replaceAll("#", "0xff")));
        dimeSellController.textColor.value =
            Color(int.parse(data.theme.textColor.replaceAll("#", "0xff")));
        dimeSellController.boldTextColor.value =
            Color(int.parse(data.theme.boldTextColor.replaceAll("#", "0xff")));
        dimeSellController.timerColor.value =
            Color(int.parse(data.theme.timerColor.replaceAll("#", "0xff")));
        dimeSellController.timerTextColor.value =
            Color(int.parse(data.theme.timerTextColor.replaceAll("#", "0xff")));
        dimeSellController.buttonColor.value =
            Color(int.parse(data.theme.buttonColor.replaceAll("#", "0xff")));
        dimeSellController.buttonTextColor.value = Color(
            int.parse(data.theme.buttonTextColor.replaceAll("#", "0xff")));
        dimeSellController.dimeSaleId.value = data.id;
        dimeSellController.nameController.value.text =
            productController.scarcityModel.value.data.dimesale.dimeSaleName;

        Get.to(() => ScarcityDimeSaleDetails());
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 22.0, vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              data.dimeSaleName,
                              style: GoogleFonts.roboto(
                                fontSize: 17,
                                color: mTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Obx(() {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Image.asset(
                                AppString.iconImagesPath + 'ic_eye.png',
                                width: 15.0,
                                height: 15.0,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  authController.userDetailModel.value.data
                                              .username ==
                                          "chad"
                                      ? "${index == 0 ? 864 : index == 1 ? 1268 : index == 2 ? 620 : 553}"
                                      : "${data.countViews == null ? '0' : data.countViews}",
                                  style: GoogleFonts.mavenPro(
                                      fontSize: 15, color: mFunnelLableColor),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                deletePopUp(
                    title: "Dime Sale",
                    onDelete: () {
                      deleteAddedSale(data.id, "dimesale");
                    })
              ],
            ),
            SizedBox(height: 11),
            Divider()
          ],
        ),
      ),
    );
  }
}
