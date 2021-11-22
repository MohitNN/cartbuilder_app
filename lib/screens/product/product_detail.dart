import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/auth/API/get_user_connected_account.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/dashboard/widgets/create_product.dart';
import 'package:mint_bird_app/screens/product/API/get_product_groups_details.dart';
import 'package:mint_bird_app/screens/product/API/get_user_product_details.dart';
import 'package:mint_bird_app/screens/product/API/scarcity/get_scarcity_product.dart';
import 'package:mint_bird_app/screens/product/API/update_product_funnel_status_service.dart';
import 'package:mint_bird_app/screens/product/API/update_product_status.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/screens/product/models/user_product_details.dart';
import 'package:mint_bird_app/screens/product/product_detail_tabs/product_bump_offer_page.dart';
import 'package:mint_bird_app/screens/product/product_detail_tabs/product_checkout_design_template.dart';
import 'package:mint_bird_app/screens/product/product_detail_tabs/product_detail_tab.dart';
import 'package:mint_bird_app/screens/product/product_detail_tabs/product_payment_options_page.dart';
import 'package:mint_bird_app/screens/product/product_detail_tabs/product_success_page.dart';
import 'package:mint_bird_app/screens/product/product_detail_tabs/scarcity/scarity_sale.dart';
import 'package:mint_bird_app/screens/upsell/upsell_detail_tabs/product_delivery.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/utils/validator.dart';
import 'package:mint_bird_app/widgets/border_button.dart';
import 'package:mint_bird_app/widgets/custom_buttons.dart';
import 'package:mint_bird_app/widgets/second_textfield.dart';
import 'package:mint_bird_app/widgets/shimmer_loading_card.dart';

import '../../main.dart';
import '../../widgets/loaders.dart';

class ProductDetail extends StatefulWidget {
  final String productId;
  final String productName;

  const ProductDetail({
    Key key,
    this.productId,
    this.productName,
  }) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  ProductController productController = Get.put(ProductController());
  DashboardController dashboardController = Get.put(DashboardController());
  TabController _tabController;
  bool status = false;
  bool selectedStripe = false;
  int checkOutDesignTemplate;
  int successDesignTemplate;

  List<SelectedPaymentOption> selectedCreditCardProcessorList = [];
  List<SelectedPaymentOption> selectedAdditionalPaymentOptionsList = [];

  List<String> tabs = [
    'Order Form Details',
    'Payment Options',
    'Checkout Design',
    'Success Page',
    'Order Form Delivery',
    'Bump Offer Page',
    'Scarcity Sale',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: mBgColor,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: mbackColor,
              size: 20.0,
            ),
          ),
          title: Text(
            widget.productName,
            style: GoogleFonts.roboto(
              color: mTextColor,
              fontSize: 21,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: mCustomizeTabBorder),
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: Image.asset(
                AppString.iconImagesPath + "ic_eye_.png",
                height: 24,
                width: 24,
              ),
            ),
          ],
          elevation: 0,
        ),
        body: FutureBuilder<UserProductDetailsModel>(
            future: getUserProductDetailsService(widget.productId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                productController.addToFunnelSwitch.value =
                    snapshot.data.product.isFunnel ?? false;
                dashboardController.selectedTagList.value =
                    snapshot.data.product.productDetails.productTag == null
                        ? ""
                        : snapshot.data.product.productDetails.productTag;
                productController.liveModeSwitch.value =
                    snapshot.data.product.productDetails.productStatus == 1
                        ? true
                        : false;
                checkOutDesignTemplate =
                    snapshot.data.product.checkoutDesign != null
                        ? snapshot.data.product.checkoutDesign.templateId - 1
                        : 0;
                successDesignTemplate =
                    snapshot.data.product.successDesign != null
                        ? snapshot.data.product.successDesign.templateId - 1
                        : 0;
                productGroups.forEach((element) {
                  if (element.id ==
                      snapshot.data.product.productDetails.productGroupTag)
                    productController.selectedGroupValue = element.name.obs;
                });
                List<String> payments = [];
                if (snapshot.data.product.paymentOptions != null)
                  snapshot.data.product.paymentOptions
                      .forEach((element) => payments.add(element));
                selectedCreditCardProcessorList.clear();
                selectedAdditionalPaymentOptionsList.clear();
                creditCardProcessorList.forEach((element) {
                  selectedCreditCardProcessorList.add(
                    SelectedPaymentOption(
                      id: element.id,
                      label: element.account.type,
                      isSelected: payments.contains(element.id) ? true : false,
                    ),
                  );
                });
                if (additionalPaymentOptionsList != null) {
                  additionalPaymentOptionsList.forEach((element) {
                    selectedAdditionalPaymentOptionsList.add(
                      SelectedPaymentOption(
                        id: element.id,
                        label: element.account.type,
                        isSelected:
                            payments.contains(element.id) ? true : false,
                      ),
                    );
                  });
                }
                productController.isLoading.value=false;
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ADD TO FUNNEL",
                              style: GoogleFonts.roboto(
                                color: mTextboxTitleColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0,
                              ),
                            ),
                            Obx(
                              () => Transform.scale(
                                scale: 0.8,
                                child: CupertinoSwitch(
                                  activeColor: mBtnColor,
                                  onChanged: (val) {
                                    productController.addToFunnelSwitch.value =
                                        val;
                                    updateProductFunnelStatusService();
                                  },
                                  value:
                                      productController.addToFunnelSwitch.value,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "LIVE MODE",
                              style: GoogleFonts.roboto(
                                color: mTextboxTitleColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0,
                              ),
                            ),
                            Obx(
                              () => Transform.scale(
                                scale: 0.8,
                                child: CupertinoSwitch(
                                  activeColor: mBtnColor,
                                  onChanged: (val) {
                                    productController.liveModeSwitch.value =
                                        val;
                                    updateProductStatusService(
                                        snapshot.data.product.id);
                                  },
                                  value: productController.liveModeSwitch.value,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TabBar(
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      labelPadding: const EdgeInsets.all(15.0),
                      tabs: [
                        for (int i = 0; i < tabs.length; i++)
                          Text(
                            tabs[i],
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                      ],
                      controller: _tabController,
                      isScrollable: true,
                      indicatorColor: mBtnColor,
                      labelColor: mBtnColor,
                      labelStyle: TextStyle(color: mBtnColor),
                      unselectedLabelColor: mTextColor,
                      onTap: (value) {
                        if (value == 2) {
                          productController.selectedCheckoutTemplate.value =
                              checkOutDesignTemplate ?? 99;
                          productController.checkOutTabIndex.value = 0;
                        }
                        if (value == 3) {
                          productController.selectedSuccessTemplate.value =
                              successDesignTemplate ?? 99;
                          productController.successTabIndex.value = 0;
                        }
                        if (value == 6) {
                          getScarcityProductService();
                        }
                      },
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          ProductDetailTab(
                            productDetail: snapshot.data.product,
                          ),
                          ProductPaymentOptionsPage(
                            snapshot.data.product,
                            selectedCreditCardProcessorList,
                            selectedAdditionalPaymentOptionsList,
                          ),
                          ProductCheckoutDesignTemplate(
                            id: snapshot.data.product.id,
                            url: snapshot.data.product.checkoutPageUrl,
                          ),
                          ProductSuccessPage(
                            selectedTemplate:
                                snapshot.data.product.successDesign != null
                                    ? snapshot.data.product.checkoutDesign
                                            .templateId -
                                        1
                                    : 0,
                          ),
                          ProductDeliveryPage(
                            membershipPlatform:
                                snapshot.data.product.typeOfDelivery,
                            id: snapshot.data.product.id,
                          ),
                          ProductBumpOffer(productId: snapshot.data.product.id),
                          ScarcitySale(),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return productDetailShimmer();
              }
            }),
      ),
    );
  }
}

Widget editProductPayment() {
  return Stack(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: formFieldKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.35,
                  vertical: 8.0,
                ),
                child: Divider(height: 3, thickness: 3),
              ),
              Text(
                "Edit Pricing Options",
                style: GoogleFonts.poppins(
                  color: mCustomizeTabText,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0, left: 4.0),
                child: Text(
                  "Payment type",
                  style: GoogleFonts.roboto(
                    color: mTextboxTitleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0, left: 4.0),
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
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: mIconColor,
                        size: 20.0,
                      ),
                    ),
                  ),
                  style: TextStyle(color: mBlackColor, fontSize: 16),
                  iconSize: 32,
                  items: List.generate(7, (index) {
                    return DropdownMenuItem(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "One time fee",
                          style: TextStyle(
                            fontSize: 14,
                            color: mIconColor,
                          ),
                        ),
                      ),
                      value: index.toString(),
                    );
                  }),
                  onChanged: (value) {},
                  isExpanded: false,
                  value: "0",
                  isDense: true,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16.0, left: 4.0),
                child: Text(
                  "Pricing name",
                  style: GoogleFonts.roboto(
                    color: mTextboxTitleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: SecondTextField(
                  controller: productNameController,
                  hintText: "Pricing name",
                  enabled: true,
                  obscureText: false,
                  validator: (val) {
                    return FieldValidator.validateValueIsEmpty(val);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16.0, left: 4.0),
                child: Text(
                  "Price",
                  style: GoogleFonts.roboto(
                    color: mTextboxTitleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 4.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Container(
                        padding: EdgeInsets.all(13.0),
                        decoration: BoxDecoration(
                          color: mWhiteColor,
                          border: Border.all(color: mborderColor),
                        ),
                        child: Icon(
                          Icons.attach_money,
                          size: 22.0,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SecondTextField(
                        keyboardType: TextInputType.number,
                        controller: productPriceController,
                        hintText: "",
                        enabled: true,
                        obscureText: false,
                        validator: (val) {
                          return FieldValidator.validateValueIsEmpty(val);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16.0, left: 4.0),
                child: Text(
                  "Trial period",
                  style: GoogleFonts.roboto(
                    color: mTextboxTitleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0, left: 4.0),
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
                            color: mIconColor,
                            size: 20.0,
                          ))),
                  style: TextStyle(color: mBlackColor, fontSize: 16),
                  iconSize: 32,
                  items: List.generate(7, (index) {
                    return DropdownMenuItem(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "${index + 1} Day".toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: mIconColor,
                          ),
                        ),
                      ),
                      value: "${index + 1} Day",
                    );
                  }),
                  onChanged: (value) {},
                  isExpanded: false,
                  value: "1 Day",
                  isDense: true,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 17.0, left: 4.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: mborderColor)),
                width: Get.width,
                height: 55,
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      decoration: BoxDecoration(
                          color: mPurple,
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(6))),
                    ),
                    SizedBox(
                      width: 28,
                    ),
                    Text(
                      "Your customer will be charged \$122",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w300,
                          color: mIconColor,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0, left: 4.0),
                child: CustomButton(
                  width: Get.width,
                  height: 55.0,
                  text: "SAVE".toUpperCase(),
                  onPressed: () {},
                  textColor: mWhiteColor,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 20.0, left: 4.0),
                child: BorderButton(
                  width: Get.width,
                  height: 55.0,
                  text: "Cancel".toUpperCase(),
                  onPressed: () {
                    Get.back();
                  },
                  textColor: mDisableTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
      Obx(() {
        return authController.loading.value
            ? BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.white.withOpacity(0.5),
                  child: appLoader,
                ),
              )
            : SizedBox();
      })
    ],
  );
}

Widget productDetailShimmer() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 36.0),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 6.0),
            child: shimmerLoadingCard(height: 15, width: 100),
          ),
          shimmerLoadingCard(height: 50),
          Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 6.0),
              child: shimmerLoadingCard(height: 15, width: 100)),
          Row(
            children: <Widget>[
              shimmerLoadingCard(height: 50, width: 50),
              SizedBox(
                width: 10,
              ),
              Expanded(child: shimmerLoadingCard(height: 50)),
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 4.0),
              child: shimmerLoadingCard(height: 15, width: 150)),
          shimmerLoadingCard(height: 40, width: 150),
          Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 6.0),
              child: shimmerLoadingCard(height: 15, width: 100)),
          shimmerLoadingCard(height: 100, radius: 10),
          Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 6.0),
              child: shimmerLoadingCard(height: 15, width: 100)),
          Container(
            margin: EdgeInsets.only(top: 15.0, bottom: 6.0),
            child: shimmerLoadingCard(height: 50),
          ),
          Container(
              margin: EdgeInsets.only(top: 20.0, bottom: 6.0),
              child: shimmerLoadingCard(height: 15, width: 100)),
          shimmerLoadingCard(height: 50),
          Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 6.0),
            child: Row(
              children: [
                Expanded(child: shimmerLoadingCard(height: 25)),
                SizedBox(
                  width: 16,
                ),
                Expanded(child: shimmerLoadingCard(height: 25))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 6.0),
            child: Row(
              children: [
                Expanded(child: shimmerLoadingCard(height: 15)),
                SizedBox(
                  width: 16,
                ),
                Expanded(child: shimmerLoadingCard(height: 15))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0, bottom: 6.0),
            child: Row(
              children: [
                Expanded(child: shimmerLoadingCard(height: 25)),
                SizedBox(
                  width: 16,
                ),
                Expanded(child: shimmerLoadingCard(height: 25))
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
