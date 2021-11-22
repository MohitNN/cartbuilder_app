import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/m_colors.dart';
import '../../../../utils/validator.dart';
import '../../../../widgets/second_textfield.dart';
import '../../controller/payment_options_controller.dart';
import '../../models/user_product_details.dart';

class SplitPay extends StatelessWidget {
  final PricingOptionElement pricingOptionDetails;

  SplitPay(this.pricingOptionDetails);

  final TextEditingController productPriceController = TextEditingController();

  setData() {
    if (pricingOptionDetails != null) {
      productPriceController.text = pricingOptionDetails.pricingOption.price;
      paymentOptionsController.selectedNumbersOfPayment.value =
          pricingOptionDetails.pricingOption.noOfSplits.toString();
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
          "Price",
          style: GoogleFonts.roboto(
            color: mTextboxTitleColor,
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 14.0, bottom: 18.0),
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
                    color: mIconColor,
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
                  onChanged: (val) {
                    paymentOptionsController.productPrice.value = val;
                  },
                ),
              ),
            ],
          ),
        ),
        Text(
          "Numbers of payments",
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
              paymentOptionsController.numbersOfPayment.length,
              (index) {
                return DropdownMenuItem(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      paymentOptionsController.numbersOfPayment[index]["name"].toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: mIconColor,
                      ),
                    ),
                  ),
                  value: paymentOptionsController.numbersOfPayment[index]["id"].toString(),
                );
              },
            ),
            onChanged: (value) {
              paymentOptionsController.selectedNumbersOfPayment.value = value;
            },
            isExpanded: false,
            value: paymentOptionsController.selectedNumbersOfPayment.value,
            isDense: true,
          ),
        ),
        Container(
          width: Get.width,
          margin: EdgeInsets.only(bottom: 17.0),
          decoration: BoxDecoration(
            color: mBtnColor,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Container(
            width: Get.width,
            margin: EdgeInsets.only(left: 4.0),
            decoration: BoxDecoration(
              color: mWhiteColor,
              border: Border.all(color: mborderColor),
              borderRadius: BorderRadius.circular(3.0),
            ),
            alignment: Alignment.center,
            child: Obx(
              () {
                return Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    'Your customer will be charged \$${paymentOptionsController.productPrice.value} USD immediately, and then \$${paymentOptionsController.productPrice.value} USD every month for the next 1 months. The total amount paid for the product will be \$${int.parse(paymentOptionsController.productPrice.value) * (int.parse(paymentOptionsController.selectedNumbersOfPayment.value) + 1)} USD.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w300,
                      color: mIconColor,
                      fontSize: 14,
                    ),
                  ),
                );
              },
            ),
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
                'Your customer will be charged \$${paymentOptionsController.productPrice.value}',
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
