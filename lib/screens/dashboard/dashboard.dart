import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/bump_offers/create_bump_offer.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/dashboard/tabs/account/account_tab.dart';
import 'package:mint_bird_app/screens/dashboard/tabs/funnel_tab.dart';
import 'package:mint_bird_app/screens/dashboard/tabs/home_tab.dart';
import 'package:mint_bird_app/screens/dashboard/tabs/product_tab.dart';
import 'package:mint_bird_app/screens/dashboard/widgets/action_sheet_items.dart';
import 'package:mint_bird_app/screens/dashboard/widgets/app_bottom_navigation_bar.dart';
import 'package:mint_bird_app/screens/dashboard/widgets/app_drawer.dart';
import 'package:mint_bird_app/screens/dashboard/widgets/create_downsell.dart';
import 'package:mint_bird_app/screens/dashboard/widgets/create_funnel.dart';
import 'package:mint_bird_app/screens/dashboard/widgets/create_product.dart';
import 'package:mint_bird_app/screens/dashboard/widgets/create_upsell.dart';
import 'package:mint_bird_app/screens/dime_sales/API/get_dimesales_grop_list.dart';
import 'package:mint_bird_app/screens/dime_sales/create_dime_sales.dart';
import 'package:mint_bird_app/screens/downsell/API/get_downsell_group.dart';
import 'package:mint_bird_app/screens/downsell/controller/downsell_controller.dart';
import 'package:mint_bird_app/screens/funnel/API/get_funnel_group.dart';
import 'package:mint_bird_app/screens/funnel/controller/funnel_controller.dart';
import 'package:mint_bird_app/screens/product/API/get_product_bump_offer_group_list.dart';
import 'package:mint_bird_app/screens/product/API/get_product_group.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/screens/time_sales/API/get_timesales_grop_list.dart';
import 'package:mint_bird_app/screens/time_sales/create_time_sales.dart';
import 'package:mint_bird_app/screens/upsell/API/get_upsell_group.dart';
import 'package:mint_bird_app/screens/upsell/controller/upsell_controller.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/widgets/popover.dart';

import '../../widgets/loaders.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  DashboardController dashboardController = Get.put(DashboardController());
  ProductController productController = Get.put(ProductController());
  FunnelController funnelController = Get.put(FunnelController());
  UpsellController upsellController = Get.put(UpsellController());
  DownSellController downSellController = Get.put(DownSellController());
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: mBgColor,
      key: dashboardController.scaffoldKey.value,
      drawer: appDrawer(),
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: PageView(
                controller: dashboardController.pageController.value,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  HomeTab(),
                  ProductTab(),
                  FunnelTab(),
                  AccountTab(),
                  // Reporting(),
                ],
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mPrimaryColor1,
        child: Icon(
          Icons.add,
          color: mWhiteColor,
          size: 22,
        ),
        onPressed: handleFABPressed,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  handleFABPressed() {
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Popover(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 15.0, bottom: 5),
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: mTextboxTitleColor,
                        ),
                      ),
                    ),
                  ),
                  Divider(color: mDividerColor),
                  actionSheetItems(
                      title: "Build New Funnel",
                      description: "This is a Quick description of the product",
                      icon: "ic_funnel.png",
                      onTap: () async {
                        await getFunnelGroupService();
                        Get.back();
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
                                child: createFunnel(context),
                              );
                            });
                      }),
                  Divider(
                    color: mDividerColor.withOpacity(0.5),
                  ),
                  actionSheetItems(
                      title: "Create New Order Form",
                      description:
                          "From here you are able to create the order form",
                      icon: "ic_product.png",
                      onTap: () async {
                        await getProductGroupService();
                        Get.back();
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
                                child: createProduct(context),
                              );
                            });
                      }),
                  Divider(
                    color: mDividerColor.withOpacity(0.5),
                  ),
                  actionSheetItems(
                      title: "Create New Upsell",
                      description:
                          "From here you are able to create the upsell",
                      icon: "ic_cart_up.png",
                      onTap: () async {
                        await getUpSellGroupService();
                        Get.back();
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
                                child: createUpsell(context),
                              );
                            });
                      }),
                  Divider(
                    color: mDividerColor.withOpacity(0.5),
                  ),
                  actionSheetItems(
                      title: "Create New Downsell",
                      description:
                          "From here you are able to create the downsell",
                      icon: "ic_funnel_down.png",
                      onTap: () async {
                        await getDownSellGroupService();
                        Get.back();
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
                                child: createDownsell(context),
                              );
                            });
                      }),
                  Divider(
                    color: mDividerColor.withOpacity(0.5),
                  ),
                  actionSheetItems(
                      title: "Create New Bump Offer",
                      description:
                          "From here you are able to create the bump offer",
                      icon: "ic_funnel_down.png",
                      onTap: () async {
                        await getBumpOfferGroupListService();
                        Get.back();
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
                              child: createBumpOffer(context),
                            );
                          },
                        );
                      }),
                  Divider(
                    color: mDividerColor.withOpacity(0.5),
                  ),
                  actionSheetItems(
                      title: "Create New Dime Sale",
                      description:
                          "From here you are able to create the dime sale",
                      icon: "ic_funnel_down.png",
                      onTap: () async {
                        await getDimeSalesGroupListService();
                        Get.back();
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
                              child: createDimeSales(context),
                            );
                          },
                        );
                      }),
                  Divider(
                    color: mDividerColor.withOpacity(0.5),
                  ),
                  actionSheetItems(
                      title: "Create New Time Sale",
                      description:
                          "From here you are able to create the time sale",
                      icon: "ic_funnel_down.png",
                      onTap: () async {
                        await getTimeSalesGroupListService();
                        productController.selectedTimeSaleGroup.value =
                            productController.timeSalesGroup.first["id"];
                        Get.back();
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
                              child: createTimeSales(context),
                            );
                          },
                        );
                      }),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
              Obx(() {
                return productController.isLoading.value ||
                        downSellController.isLoading.value ||
                        upsellController.isLoading.value ||
                        funnelController.isLoading.value
                    ? blurLoader
                    : SizedBox();
              })
            ],
          ),
        );
      },
    );
  }
}
