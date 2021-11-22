import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/product/API/pricing_option/create_onetime_pricing_option.dart';
import 'package:mint_bird_app/screens/product/API/pricing_option/create_split_pay_pricing_option.dart';
import 'package:mint_bird_app/screens/product/API/pricing_option/create_subscription_pricing_option.dart';
import 'package:mint_bird_app/screens/product/controller/payment_options_controller.dart';
import 'package:mint_bird_app/screens/product/product_detail_tabs/add_pricing_option/one_time_fee.dart';
import 'package:mint_bird_app/screens/product/product_detail_tabs/add_pricing_option/split_pay.dart';
import 'package:mint_bird_app/screens/product/product_detail_tabs/add_pricing_option/subscription.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/widgets/loaders.dart';

import '../../../../main.dart';
import '../../../../widgets/border_button.dart';
import '../../../../widgets/custom_buttons.dart';
import '../../models/user_product_details.dart';

class AddPricingOptionPage extends StatelessWidget {
  final String pricing;
  final PricingOptionElement pricingOptionDetails;

  AddPricingOptionPage(this.pricing, {this.pricingOptionDetails});

  final formFieldKey = GlobalKey<FormState>();

  setData() {
    if (pricingOptionDetails != null) {
      paymentOptionsController.selectedPaymentType.value =
          (pricingOptionDetails.pricingOption.type == 'one_time')
              ? 'One-time fee'
              : (pricingOptionDetails.pricingOption.type == 'subscription')
                  ? 'Subscription'
                  : 'Split pay';
    }
  }

  @override
  Widget build(BuildContext context) {
    setData();
    return Stack(
      children: [
        Form(
          key: formFieldKey,
          child: Padding(
            padding: EdgeInsets.only(
              left: 22.0,
              right: 22.0,
            ),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.35,
                    vertical: 15.0,
                  ),
                  child: Divider(
                    color: mborderColor,
                    thickness: 3.0,
                    height: 3.0,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 21.0),
                  child: Text(
                    "$pricing Pricing options",
                    style: GoogleFonts.poppins(
                      color: mCustomizeTabText,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Text(
                  "Payment Type",
                  style: GoogleFonts.roboto(
                    color: mTextboxTitleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 14.0, bottom: 17.0),
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
                        ),
                      ),
                    ),
                    style: TextStyle(color: mBlackColor, fontSize: 16),
                    iconSize: 32,
                    items: List.generate(
                      paymentOptionsController.paymentType.length,
                      (index) {
                        return DropdownMenuItem(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              paymentOptionsController.paymentType[index]
                                      ["name"]
                                  .toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: mIconColor,
                              ),
                            ),
                          ),
                          value: paymentOptionsController.paymentType[index]
                                  ["name"]
                              .toString(),
                        );
                      },
                    ),
                    onChanged: (value) {
                      paymentOptionsController.selectedPaymentType.value =
                          value;
                    },
                    isExpanded: false,
                    value: paymentOptionsController.selectedPaymentType.value,
                    isDense: true,
                  ),
                ),
                Obx(() {
                  return paymentOptionsController.selectedPaymentType.value ==
                          'One-time fee'
                      ? OneTimeFee(pricingOptionDetails)
                      : paymentOptionsController.selectedPaymentType.value ==
                              'Subscription'
                          ? Subscription(pricingOptionDetails)
                          : SplitPay(pricingOptionDetails);
                }),
                Container(
                  margin: EdgeInsets.only(top: 17.0),
                  child: CustomButton(
                    width: Get.width,
                    height: 55.0,
                    text: "$pricing Pricing".toUpperCase(),
                    onPressed: () {
                      (paymentOptionsController.selectedPaymentType.value ==
                              'One-time fee')
                          ? createUpdateOnetimePricingOptionService(
                              createUpdate: pricing,
                              pricingOptionId: pricing == 'Edit'
                                  ? pricingOptionDetails.id
                                  : '',
                            )
                          : (paymentOptionsController
                                      .selectedPaymentType.value ==
                                  'Subscription')
                              ? createUpdateSubscriptionPricingOptionService(
                                  createUpdate: pricing,
                                  pricingOptionId: pricing == 'Edit'
                                      ? pricingOptionDetails.id
                                      : '',
                                )
                              : createUpdateSplitPayPricingOptionService(
                                  createUpdate: pricing,
                                  pricingOptionId: pricing == 'Edit'
                                      ? pricingOptionDetails.id
                                      : '',
                                );
                    },
                    textColor: mWhiteColor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
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
}
