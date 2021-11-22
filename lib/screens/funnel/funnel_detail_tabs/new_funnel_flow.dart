import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/funnel/API/delete_funnel_flow_products.dart';
import 'package:mint_bird_app/screens/funnel/API/update_funnel_flow.dart';
import 'package:mint_bird_app/screens/funnel/controller/funnel_controller.dart';
import 'package:mint_bird_app/screens/funnel/funnel_detail_tabs/upsell_edit.dart';
import 'package:mint_bird_app/screens/funnel/model/single_funnel_product_model.dart';
import 'package:mint_bird_app/screens/upsell/controller/upsell_controller.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/widgets/loaders.dart';
import 'package:mint_bird_app/widgets/shimmer_loading_card.dart';

class NewFunnelFlow extends StatefulWidget {
  @override
  _NewFunnelFlowState createState() => _NewFunnelFlowState();
}

class _NewFunnelFlowState extends State<NewFunnelFlow> {
  FunnelController funnelController = Get.put(FunnelController());
  UpsellController upsellController = Get.put(UpsellController());
  DashboardController dashboardController = Get.put(DashboardController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Obx(() {
                    return funnelController.newFunnelProductList.length == 0
                        ? Container(
                            height: 250,
                            alignment: Alignment.center,
                            child: Text("No funnel flow found"),
                          )
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.all(16),
                            shrinkWrap: true,
                            itemCount:
                                funnelController.newFunnelProductList.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  upSellCard(
                                      funnelController
                                          .newFunnelProductList[index],
                                      index),
                                  funnelController
                                              .newFunnelProductList.length ==
                                          index + 1
                                      ? SizedBox()
                                      : Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 12),
                                              height: 17.5,
                                              child: VerticalDivider(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        )
                                ],
                              );
                            });
                  }),
                  InkWell(
                    onTap: () async {
                      funnelController.isUpsellOpen.value = true;
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      height: 79,
                      decoration: DottedDecoration(
                          shape: Shape.box,
                          borderRadius: BorderRadius.circular(8),
                          color: mBlue,
                          strokeWidth: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 35,
                            color: mBlue,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Add Upsell",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                color: mBlue,
                                fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // InkWell(
                  //   onTap: () async {
                  //   },
                  //   child: Container(
                  //     height: 79,
                  //     decoration: DottedDecoration(
                  //         shape: Shape.box,
                  //         borderRadius: BorderRadius.circular(8),
                  //         color: mBlue,
                  //         strokeWidth: 2),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Icon(
                  //           Icons.add,
                  //           size: 35,
                  //           color: mBlue,
                  //         ),
                  //         SizedBox(
                  //           width: 10,
                  //         ),
                  //         Text(
                  //           "Add DownSell",
                  //           style: GoogleFonts.poppins(
                  //               fontWeight: FontWeight.w700,
                  //               color: mBlue,
                  //               fontSize: 20),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Container(
                    height: 79,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.message_outlined,
                          size: 35,
                          color: mDividerColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Thank You Page",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              color: mDividerColor,
                              fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
            upsellList(),
            downsellList(),
            Obx(() =>
                funnelController.isLoading.value ? blurLoader : SizedBox())
          ],
        ),
      ),
    );
  }

  Widget upSellCard(FunnelsProduct1 data, int index) {
    String name;
    funnelController.allUpsellModel.value.response.forEach((element) {
      if (element.upsellId == data.upsell) {
        name = element.upsellName;
      }
    });
    return Column(
      children: [
        Container(
          height: 83,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xff7676761A).withOpacity(0.2),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                )
              ]),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: mGreen,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(6),
                  ),
                ),
                width: 6.7,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Icon(
                  Icons.menu,
                  color: mLightGrey,
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: SvgPicture.asset(
                    "assets/icon/greenBox.svg",
                    height: 35,
                    color: mGreen,
                  )),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  name ?? "",
                  style: GoogleFonts.roboto(
                      color: mTextboxTitleColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
              data.downsell.length > 0
                  ? SizedBox()
                  : InkWell(
                      onTap: () {
                        funnelController.isDownsellOpen.value = true;
                        funnelController.selectedUpsellIndex.value = index;
                        funnelController.selectedUpsellId.value = data.upsell;
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                            color: mOrange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(40)),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icon/orangeBox.svg",
                              height: 25,
                              color: mOrange,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.add,
                              color: mOrange,
                            )
                          ],
                        ),
                      ),
                    ),
              SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {
                  upsellController.upsellLoads.value = 0.0;
                  Get.to(
                    () => UpsellEdit(
                      name: name,
                      upsellId: data.upsell,
                      type: "fupsell",
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(color: mLightGrey, shape: BoxShape.circle),
                  child: Icon(
                    Icons.edit,
                    color: Color(0xffcccccc),
                  ),
                ),
              ),
              PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Text("Delete"),
                      value: 0,
                    )
                  ];
                },
                onSelected: (value) {
                  Get.defaultDialog(
                      title: "Are you sure you want to delete this upsell ?",
                      barrierDismissible: false,
                      content: SizedBox(),
                      radius: 5,
                      actions: [
                        SizedBox(
                          height: 45,
                          child: MaterialButton(
                            onPressed: () {
                              print(funnelController.funnelId.value);
                              Get.back();
                            },
                            child: Text("NO",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16)),
                          ),
                        ),
                        SizedBox(
                          height: 45,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            onPressed: () {
                              deleteFunnelFlowProducts(
                                  index.toString(), null, null);
                              Get.back();
                            },
                            child: Text(
                              "Yes, Delete",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            color: Colors.redAccent,
                          ),
                        ),
                      ]);
                },
                child: Icon(
                  Icons.more_vert_rounded,
                  color: Color(0xffcccccc),
                ),
              )
            ],
          ),
        ),
        data.downsell.length > 0
            ? Row(
                children: [
                  Obx(() {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      height: 17.5,
                      child: VerticalDivider(
                        color: funnelController.newFunnelProductList.length ==
                                index + 1
                            ? Colors.transparent
                            : Colors.black,
                      ),
                    );
                  }),
                  Container(
                    margin: EdgeInsets.only(left: 100),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 12.5,
                          child: VerticalDivider(
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.5),
                              shape: BoxShape.circle),
                        )
                      ],
                    ),
                  )
                ],
              )
            : SizedBox(),
        data.downsell.length > 0
            ? downSellCard(data.downsell.first, index, data.upsell)
            : SizedBox()
      ],
    );
  }

  Widget downSellCard(Downsell data, int index, String upsellId) {
    String name;
    funnelController.allDownsellModel.value.response.forEach((element) {
      if (element.downsellId == data.downsell) {
        name = element.downsellName;
      }
    });
    return Row(
      children: [
        Obx(() {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            height: 83,
            child: VerticalDivider(
              color: funnelController.newFunnelProductList.length == index + 1
                  ? Colors.transparent
                  : Colors.black,
            ),
          );
        }),
        Expanded(
          child: Container(
            height: 83,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff7676761A).withOpacity(0.2),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  )
                ]),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: mOrange,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(6),
                    ),
                  ),
                  width: 6.7,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    Icons.menu,
                    color: mLightGrey,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: SvgPicture.asset(
                      "assets/icon/orangeBox.svg",
                      height: 35,
                      color: mOrange,
                    )),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    name ?? "",
                    style: GoogleFonts.roboto(
                        color: mTextboxTitleColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => UpsellEdit(
                          name: name,
                          upsellId: data.downsell,
                          type: "fdownsell",
                        ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: mLightGrey, shape: BoxShape.circle),
                    child: Icon(
                      Icons.edit,
                      color: Color(0xffcccccc),
                    ),
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Text("Delete"),
                        value: 0,
                      )
                    ];
                  },
                  onSelected: (value) {
                    Get.defaultDialog(
                        title:
                            "Are you sure you want to delete this downsell ?",
                        barrierDismissible: false,
                        content: SizedBox(),
                        radius: 5,
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 45,
                                child: MaterialButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text("NO",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16)),
                                ),
                              ),
                              SizedBox(
                                height: 45,
                                child: MaterialButton(
                                  onPressed: () {
                                    deleteFunnelFlowProducts(
                                        index.toString(), "0", upsellId);
                                    Get.back();
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    "Yes, Delete",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  color: Colors.redAccent,
                                ),
                              )
                            ],
                          )
                        ]);
                  },
                  child: Icon(
                    Icons.more_vert_rounded,
                    color: Color(0xffcccccc),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget upsellList() {
    return Obx(() {
      return AnimatedPositioned(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        bottom: funnelController.isUpsellOpen.value ? 0 : -Get.height / 1.5,
        child: Container(
            height: Get.height / 1.5,
            width: Get.width,
            color: Colors.white,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: () {
                          funnelController.isUpsellOpen.value = false;
                        },
                        icon: Icon(Icons.close))),
                Expanded(
                    child: dashboardController.isLoading.value &&
                            !dashboardController.bottomLoader.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : funnelController
                                    .allUpsellModel.value.response.length ==
                                0
                            ? Center(
                                child: Text("No Upsell Found"),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                itemCount: funnelController
                                    .allUpsellModel.value.response.length,
                                itemBuilder: (context, index) {
                                  return funnelController.existingFunnelUpsells
                                          .contains(funnelController
                                              .allUpsellModel
                                              .value
                                              .response[index]
                                              .upsellId)
                                      ? SizedBox()
                                      : InkWell(
                                          onTap: () {
                                            updateFunnelFlow(
                                                funnelController
                                                    .allUpsellModel
                                                    .value
                                                    .response[index]
                                                    .upsellId,
                                                null);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 10, right: 10, bottom: 7),
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0xff2B2B2B29),
                                                  offset: Offset(0, 2),
                                                  blurRadius: 6,
                                                )
                                              ],
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    funnelController
                                                            .allUpsellModel
                                                            .value
                                                            .response[index]
                                                            .upsellName ??
                                                        "",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffFDEDB1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40)),
                                                  child: Text(
                                                      "\$${funnelController.allUpsellModel.value.response[index].upsellPrice}"),
                                                ),
                                                SizedBox(width: 5),
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff00A3F5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40)),
                                                  child: Icon(
                                                    Icons
                                                        .arrow_forward_ios_outlined,
                                                    size: 10,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                }))
              ],
            )),
      );
    });
  }

  Widget downsellList() {
    return Obx(() {
      return AnimatedPositioned(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        bottom: funnelController.isDownsellOpen.value ? 0 : -Get.height / 1.5,
        child: Container(
            height: Get.height / 1.5,
            width: Get.width,
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: () {
                          funnelController.isDownsellOpen.value = false;
                        },
                        icon: Icon(Icons.close))),
                Expanded(
                    child: funnelController
                                .allDownsellModel.value.response.length ==
                            0
                        ? Center(
                            child: Text("No dowmsell Found"),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            itemCount: funnelController
                                .allDownsellModel.value.response.length,
                            itemBuilder: (context, index) {
                              return funnelController.existingFunnelDownsell
                                      .contains(funnelController
                                          .allDownsellModel
                                          .value
                                          .response[index]
                                          .downsellId)
                                  ? SizedBox()
                                  : InkWell(
                                      onTap: () {
                                        updateFunnelFlow(
                                            "",
                                            funnelController
                                                .allDownsellModel
                                                .value
                                                .response[index]
                                                .downsellId);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 7),
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xff2B2B2B29),
                                              offset: Offset(0, 2),
                                              blurRadius: 6,
                                            )
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                funnelController
                                                    .allDownsellModel
                                                    .value
                                                    .response[index]
                                                    .downsellName,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 10),
                                              decoration: BoxDecoration(
                                                  color: Color(0xffFDEDB1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40)),
                                              child: Text(
                                                  "\$${funnelController.allDownsellModel.value.response[index].downsellPrice}"),
                                            ),
                                            SizedBox(width: 5),
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: Color(0xff00A3F5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40)),
                                              child: Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 10,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                            }))
              ],
            )),
      );
    });
  }

  Widget productShimmer({double verticalPadding}) {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding ?? 20, horizontal: 10),
        itemCount: 7,
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
