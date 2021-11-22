import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dashboard/API/delete_downsell.dart';
import 'package:mint_bird_app/screens/dashboard/API/delete_order_form.dart';
import 'package:mint_bird_app/screens/dashboard/API/delete_upsell.dart';
import 'package:mint_bird_app/screens/product/models/added_bump_offer_model.dart';
import 'package:mint_bird_app/screens/product/models/user_product_model.dart';
import 'package:mint_bird_app/screens/upsell/models/user_upsell_model.dart';
import 'package:mint_bird_app/screens/upsell/upsell_details.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/widgets/delete_popup.dart';

import '../../downsell/downsell_detail.dart';
import '../../downsell/models/user_downsell_model.dart';
import '../controller/product_controller.dart';
import '../product_detail.dart';

Widget productListItem(ProductData data, index) {
  ProductController productController = Get.put(ProductController());
  return InkWell(
    onTap: () {
      productController.productUpSellDownSell.value = 'product';
      productController.productId.value = data.id;
      Get.to(
        ProductDetail(
          productId: data.id,
          productName: data.name,
        ),
      );
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            data.name,
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
                              child: Text(
                                "\$ ${data.price.toString()}",
                                style: GoogleFonts.mavenPro(
                                  fontWeight: FontWeight.w500,
                                  color: priceTextColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    Obx(() {
                      return Row(
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
                                  ? "${index == 0 ? 864 : 1268} |"
                                  : "${data.views} |",
                              style: GoogleFonts.mavenPro(
                                fontSize: 15,
                                color: mFunnelLableColor,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8.0),
                            child: Text(
                              authController.userDetailModel.value.data
                                          .username ==
                                      "chad"
                                  ? "Orders : ${index == 0 ? "155" : "278"} |"
                                  : "Orders : ${data.order} |",
                              style: GoogleFonts.mavenPro(
                                fontSize: 15,
                                color: mFunnelLableColor,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8.0),
                            child: Text(
                              authController.userDetailModel.value.data
                                          .username ==
                                      "chad"
                                  ? "Net revenue : ${index == 0 ? "\$4,185" : "\$7,506"}"
                                  : "Net revenue : \$${data.revenue}",
                              style: GoogleFonts.mavenPro(
                                fontSize: 15,
                                color: mFunnelLableColor,
                              ),
                            ),
                          ),
                        ],
                      );
                    })
                  ],
                ),
              ),
              deletePopUp(
                  title: "Order form",
                  onDelete: () {
                    deleteOrderForm(data.id);
                  }),
            ],
          ),
          SizedBox(height: 11),
          Divider()
        ],
      ),
    ),
  );
}

Widget upSellListItem(UpSellDatum data, index) {
  ProductController productController = Get.put(ProductController());
  return InkWell(
    onTap: () {
      productController.productUpSellDownSell.value = 'upsell';
      Get.to(UpSellDetail(data: data));
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
                            data.name,
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
                              child: Text(
                                "\$ ${data.price}",
                                style: GoogleFonts.mavenPro(
                                  fontWeight: FontWeight.w500,
                                  color: priceTextColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        )
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
                                    ? "${index == 0 ? 0 : index == 1 ? 864 : index == 2 ? 1268 : 553} |"
                                    : "${data.views == null ? '0' : data.views} |",
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
                                    ? "Orders : ${index == 0 ? 0 : index == 1 ? 155 : index == 2 ? 260 : 448}"
                                    : "Orders : ${data.order} |",
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
                                    ? "Sales : \$${index == 0 ? 0 : index == 1 ? "4,185" : index == 2 ? "7,506" : 448}"
                                    : "Sales : \$${data.totalSales} |",
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
                                    ? "Conv : ${index == 0 ? "22%" : index == 1 ? "18%" : index == 2 ? "11%" : "8%"} |"
                                    : "Conv : ${data.conv}% ",
                                style: GoogleFonts.mavenPro(
                                    fontSize: 15, color: mFunnelLableColor),
                              ),
                            ),
                          ],
                        ),
                      );
                    })
                  ],
                ),
              ),
              deletePopUp(
                  title: "Upsell",
                  onDelete: () {
                    deleteUpSell(data.id);
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

Widget downSellListItem(DownSellDatum data, index) {
  ProductController productController = Get.put(ProductController());
  return InkWell(
    onTap: () {
      productController.productUpSellDownSell.value = 'downsell';
      Get.to(DownSellDetail(data: data));
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
                            data.name,
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
                              child: Text(
                                "\$ ${data.price}",
                                style: GoogleFonts.mavenPro(
                                  fontWeight: FontWeight.w500,
                                  color: priceTextColor,
                                  fontSize: 14,
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
                                    : "${data.views == null ? '0' : data.views} |",
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
                                    : "Orders : ${data.order} |",
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
                                    : "Sales : \$${data.totalSales} |",
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
                                    : "Conv : ${data.conv}% ",
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
                  title: "Downsell",
                  onDelete: () {
                    deleteDownSell(data.id);
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

Widget bumpOfferListItem(AddedBumpOffer data) {
  return InkWell(
    onTap: () {
      // Get.to(ProductDetail());
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(data.offerName,
                              style: GoogleFonts.roboto(
                                  fontSize: 17, color: mTextColor)),
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
                                "\$ ${data.offerPrice}",
                                style: GoogleFonts.mavenPro(
                                    fontWeight: FontWeight.w500,
                                    color: mTextColor,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Image.asset(
                          AppString.iconImagesPath + 'ic_eye.png',
                          width: 15.0,
                          height: 15.0,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "0 |",
                            style: GoogleFonts.mavenPro(
                                fontSize: 15, color: mTextColor),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Conv : 0% |",
                            style: GoogleFonts.mavenPro(
                                fontSize: 15, color: mTextColor),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Sales : \$0",
                            style: GoogleFonts.mavenPro(
                                fontSize: 15, color: mTextColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.more_vert,
                color: mIconColor.withOpacity(0.3),
                size: 30.0,
              ),
            ],
          ),
          SizedBox(height: 11),
          Divider()
        ],
      ),
    ),
  );
}
