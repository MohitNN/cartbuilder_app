import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/product/product_detail_tabs/add_pricing_option/add_pricing_option_page.dart';
import 'package:mint_bird_app/screens/product/product_detail_tabs/payment_options_list_widget.dart';
import 'package:mint_bird_app/utils/app_strings.dart';

import '../../../utils/m_colors.dart';
import '../../../widgets/custom_buttons.dart';
import '../../auth/API/get_user_connected_account.dart';
import '../models/user_product_details.dart';
import 'payment_options_list_widget.dart';

class ProductPaymentOptionsPage extends StatelessWidget {
  final Product productDetail;
  final List<SelectedPaymentOption> selectedCreditCardProcessorList;
  final List<SelectedPaymentOption> selectedAdditionalPaymentOptionsList;

  ProductPaymentOptionsPage(
    this.productDetail,
    this.selectedCreditCardProcessorList,
    this.selectedAdditionalPaymentOptionsList,
  );

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (selectedCreditCardProcessorList.length == 0 &&
              selectedAdditionalPaymentOptionsList.length == 0)
            Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
              alignment: Alignment.center,
              child: Text(
                "Setup Payment Processor.",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          selectedCreditCardProcessorList.length == 0
              ? selectedAdditionalPaymentOptionsList.length == 0
                  ? Container()
                  : Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
                      alignment: Alignment.center,
                      child: Text(
                        "No Credit Card Processor Found",
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20.0, bottom: 6.0, left: 6),
                      child: Text(
                        "Credit Card Processor",
                        style: GoogleFonts.roboto(
                          color: mTextboxTitleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    SingleSelectionPaymentOptions(
                        selectedPaymentOption: selectedCreditCardProcessorList),
                  ],
                ),
          selectedAdditionalPaymentOptionsList.length == 0
              ? selectedCreditCardProcessorList.length == 0
                  ? Container()
                  : Container(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
                      alignment: Alignment.center,
                      child: Text(
                        "No Additional Payments found",
                        style: TextStyle(color: Colors.blue),
                      ))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20.0, bottom: 6.0),
                      child: Text(
                        "Additional Payment Options",
                        style: GoogleFonts.roboto(
                          color: mTextboxTitleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    MultiSelectionPaymentOptions(
                        selectedPaymentOption: selectedAdditionalPaymentOptionsList),
                  ],
                ),
          Container(
            margin: EdgeInsets.only(
              left: 4.0,
              top: 18.0,
            ),
            child: Text(
              "Payment Options For Your Product",
              style: GoogleFonts.roboto(
                color: mTextboxTitleColor,
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10.0),
              child: ListView.builder(
                // separatorBuilder:
                //     (BuildContext context, int index) =>
                //         Padding(
                //   padding: const EdgeInsets.symmetric(
                //       horizontal: 15.0),
                //   child: Divider(),
                // ),
                itemCount: productDetail.pricingOptions.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Padding(
                          padding: EdgeInsets.only(bottom: 5.0, left: 5.0),
                          child: Text(
                            productDetail.pricingOptions[index].pricingOption.pricingName ??
                                "No title",
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: mTextColor,
                            ),
                          ),
                        ),
                        subtitle: RichText(
                          text: TextSpan(
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: mTextboxTitleColor,
                            ),
                            children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.attach_money,
                                  color: mTextboxTitleColor,
                                  size: 20,
                                ),
                              ),
                              TextSpan(
                                text: productDetail.pricingOptions[index].pricingOption.price ==
                                        'null'
                                    ? productDetail
                                                .pricingOptions[index].pricingOption.todaysPrice ==
                                            null
                                        ? '0'
                                        : productDetail
                                            .pricingOptions[index].pricingOption.todaysPrice
                                            .toString()
                                    : productDetail.pricingOptions[index].pricingOption.price
                                        .toString(),
                              ),
                            ],
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Get.dialog(
                              Dialog(
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
                                child: AddPricingOptionPage('Edit',
                                    pricingOptionDetails: productDetail.pricingOptions[index]),
                              ),
                            );
                          },
                          icon: Image.asset(
                            AppString.iconImagesPath + 'ic_opt.png',
                            width: 22.0,
                            height: 22.0,
                          ),
                        ),
                        onTap: () {},
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Divider(),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 10.0, bottom: 40.0),
            child: CustomButton(
              width: Get.width / 1.3,
              height: 57.0,
              text: "ADD PRICING OPTION".toUpperCase(),
              onPressed: () {
                Get.dialog(
                  Dialog(
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
                    child: AddPricingOptionPage('Add'),
                  ),
                );
              },
              textColor: mWhiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
