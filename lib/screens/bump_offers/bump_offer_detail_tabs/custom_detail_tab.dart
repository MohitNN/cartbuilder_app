import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/bump_offers/API/update_bump_offer_detail.dart';
import 'package:mint_bird_app/screens/bump_offers/bump_offer_detail_tabs/custome_offer_box.dart';
import 'package:mint_bird_app/screens/bump_offers/controller/bump_offer_controller.dart';
import 'package:mint_bird_app/screens/bump_offers/models/bump_offer_detail_model.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/utils/validator.dart';
import 'package:mint_bird_app/widgets/second_textfield.dart';

class BumpOfferDetailTab extends StatefulWidget {
  final BumpOfferDetailDataModel data;

  BumpOfferDetailTab(this.data);

  @override
  _BumpOfferDetailTabState createState() => _BumpOfferDetailTabState();
}

class _BumpOfferDetailTabState extends State<BumpOfferDetailTab> {
  final formFieldKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final ProductController productController = Get.put(ProductController());
  final DashboardController dashboardController =
      Get.put(DashboardController());

  final BumpOfferController bumpOfferController =
      Get.put(BumpOfferController());

  @override
  void initState() {
    print('**${widget.data.response.offerTag}');
    nameController.text = widget.data.response.offerName;
    priceController.text = widget.data.response.offerPrice;
    productController.selectedBumpOfferGroup.value =
        (widget.data.response.group != 'null')
            ? widget.data.response.group
            : productController.bumpOfferGroups.first['id'];
    dashboardController.selectedTagList.value =
        (widget.data.response.offerTag.toString() != 'null')
            ? widget.data.response.offerTag
            : dashboardController.tagList.first.tagId;

    bumpOfferController.buttonTextController.value.text =
        widget.data.response.templateCode.headerTitle ??
            "Don't miss this amazing offer!";
    bumpOfferController.titleTextController.value.text =
        widget.data.response.templateCode.footerText ??
            "One Time Offer! \$27.00";
    bumpOfferController.footerTextController.value.text = widget
            .data.response.templateCode.headerDescription ??
        "Our comprehensive Google Analytics Course is regularly priced at \$97.";

    bumpOfferController.borderColor.value = Color(int.parse(
        widget.data.response.templateCode.borderColor.replaceAll("#", "0xff")));
    bumpOfferController.buttonColor.value = Color(int.parse(
        widget.data.response.templateCode.buttonColor.replaceAll("#", "0xff")));

    bumpOfferController.backgroundColor.value = Color(int.parse(widget
        .data.response.templateCode.backgroundColor
        .replaceAll("#", "0xff")));
    bumpOfferController.buttonTextColor.value = Color(int.parse(widget
        .data.response.templateCode.headingtextColor
        .replaceAll("#", "0xff")));

    bumpOfferController.titleTextColor.value = Color(int.parse(widget
        .data.response.templateCode.middletextColor
        .replaceAll("#", "0xff")));
    bumpOfferController.footerTextColor.value = Color(int.parse(widget
        .data.response.templateCode.footertextColor
        .replaceAll("#", "0xff")));

    if (widget.data.response.templateCode.borderType == 'solid') {
      bumpOfferController.boxBorderWidth.value = 0.0;
    } else if (widget.data.response.templateCode.borderType == 'dotted') {
      bumpOfferController.boxBorderDash = [5, 5].obs;
      bumpOfferController.boxBorderWidth.value = 5.0;
    } else {
      bumpOfferController.boxBorderDash = [15, 5].obs;
      bumpOfferController.boxBorderWidth.value = 8.0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: formFieldKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 6.0),
              child: Text(
                "Bump offer name",
                style: GoogleFonts.roboto(
                  color: mTextboxTitleColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                ),
              ),
            ),
            SecondTextField(
              controller: nameController,
              hintText: "Offer name",
              enabled: true,
              obscureText: false,
              validator: (val) {
                return FieldValidator.validateValueIsEmpty(val);
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 6.0),
              child: Text(
                "Bump offer price",
                style: GoogleFonts.roboto(
                  color: mTextboxTitleColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: mWhiteColor,
                    border: Border.all(color: mborderColor),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: Icon(
                    Icons.attach_money,
                    color: dollarIconColor,
                    size: 18.0,
                  ),
                ),
                Expanded(
                  child: SecondTextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    hintText: "Enter Price",
                    enabled: true,
                    obscureText: false,
                    validator: (val) {
                      return FieldValidator.validateValueIsEmpty(val);
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 6.0),
              child: Text(
                "Assign Tag",
                style: GoogleFonts.roboto(
                  color: mTextboxTitleColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(2.0),
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
                      color: dollarIconColor,
                      size: 20.0,
                    ),
                  ),
                ),
                style: TextStyle(color: mBlackColor, fontSize: 16),
                iconSize: 32,
                items:
                    List.generate(dashboardController.tagList.length, (index) {
                  return DropdownMenuItem(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        dashboardController.tagList[index].tagName.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: mIconColor,
                        ),
                      ),
                    ),
                    value: dashboardController.tagList[index].tagId.toString(),
                  );
                }),
                onChanged: (value) {
                  dashboardController.selectedTagList.value = value;
                },
                isExpanded: false,
                value: dashboardController.selectedTagList.value.toString(),
                isDense: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 6.0),
              child: Text(
                "Select Bump Offer Group",
                style: GoogleFonts.roboto(
                  color: mTextboxTitleColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(2.0),
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
                      color: dollarIconColor,
                      size: 20.0,
                    ),
                  ),
                ),
                style: TextStyle(color: mBlackColor, fontSize: 16),
                iconSize: 32,
                items: List.generate(productController.bumpOfferGroups.length,
                    (index) {
                  return DropdownMenuItem(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        productController.bumpOfferGroups[index]["name"]
                            .toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: mIconColor,
                        ),
                      ),
                    ),
                    value: productController.bumpOfferGroups[index]["id"]
                        .toString(),
                  );
                }),
                onChanged: (value) {
                  productController.selectedBumpOfferGroup.value = value;
                },
                isExpanded: false,
                value:
                    productController.selectedBumpOfferGroup.value.toString(),
                isDense: true,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: CustomOfferBox(),
            ),
            GestureDetector(
              onTap: () {
                final form = formFieldKey.currentState;
                if (form.validate()) {
                  form.save();
                  updateBumpOfferService(
                    offerName: nameController.text,
                    price: priceController.text,
                    bumpId: widget.data.response.id,
                  ).then((value) {
                    if (value) {
                      nameController.clear();
                      priceController.clear();
                    }
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.only(bottom: 20.0, top: 10.0),
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: mborderColor),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 9.0, horizontal: 16.0),
                  child: Image.asset(
                    AppString.iconImagesPath + "ic_cloud_save.png",
                    color: optionIconColor,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
