import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/downsell/API/update_downsell_advance_setting.dart';
import 'package:mint_bird_app/screens/downsell/controller/downsell_controller.dart';
import 'package:mint_bird_app/screens/upsell/API/update_upsell_advance_setting.dart';
import 'package:mint_bird_app/screens/upsell/controller/upsell_controller.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/utils/validator.dart';
import 'package:mint_bird_app/widgets/loaders.dart';
import 'package:mint_bird_app/widgets/second_textfield.dart';
import '../../product/controller/product_controller.dart';

class TrackingScriptsPage extends StatelessWidget {
  final String id;

  TrackingScriptsPage(this.id);

  final TextEditingController headerController = TextEditingController();
  final TextEditingController footerController = TextEditingController();
  final TextEditingController fireScriptController = TextEditingController();
  final ProductController productController = Get.put(ProductController());
  final DownSellController downSellController = Get.put(DownSellController());
  final UpsellController upSellController = Get.put(UpsellController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: 4.0,
                    top: 15.0,
                  ),
                  child: Text(
                    "Embed HTML/Scripts in Header",
                    style: GoogleFonts.roboto(
                      color: mTextboxTitleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4.0, top: 10.0, bottom: 6.0),
                  child: Text(
                    "Embed any custom scripts or HTML code in the header of this product's checkout page.",
                    style: GoogleFonts.roboto(
                      color: mTextboxHintColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                SecondTextField(
                  controller: headerController,
                  hintText: "",
                  enabled: true,
                  maxline: 4,
                  obscureText: false,
                  validator: (val) {
                    return FieldValidator.validateValueIsEmpty(val);
                  },
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 4.0,
                    top: 15.0,
                  ),
                  child: Text(
                    "Embed HTML/Scripts in Footer",
                    style: GoogleFonts.roboto(
                      color: mTextboxTitleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4.0, top: 10.0, bottom: 6.0),
                  child: Text(
                    "Embed any custom scripts or HTML code in the footer of this product's checkout page.",
                    style: GoogleFonts.roboto(
                      color: mTextboxHintColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                SecondTextField(
                  controller: footerController,
                  hintText: "",
                  enabled: true,
                  maxline: 4,
                  obscureText: false,
                  validator: (val) {
                    return FieldValidator.validateValueIsEmpty(val);
                  },
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 4.0,
                    top: 15.0,
                  ),
                  child: Text(
                    "Fire pixels/scripts after an order is completed",
                    style: GoogleFonts.roboto(
                      color: mTextboxTitleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4.0, top: 10.0, bottom: 6.0),
                  child: Text(
                    "Embed any custom scripts or HTML code in the footer of this product's order summary page or just prior to a custom thank you page.",
                    style: GoogleFonts.roboto(
                      color: mTextboxHintColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                SecondTextField(
                  controller: fireScriptController,
                  hintText: "",
                  enabled: true,
                  maxline: 4,
                  obscureText: false,
                  validator: (val) {
                    return FieldValidator.validateValueIsEmpty(val);
                  },
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      (productController.productUpSellDownSell.value ==
                              'downsell')
                          ? updateDownSellTrackingScriptDetailService(
                              downSellId: id,
                              headerScripts: headerController.text,
                              footerScripts: footerController.text,
                              pixelFooterScripts: fireScriptController.text,
                            )
                          : updateUpSellTrackingScriptDetailService(
                              upSellId: id,
                              headerScripts: headerController.text,
                              footerScripts: footerController.text,
                              pixelFooterScripts: fireScriptController.text,
                            );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: mborderColor),
                      ),
                      padding: EdgeInsets.only(
                        top: 15.0,
                        bottom: 15.0,
                        left: 30.0,
                        right: 30.0,
                      ),
                      child: Image.asset(
                        AppString.iconImagesPath + "ic_savecloud.png",
                        width: 20,
                        height: 20,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Obx(
          () {
            return ((productController.productUpSellDownSell.value == 'downsell')
                ? downSellController.isLoading.value
                : upSellController.isLoading.value)
                    ? BackdropFilter(
                        filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                        child: appLoader,
                      )
                    : SizedBox();
          },
        ),
      ],
    );
  }
}
