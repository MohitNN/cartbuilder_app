import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/auth/login_screen.dart';
import 'package:mint_bird_app/screens/dashboard/API/get_chart_data.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/dashboard/tabs/funnel_tab.dart';
import 'package:mint_bird_app/screens/funnel/API/get_all_downsell.dart';
import 'package:mint_bird_app/screens/funnel/API/get_all_upsell.dart';
import 'package:mint_bird_app/screens/funnel/API/get_funnel.dart';
import 'package:mint_bird_app/screens/funnel/controller/funnel_controller.dart';
import 'package:mint_bird_app/screens/funnel/model/user_funnel_model.dart';
import 'package:mint_bird_app/screens/funnel/new_funnel_detail_page.dart';
import 'package:mint_bird_app/screens/product/API/get_favorite_product.dart';
import 'package:mint_bird_app/screens/product/API/get_recent_product.dart';
import 'package:mint_bird_app/screens/product/models/favorite_product_model.dart';
import 'package:mint_bird_app/screens/product/models/recent_product_model.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/widgets/customise_loading.dart';
import 'package:mint_bird_app/widgets/loading_image.dart';
import 'package:mint_bird_app/widgets/shimmer_loading_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  DashboardController dashboardController = Get.put(DashboardController());
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  List<Color> gradientColors = [
    Color(0xff00A3F5),
    Color(0xff00A3F5).withOpacity(0.8),
    Color(0xff00A3F5).withOpacity(0.5),
    Colors.white,
  ];

  @override
  void initState() {
    scrollController
      ..addListener(() {
        var triggerFetchMoreSize =
            0.9 * scrollController.position.maxScrollExtent;
        if (scrollController.position.pixels > triggerFetchMoreSize &&
            !dashboardController.bottomLoader.value) {
          if (dashboardController.currentPage.value !=
              dashboardController.lastPage.value) {
            dashboardController.bottomLoader.value = true;
            getUserFunnelService();
          }
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.only(left: 10, top: 32, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      dashboardController.scaffoldKey.value.currentState
                          .openDrawer();
                    },
                    icon: Icon(
                      Icons.menu_rounded,
                      color: Color(0xff707070),
                    )),
                Image.asset(
                  AppString.logoImagesPath + "mintbird-dashboard-logo.png",
                  width: Get.width / 3,
                ),
                PopupMenuButton<String>(
                  iconSize: 50,
                  icon: Obx(() {
                    return CircleAvatar(
                      backgroundColor: mPrimaryColor1,
                      radius: 25,
                      child: Text(
                        authController.userDetailModel.value.data?.name != null
                            ? authController.userDetailModel.value.data?.name[0]
                                    .toUpperCase() ??
                                ""
                            : "",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w300),
                      ),
                    );
                  }),
                  onSelected: (value) async {
                    if (value == "Logout") {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.clear();
                      Get.offAll(() => LoginScreen());
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return {'Logout', 'Settings'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: searchBarColor,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  onSubmitted: (value) {
                    dashboardController.searchQuery.value = value;
                    dashboardController.currentPage.value = 1;
                    dashboardController.lastPage.value = 0;
                    dashboardController.listOfFunnel.clear();
                    getUserFunnelService();
                  },
                  decoration: InputDecoration(
                    fillColor: Color(0xffE8EAED),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xff9CA7C1),
                    ),
                    border: InputBorder.none,
                    hintText: "Search Funnel",
                    hintStyle: GoogleFonts.roboto(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff545F7A),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    if (searchController.text.isNotEmpty) {
                      searchController.clear();
                      dashboardController.lastPage.value = 0;
                      dashboardController.searchQuery.value = "";
                      dashboardController.listOfFunnel.clear();
                      dashboardController.currentPage.value = 1;
                      getUserFunnelService();
                    }
                  },
                  child: Icon(
                    Icons.cancel_outlined,
                    color: Colors.blueGrey[400],
                  )),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        Obx(() {
          return dashboardController.searchQuery.value.length > 0
              ? Expanded(
                  child: dashboardController.isLoading.value &&
                          !dashboardController.bottomLoader.value
                      ? funnelShimmer()
                      : dashboardController.listOfFunnel.length == 0
                          ? Center(child: Text("No Funnel Found"))
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              controller: scrollController,
                              itemCount:
                                  dashboardController.listOfFunnel.length,
                              itemBuilder: (context, index) {
                                String group = '';
                                FunnelController funnelController =
                                    Get.put(FunnelController());
                                funnelController.funnelGroup.forEach((element) {
                                  if (dashboardController.listOfFunnel[index]
                                          .funnelDetails.funnelGroupTag ==
                                      element['id']) {
                                    group = element['name'];
                                  }
                                });
                                return Column(
                                  children: [
                                    funnelListItem(
                                      dashboardController.listOfFunnel[index],
                                      index,
                                      group,
                                    ),
                                    dashboardController.bottomLoader.value &&
                                            index + 1 ==
                                                dashboardController
                                                    .listOfFunnel.length
                                        ? funnelShimmer()
                                        : SizedBox()
                                  ],
                                );
                              }),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        dashboardController.isLoading.value
                            ? Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child:
                                    shimmerLoadingCard2(height: 45, radius: 5),
                              )
                            : Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: DropdownButton<String>(
                                    isExpanded: true,
                                    hint: Text("Select Product"),
                                    onChanged: (value) {
                                      dashboardController
                                          .selectedProduct.value = value;
                                      getChartDataService();
                                    },
                                    value: dashboardController
                                        .selectedProduct.value,
                                    underline: SizedBox(),
                                    items: List.generate(
                                        dashboardController.allProducts.length,
                                        (index) => DropdownMenuItem(
                                              child: Text(
                                                dashboardController
                                                    .allProducts[index]
                                                    .productName,
                                                style: TextStyle(
                                                    color: index == 0
                                                        ? mPrimaryColor1
                                                        : Colors.black,
                                                    fontWeight: index == 0
                                                        ? FontWeight.bold
                                                        : FontWeight.normal),
                                              ),
                                              value: dashboardController
                                                  .allProducts[index].id,
                                            ))),
                              ),
                        AspectRatio(
                          aspectRatio: 1.2,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(0),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: 18.0, left: 12.0, top: 24, bottom: 12),
                              child: LineChart(
                                mainData(),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            "Favorites",
                            style: GoogleFonts.poppins(
                              fontSize: 21,
                              color: mainLabelColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          child: FutureBuilder<List<FavoriteProduct>>(
                              future: getFavoriteProductService(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<FavoriteProduct> data = snapshot.data;

                                  return data.length != 0
                                      ? Container(
                                          height: 360,
                                          child: ListView.builder(
                                              padding:
                                                  EdgeInsets.only(left: 55),
                                              shrinkWrap: true,
                                              itemCount: data.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  width: 280,
                                                  margin: EdgeInsets.only(
                                                      right: 21),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: mLightGrey),
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Stack(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .vertical(
                                                          top: Radius.circular(
                                                              8),
                                                          bottom:
                                                              Radius.circular(
                                                                  8),
                                                        ),
                                                        child: Container(
                                                          height: 900,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: loadingImage(
                                                            data[index]
                                                                .templateImage,
                                                            fit: BoxFit.fill,
                                                            width:
                                                                double.infinity,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          16.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      data[index]
                                                                          .name,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                        fontSize:
                                                                            18,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            16,
                                                                        vertical:
                                                                            5),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                40),
                                                                        color: Color(
                                                                            0xffFDEDB1)),
                                                                    child: Text(
                                                                        "\$ ${data[index].price}"),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Divider(),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          10),
                                                              child: Row(
                                                                children: [
                                                                  infoData(
                                                                    "Check value",
                                                                    data[index]
                                                                        .checkoutView
                                                                        .toString(),
                                                                  ),
                                                                  infoData(
                                                                    "Order",
                                                                    data[index]
                                                                        .order
                                                                        .toString(),
                                                                  ),
                                                                  infoData(
                                                                      "Net Revenue",
                                                                      "\$${data[index].revenue}"),
                                                                ],
                                                              ),
                                                            ),
                                                            Divider(),
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            16,
                                                                        bottom:
                                                                            10.0),
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  horizontal:
                                                                      16,
                                                                  vertical: 5,
                                                                ),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            40),
                                                                    color: Color(
                                                                        0xff9FD2D7)),
                                                                child: Text(
                                                                  data[index]
                                                                      .group,
                                                                  style: GoogleFonts.roboto(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          10),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        )
                                      : Center(
                                          child: Text("No Favorites found"));
                                } else
                                  return favoriteShimmer();
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            "Recent Products",
                            style: GoogleFonts.poppins(
                              fontSize: 21,
                              color: mainLabelColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        FutureBuilder<List<RecentProducts>>(
                          future: getRecentProductService(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return snapshot.data.length != 0
                                  ? ListView.builder(
                                      padding: EdgeInsets.only(bottom: 50),
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 5),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            snapshot.data[index]
                                                                .productName,
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontSize: 17,
                                                              color: mTextColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            "Views : ${snapshot.data[index].view ?? '0'}",
                                                            style: GoogleFonts
                                                                .mavenPro(
                                                              fontSize: 14,
                                                              color:
                                                                  mFunnelLableColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 5,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40),
                                                        color: myellowColor,
                                                      ),
                                                      child: Text(
                                                        "\$${snapshot.data[index].productPrice}",
                                                        style: GoogleFonts
                                                            .mavenPro(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: priceTextColor,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              index + 1 != 6
                                                  ? Divider(height: 10)
                                                  : SizedBox(),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  : Center(
                                      child: Text("No Recent Products found"));
                            } else
                              return productShimmer();
                          },
                        )
                      ],
                    ),
                  ),
                );
        })
      ],
    );
  }

  Widget infoData(String title, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            style:
                GoogleFonts.roboto(fontSize: 11, fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            value,
            style:
                GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
          getTouchedSpotIndicator: (list, index) {
            return List.generate(
              index.length,
              (index) => TouchedSpotIndicatorData(FlLine(strokeWidth: 0),
                  FlDotData(getDotPainter: (v, v2, v3, v4) {
                return FlDotCirclePainter(
                  color: Colors.white,
                  strokeWidth: 2,
                  radius: 4.2,
                  strokeColor: Color(0xff00A3F5),
                );
              })),
            );
          },
          touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Colors.white,
              getTooltipItems: (list) {
                return List.generate(
                  list.length,
                  (index) => LineTooltipItem(
                      "\$${NumberFormat.compact().format(list[index].y.toInt())}",
                      GoogleFonts.mavenPro(
                          color: Color(0xff272768), fontSize: 12, height: 2),
                      children: [
                        TextSpan(
                            text: "\nJan ${list[index].x.toInt()}, 2021",
                            style: TextStyle(
                                color: Color(0xff8592B2), fontSize: 9)),
                      ],
                      textAlign: TextAlign.left),
                );
              })),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        verticalInterval: 7.75,
        horizontalInterval: 1000000,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Color(0xffEAEDF4),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Color(0xffEAEDF4),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff4d5676),
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1';
              case 3:
                return '3';
              case 5:
                return '5';
              case 7:
                return '7';
              case 9:
                return '9';
              case 11:
                return '11';
              case 13:
                return '13';
              case 15:
                return '15';
              case 17:
                return '17';
              case 19:
                return '19';
              case 21:
                return '21';
              case 23:
                return '23';
              case 25:
                return '25';
              case 27:
                return '27';
              case 29:
                return '29';
              case 31:
                return '31';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff4d5676),
            fontSize: 12,
          ),
          getTitles: (value) {
            if (value == 0) {
              return '\$0';
            } else if (value == dashboardController.yPoints["1"]) {
              return '\$${NumberFormat.compact().format(dashboardController.yPoints["1"])}';
            } else if (value == dashboardController.yPoints["2"]) {
              return '\$${NumberFormat.compact().format(dashboardController.yPoints["2"])}';
            } else if (value == dashboardController.yPoints["3"]) {
              return '\$${NumberFormat.compact().format(dashboardController.yPoints["3"])}';
            } else if (value == dashboardController.yPoints["4"]) {
              return '\$${NumberFormat.compact().format(dashboardController.yPoints["4"])}';
            } else if (value == dashboardController.yPoints["5"]) {
              return '\$${NumberFormat.compact().format(dashboardController.yPoints["5"])}';
            } else {
              return '';
            }
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xffEAEDF4), width: 1)),
      minX: dashboardController.minX.value.toDouble(),
      maxX: dashboardController.maxX.value.toDouble(),
      minY: 0,
      maxY: dashboardController.maxValue.value.toDouble(),
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(dashboardController.chartData.length, (index) {
            int charIn =
                dashboardController.chartData[index].key.lastIndexOf("-");
            String data =
                "${dashboardController.chartData[index].key[charIn + 1]}${dashboardController.chartData[index].key[charIn + 2]}";
            return FlSpot(double.parse(data),
                dashboardController.chartData[index].value.toDouble());
          }),
          // [
          //   FlSpot(1, 1600),
          //   FlSpot(4, 1800),
          //   FlSpot(8, 1600),
          //   FlSpot(12, 2000),
          //   FlSpot(16, 1800),
          //   FlSpot(20, 2200),
          //   FlSpot(24, 2000),
          //   FlSpot(28, 2400),
          //   FlSpot(31, 2800),
          // ]

          isCurved: true,
          colors: gradientColors,
          gradientTo: Offset(0, 100),
          barWidth: 3,
          curveSmoothness: 0.1,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradientFrom: Offset(0, 0),
            gradientTo: Offset(0, 1),
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  Widget favoriteShimmer() {
    return Container(
      height: 360,
      child: ListView.builder(
          padding: EdgeInsets.only(left: 55),
          shrinkWrap: true,
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              width: 280,
              margin: EdgeInsets.only(right: 21),
              decoration: BoxDecoration(
                  border: Border.all(color: mLightGrey),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  Expanded(
                      child: ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(8)),
                          child: shimmerLoadingCard(radius: 0))),
                  Expanded(
                      child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                flex: 3, child: shimmerLoadingCard(height: 10)),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(child: shimmerLoadingCard(height: 20)),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            infoShimmer(),
                            SizedBox(
                              width: 10,
                            ),
                            infoShimmer(),
                            SizedBox(
                              width: 10,
                            ),
                            infoShimmer(),
                            SizedBox(
                              width: 16,
                            )
                          ],
                        ),
                      ),
                      Divider(),
                      Row(
                        children: [
                          Spacer(flex: 3),
                          Expanded(child: shimmerLoadingCard(height: 10)),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      )
                    ],
                  ))
                ],
              ),
            );
          }),
    );
  }

  Widget infoShimmer() {
    return Expanded(
      child: Column(
        children: [
          shimmerLoadingCard(height: 10),
          SizedBox(
            height: 7,
          ),
          shimmerLoadingCard(height: 20)
        ],
      ),
    );
  }

  Widget productShimmer() {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        itemCount: 2,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: shimmerLoadingCard(height: 15)),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(child: shimmerLoadingCard(height: 20)),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: shimmerLoadingCard(height: 15)),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(child: shimmerLoadingCard(height: 20)),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(child: shimmerLoadingCard(height: 20)),
                    Spacer(
                      flex: 2,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
            ],
          );
        });
  }
}

Widget funnelListItem(FunnelDatum data, index, String group) {
  FunnelController funnelController = Get.put(FunnelController());
  funnelController.funnelGroup.forEach((element) {
    if (data.id == element["id"]) {
      print(element["name"]);
    }
  });
  return Container(
    margin: EdgeInsets.only(left: 18.0, right: 11.0, bottom: 16.0),
    decoration: BoxDecoration(
      color: mWhiteColor,
      border: Border.all(color: mborderColor),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () async {
          await getAllUpsell();
          await getAllDownsell();
          funnelController.upsellId.clear();
          funnelController.downsellId.clear();
          if (data.funnelsProduct != null) {
            getFunnelListBloc.setFunnelList(data.funnelsProduct.obs);
            funnelController.funnelProducts = data.funnelsProduct.obs;
            data.funnelsProduct.forEach((element) {
              funnelController.upsellId.add(element.upsell);
              if (element.downsell != null) {
                element.downsell.forEach((element2) {
                  funnelController.downsellId.add(element2.downsell);
                });
              }
            });
          } else {
            funnelController.funnelProducts.clear();
          }
          funnelController.funnelId.value = data.id;
          Get.to(() => NewFunnelDetailPage(data: data));
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 7.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      data.funnelDetails.funnelName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: mBlackColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width / 5.1,
                    decoration: BoxDecoration(
                      color: myellowColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
                        child: Text(
                          "\$ ${data.funnelPrice}",
                          style: TextStyle(
                            color: mDrawerUnameColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: mborderColor,
              thickness: 1.0,
              height: 1.0,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 15.0,
                top: 6.0,
                bottom: 6.0,
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  labelNumber("Views", data.views.toString()),
                  labelNumber("Orders", data.order.toString()),
                  labelNumber("Sales", "\$${data.totalSales}"),
                  labelNumber("Conv", "${data.conv.toString()}%"),
                  SizedBox(width: 10.0),
                  Icon(
                    Icons.more_vert,
                    color: mIconColor.withOpacity(0.3),
                    size: 30.0,
                  ),
                ],
              ),
            ),
            Divider(
              color: mborderColor,
              thickness: 1.0,
              height: 1.0,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
                margin: EdgeInsets.symmetric(vertical: 7.0, horizontal: 18.0),
                decoration: BoxDecoration(
                  color: mSellsFunnelColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  group,
                  style: GoogleFonts.roboto(
                    color: mWhiteColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
