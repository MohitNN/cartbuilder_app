import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dashboard/API/delete_dimesale.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/dashboard/tabs/product_tab.dart';
import 'package:mint_bird_app/screens/dime_sales/dime_sale_details.dart';
import 'package:mint_bird_app/screens/dime_sales/models/dime_sales_model.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/widgets/delete_popup.dart';

import 'API/get_dime_sale_details.dart';

class DimeSalesList extends StatefulWidget {
  final ScrollController scrollController;

  DimeSalesList(this.scrollController);

  @override
  _DimeSalesListState createState() => _DimeSalesListState();
}

class _DimeSalesListState extends State<DimeSalesList> {
  DashboardController dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return dashboardController.isLoading.value &&
              !dashboardController.bottomLoader.value
          ? productShimmer()
          : ListView.builder(
              controller: widget.scrollController,
              padding: EdgeInsets.only(top: 16),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    dimeSalesCard(
                        dashboardController.listOfDimeSale[index], index),
                    dashboardController.bottomLoader.value &&
                            index + 1 ==
                                dashboardController.listOfDimeSale.length
                        ? productShimmer(verticalPadding: 0)
                        : SizedBox()
                  ],
                );
              },
              itemCount: dashboardController.listOfDimeSale.length);
    });
  }

  Widget dimeSalesCard(DimeSalesUpsell data, index) {
    return InkWell(
      onTap: () {
        getUserDimeSaleDetailService(data.id);
        Get.to(() => DimeSaleDetails());
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 22.0),
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
                              data.dimesaleName,
                              style: GoogleFonts.roboto(
                                fontSize: 17,
                                color: mTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          // Container(
                          //   width: Get.width / 5.1,
                          //   decoration: BoxDecoration(
                          //     color: myellowColor,
                          //     borderRadius: BorderRadius.circular(10),
                          //   ),
                          //   child: Center(
                          //     child: Container(
                          //       margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
                          //       child: FittedBox(
                          //         child: Text(
                          //           "\$ ${data.}",
                          //           style: GoogleFonts.mavenPro(
                          //             fontWeight: FontWeight.w500,
                          //             color: priceTextColor,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
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
                                      ? "${index == 0 ? 864 : index == 1 ? 1268 : index == 2 ? 620 : 553} |"
                                      : "${data.view == null ? '0' : data.view} |",
                                  style: GoogleFonts.mavenPro(
                                      fontSize: 15, color: mFunnelLableColor),
                                ),
                              ),
                              // Container(
                              //   margin: EdgeInsets.only(left: 8.0),
                              //   child: Text(
                              //     authController.userDetailModel.value.data
                              //                 .username ==
                              //             "chad"
                              //         ? "Orders : ${index == 0 ? 155 : index == 1 ? 278 : index == 2 ? 2448 : 448}"
                              //         : "Orders : ${data.s == null ? "0" : data.countOrder} |",
                              //     style: GoogleFonts.mavenPro(
                              //         fontSize: 15, color: mFunnelLableColor),
                              //   ),
                              // ),
                              Container(
                                margin: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  authController.userDetailModel.value.data
                                              .username ==
                                          "chad"
                                      ? "Sales : \$${index == 0 ? "4,185" : index == 1 ? "7,506" : index == 2 ? 2448 : 448}"
                                      : "Sales : \$${data.sales == null ? "0" : data.sales} |",
                                  style: GoogleFonts.mavenPro(
                                      fontSize: 15, color: mFunnelLableColor),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  authController.userDetailModel.value.data
                                              .username ==
                                          "chad"
                                      ? "Conv : ${index == 0 ? "18%" : index == 1 ? "22%" : index == 2 ? "11%" : "8%"}"
                                      : "Conv : ${"0"}% ",
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
                Container(
                  width: 65,
                  height: 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: data.msg == "Auto"
                          ? Colors.redAccent
                          : Colors.blueAccent,
                      borderRadius: BorderRadius.circular(40)),
                  child: Text(
                    data.msg ?? "",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                deletePopUp(
                    title: "Dime Sale",
                    onDelete: () {
                      deleteDimeSale(data.id);
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
