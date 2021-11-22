import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/m_colors.dart';
import '../../../../utils/validator.dart';
import '../../../../widgets/second_textfield.dart';
import '../../controller/payment_options_controller.dart';
import '../../models/user_product_details.dart';

class Subscription extends StatelessWidget {
  final PricingOptionElement pricingOptionDetails;

  Subscription(this.pricingOptionDetails);

  final TextEditingController monthlyPriceController = TextEditingController();
  final TextEditingController todayPriceController = TextEditingController();

  setData() {
    if (pricingOptionDetails != null) {
      print("=-=-=- ${pricingOptionDetails.toJson()}");
      paymentOptionsController.selectedBillingFrequency.value =
          pricingOptionDetails.pricingOption.billingFrequency.toString();
      monthlyPriceController.text = pricingOptionDetails.pricingOption.trailPeriod.toString();
      todayPriceController.text = pricingOptionDetails.pricingOption.todaysPrice.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    setData();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Billing frequency",
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
              paymentOptionsController.billingFrequency.length,
              (index) {
                return DropdownMenuItem(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      paymentOptionsController.billingFrequency[index]["name"].toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: mIconColor,
                      ),
                    ),
                  ),
                  value: paymentOptionsController.billingFrequency[index]["id"].toString(),
                );
              },
            ),
            onChanged: (value) {
              paymentOptionsController.selectedBillingFrequency.value = value;
            },
            isExpanded: false,
            value: paymentOptionsController.selectedBillingFrequency.value,
            isDense: true,
          ),
        ),
        Text(
          "Monthly price",
          style: GoogleFonts.roboto(
            color: mTextboxTitleColor,
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 14.0, bottom: 17.0),
          child: SecondTextField(
            controller: monthlyPriceController,
            keyboardType: TextInputType.number,
            hintText: "Monthly price",
            enabled: true,
            obscureText: false,
            validator: (val) {
              return FieldValidator.validateValueIsEmpty(val);
            },
            onChanged: (val) {
              paymentOptionsController.monthlyProductPrice.value = val;
            },
          ),
        ),
        Text(
          "Today's price",
          style: GoogleFonts.roboto(
            color: mTextboxTitleColor,
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 14.0, bottom: 17.0),
          child: SecondTextField(
            controller: todayPriceController,
            keyboardType: TextInputType.number,
            hintText: "Today's price",
            enabled: true,
            obscureText: false,
            validator: (val) {
              return FieldValidator.validateValueIsEmpty(val);
            },
            onChanged: (val) {
              paymentOptionsController.todayProductPrice.value = val;
            },
          ),
        ),
        Text(
          "Limit quantity available?",
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
              paymentOptionsController.limitQuantityAvailable.length,
              (index) {
                return DropdownMenuItem(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      paymentOptionsController.limitQuantityAvailable[index]["name"].toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: mIconColor,
                      ),
                    ),
                  ),
                  value: paymentOptionsController.limitQuantityAvailable[index]["id"].toString(),
                );
              },
            ),
            onChanged: (value) {
              paymentOptionsController.selectedLimitQuantityAvailable.value = value;
            },
            isExpanded: false,
            value: paymentOptionsController.limitQuantityAvailable.first["id"].toString(),
            isDense: true,
          ),
        ),
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: mWhiteColor,
            border: Border.all(color: mborderColor),
            borderRadius: BorderRadius.circular(3.0),
          ),
          alignment: Alignment.center,
          child: Obx(
            () => Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                'Your customer will be charged \$${paymentOptionsController.monthlyProductPrice.value} ${paymentOptionsController.selectedBillingFrequency.value}, and then again every ${paymentOptionsController.selectedBillingFrequency.value}.',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w300,
                  color: mIconColor,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
