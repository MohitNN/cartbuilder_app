import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/product/API/create_bump_offer_service.dart';
import 'package:mint_bird_app/screens/product/API/get_product_bump_offer.dart';
import 'package:mint_bird_app/screens/product/API/get_product_bump_offer_group_list.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/screens/product/models/added_bump_offer_model.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/widgets/custom_buttons.dart';

import '../../../widgets/loaders.dart';
import 'widget_product_list_item.dart';

class ProductBumpOffer extends StatefulWidget {
  final String productId;

  const ProductBumpOffer({this.productId, Key key}) : super(key: key);

  @override
  _ProductBumpOfferState createState() => _ProductBumpOfferState();
}

class _ProductBumpOfferState extends State<ProductBumpOffer> {
  ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    getProductBumpOfferService(widget.productId);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: mPrimaryColor,
        child: Icon(Icons.add),
        onPressed: () => addBumpOffer(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Stack(
          children: [
            StreamBuilder<List<AddedBumpOffer>>(
                stream: getAddedBumpOfferListBloc.addedBumpOfferListStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data.length != 0) {
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return bumpOfferListItem(snapshot.data[index]);
                      },
                    );
                  } else if (snapshot.hasData && snapshot.data.length == 0) {
                    return Center(child: Text("No Bump Offer found"));
                  } else {
                    return appLoader;
                  }
                }),
            Obx(
              () {
                return productController.isLoading.value
                    ? BackdropFilter(
                        filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.white.withOpacity(0.5),
                          child: appLoader,
                        ),
                      )
                    : SizedBox();
              },
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: 57.0,
      //   alignment: Alignment.center,
      //   margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
      //   child: WidgetButton(
      //     width: Get.width / 1.3,
      //     height: 57.0,
      //     text: "ADD BUMP OFFER".toUpperCase(),
      //     onPressed: () => addBumpOffer(),
      //     textColor: mWhiteColor,
      //   ),
      // ),
    );
  }

  addBumpOffer() async {
    await getBumpOfferGroupListService();
    Get.dialog(
      Dialog(
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        insetPadding:
            EdgeInsets.only(left: 16.0, right: 16.0, top: 95.0, bottom: 20.0),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin:
                          EdgeInsets.only(left: 4.0, top: 20.0, bottom: 15.0),
                      child: Text(
                        "Add Bump Offer",
                        style: GoogleFonts.roboto(
                          color: mTextboxTitleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: 4.0, top: 15.0, bottom: 6.0),
                      child: Text(
                        "Choose Bump Offer Group",
                        style: GoogleFonts.roboto(
                          color: mTextboxTitleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: 4.0, top: 10.0, bottom: 6.0),
                      decoration: BoxDecoration(
                        color: mWhiteColor,
                        border: Border.all(color: mborderColor),
                      ),
                      child: Obx(
                        () => DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: mborderColor, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: mborderColor, width: 1.0),
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
                          items: List.generate(
                              productController.bumpOfferGroups.length,
                              (index) {
                            return DropdownMenuItem(
                              child: Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  productController.bumpOfferGroups[index]
                                          ["name"]
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: mIconColor,
                                  ),
                                ),
                              ),
                              value: productController.bumpOfferGroups[index]
                                      ["id"]
                                  .toString(),
                            );
                          }),
                          onChanged: (value) {
                            productController.selectedBumpOfferGroup.value =
                                value;
                            getBumpOfferService(
                                productController.selectedBumpOfferGroup.value);
                          },
                          isExpanded: false,
                          value: productController.bumpOfferGroups.first["id"]
                              .toString(),
                          isDense: true,
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: 4.0, top: 15.0, bottom: 6.0),
                      child: Text(
                        "Select Bump Offer",
                        style: GoogleFonts.roboto(
                          color: mTextboxTitleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: 4.0, top: 10.0, bottom: 6.0),
                      decoration: BoxDecoration(
                        color: mWhiteColor,
                        border: Border.all(color: mborderColor),
                      ),
                      child: Obx(
                        () => productController.isLoading.value
                            ? Container(height: 50, child: appLoader)
                            : DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: mborderColor, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: mborderColor, width: 1.0),
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
                                style:
                                    TextStyle(color: mBlackColor, fontSize: 16),
                                iconSize: 32,
                                items: List.generate(
                                    productController.bumpOffers.length,
                                    (index) {
                                  return DropdownMenuItem(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Text(
                                        productController.bumpOffers[index]
                                                ["name"]
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: mIconColor,
                                        ),
                                      ),
                                    ),
                                    value: productController.bumpOffers[index]
                                            ["id"]
                                        .toString(),
                                  );
                                }),
                                onChanged: (value) {
                                  productController.selectedBumpOffer.value =
                                      value;
                                },
                                isExpanded: false,
                                value: productController.bumpOffers.length == 0
                                    ? null
                                    : productController.bumpOffers.first["id"]
                                        .toString(),
                                isDense: true,
                              ),
                      ),
                    ),
                    Container(
                      height: 50.0,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: CustomButton(
                        width: Get.width / 1.3,
                        height: 57.0,
                        text: "ADD BUMP OFFER".toUpperCase(),
                        onPressed: () => createBumpOfferService(
                          productId: widget.productId,
                          bumpId: productController.selectedBumpOffer.value,
                          groupId:
                              productController.selectedBumpOfferGroup.value,
                        ),
                        textColor: mWhiteColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Obx(
              () {
                return productController.isDialogLoading.value
                    ? BackdropFilter(
                        filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                        child: Container(
                          height: 350,
                          alignment: Alignment.center,
                          color: Colors.white.withOpacity(0.5),
                          child: appLoader,
                        ),
                      )
                    : SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
