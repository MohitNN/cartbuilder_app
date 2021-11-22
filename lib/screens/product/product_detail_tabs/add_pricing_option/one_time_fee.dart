import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/m_colors.dart';
import '../../../../utils/validator.dart';
import '../../../../widgets/second_textfield.dart';
import '../../controller/payment_options_controller.dart';
import '../../models/user_product_details.dart';

class OneTimeFee extends StatelessWidget {
  final PricingOptionElement pricingOptionDetails;

  OneTimeFee(this.pricingOptionDetails);

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  setData() {
    if (pricingOptionDetails != null) {
      productPriceController.text = pricingOptionDetails.pricingOption.price.toString();
      productNameController.text = pricingOptionDetails.pricingOption.pricingName.toString();
      paymentOptionsController.selectedTrailPeriod.value =
          pricingOptionDetails.pricingOption.trailPeriod.toString() == '0'
              ? paymentOptionsController.trailPeriod.first["id"].toString()
              : pricingOptionDetails.pricingOption.trailPeriod.toString();
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
          "Pricing name",
          style: GoogleFonts.roboto(
            color: mTextboxTitleColor,
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 14.0, bottom: 18.0),
          child: SecondTextField(
            controller: productNameController,
            hintText: "Pricing name",
            enabled: true,
            obscureText: false,
            validator: (val) {
              return FieldValidator.validateValueIsEmpty(val);
            },
            onChanged: (val) {
              paymentOptionsController.pricingName.value = val;
            },
          ),
        ),
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
          "Trial period",
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
              paymentOptionsController.trailPeriod.length,
              (index) {
                return DropdownMenuItem(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      paymentOptionsController.trailPeriod[index]["name"].toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: mIconColor,
                      ),
                    ),
                  ),
                  value: paymentOptionsController.trailPeriod[index]["id"].toString(),
                );
              },
            ),
            onChanged: (value) {
              paymentOptionsController.selectedTrailPeriod.value = value;
            },
            isExpanded: false,
            value: paymentOptionsController.selectedTrailPeriod.value,
            isDense: true,
          ),
        ),
        Obx(
          () {
            return (paymentOptionsController.selectedTrailPeriod.value == '5')
                ? Padding(
                    padding: EdgeInsets.only(bottom: 14.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: SecondTextField(
                            controller: numberController,
                            keyboardType: TextInputType.number,
                            hintText: 'Number',
                            enabled: true,
                            obscureText: false,
                            validator: (val) {
                              return FieldValidator.validateValueIsEmpty(val);
                            },
                            onChanged: (val) {
                              paymentOptionsController.trailNumber.value = val;
                            },
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Expanded(
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
                              paymentOptionsController.trailType.length,
                              (index) {
                                return DropdownMenuItem(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      paymentOptionsController.trailType[index]["name"].toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: mIconColor,
                                      ),
                                    ),
                                  ),
                                  value:
                                      paymentOptionsController.trailType[index]["name"].toString(),
                                );
                              },
                            ),
                            onChanged: (value) {
                              paymentOptionsController.selectedTrailType.value = value;
                            },
                            isExpanded: false,
                            value: paymentOptionsController.trailType.first["name"].toString(),
                            isDense: true,
                          ),
                        )
                      ],
                    ),
                  )
                : Container();
          },
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
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Obx(
                () {
                  return Text(
                    getStringMessage(
                      paymentOptionsController.selectedTrailPeriod.value,
                      dayMonthYear: paymentOptionsController.selectedTrailType.value,
                      num: numberController.text,
                    ),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w300,
                      color: mIconColor,
                      fontSize: 14,
                    ),
                  );
                },
              ),
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

  String getStringMessage(
    String val, {
    String num = '',
    String dayMonthYear = '',
  }) {
    switch (val) {
      case '1':
        return 'This is a free product and your customer will not be charged.';
        break;
      case '2':
        return 'Your customer will be charged \$0 USD in 1 time as soon as their trial period ends.';
        break;
      case '3':
        return 'Your customer will be charged \$0 USD in 3 time as soon as their trial period ends.';
        break;
      case '4':
        return 'Your customer will be charged \$0 USD in 7 time as soon as their trial period ends.';
        break;
      case '5':
        return 'Your customer will be charged \$0 USD in 30 time as soon as their trial period ends.';
        break;
      case '6':
        return (dayMonthYear == '7')
            ? 'Your customer will be charged \$0 USD in $num days time as soon as their trial period ends.'
            : (dayMonthYear == '8')
                ? 'Your customer will be charged \$0 USD in $num weeks time as soon as their trial period ends.'
                : (dayMonthYear == '9')
                    ? 'Your customer will be charged \$0 USD in $num months time as soon as their trial period ends.'
                    : 'Your customer will be charged \$0 USD in days time as soon as their trial period ends.';
        break;
      default:
        return 'This is a free product and your customer will not be charged.';
    }
  }
}
