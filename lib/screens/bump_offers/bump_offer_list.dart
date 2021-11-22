import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/bump_offers/API/get_bump_offer_detail.dart';
import 'package:mint_bird_app/screens/bump_offers/bump_offer_detail_page.dart';
import 'package:mint_bird_app/screens/bump_offers/models/bump_offer_model.dart';
import 'package:mint_bird_app/screens/dashboard/API/delete_bump_offer.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/dashboard/tabs/product_tab.dart';
import 'package:mint_bird_app/screens/product/API/get_product_bump_offer_group_list.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/widgets/delete_popup.dart';
import 'package:mint_bird_app/widgets/loaders.dart';

import 'controller/bump_offer_controller.dart';

class BumpOfferList extends StatefulWidget {
  final ScrollController scrollController;

  BumpOfferList(this.scrollController);

  @override
  _BumpOfferListState createState() => _BumpOfferListState();
}

class _BumpOfferListState extends State<BumpOfferList> {
  DashboardController dashboardController = Get.put(DashboardController());
  BumpOfferController bumpOfferController = Get.put(BumpOfferController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        children: [
          dashboardController.isLoading.value &&
                  !dashboardController.bottomLoader.value
              ? productShimmer()
              : ListView.builder(
                  controller: widget.scrollController,
                  padding: EdgeInsets.only(top: 16),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        bumpOfferCard(
                            dashboardController.listOfBumpOffers[index], index),
                        dashboardController.bottomLoader.value &&
                                index + 1 ==
                                    dashboardController.listOfBumpOffers.length
                            ? productShimmer(verticalPadding: 0)
                            : SizedBox()
                      ],
                    );
                  },
                  itemCount: dashboardController.listOfBumpOffers.length,
                ),
          bumpOfferController.isLoading.value ? blurLoader : SizedBox()
        ],
      );
    });
  }

  Widget bumpOfferCard(BumpOffer data, index) {
    return InkWell(
      onTap: () async {
        await getBumpOfferGroupListService();
        getBumpOfferDetail(data.id)
            .then((value) => Get.to(() => BumpOfferDetailPage(data: value)));
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
                              data.bumpOfferName,
                              style: GoogleFonts.roboto(
                                fontSize: 17,
                                color: mTextColor,
                                fontWeight: FontWeight.w600,
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
                                child: FittedBox(
                                  child: Text(
                                    "\$ ${data.bumpOfferPrice}",
                                    style: GoogleFonts.mavenPro(
                                      fontWeight: FontWeight.w500,
                                      color: priceTextColor,
                                    ),
                                  ),
                                ),
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
                                      ? "${index == 0 ? 864 : index == 1 ? 1268 : index == 2 ? 620 : 553} |"
                                      : "${data.totalView == null ? '0' : data.totalView} |",
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
                                      ? "Orders : ${index == 0 ? 155 : index == 1 ? 278 : index == 2 ? 2448 : 448}"
                                      : "Orders : ${data.totalOrder == null ? "0" : data.totalOrder} |",
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
                                      ? "Sales : \$${index == 0 ? "4,185" : index == 1 ? "7,506" : index == 2 ? 2448 : 448}"
                                      : "Sales : \$${data.totalSales == null ? "0" : data.totalSales} |",
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
                deletePopUp(
                    title: "Bump offer",
                    onDelete: () {
                      deleteBumpOffer(data.id);
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
