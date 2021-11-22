import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/product/API/get_product_groups_details.dart';
import 'package:mint_bird_app/screens/product/API/update_product_detail.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/screens/product/models/group_data_model.dart';
import 'package:mint_bird_app/screens/product/models/user_product_details.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/utils/validator.dart';
import 'package:mint_bird_app/widgets/second_textfield.dart';

import '../../../utils/m_colors.dart';
import '../../../widgets/loaders.dart';

class ProductDetailTab extends StatefulWidget {
  final Product productDetail;

  const ProductDetailTab({Key key, this.productDetail}) : super(key: key);

  @override
  _ProductDetailTabState createState() => _ProductDetailTabState();
}

class _ProductDetailTabState extends State<ProductDetailTab> {
  ProductController productController = Get.put(ProductController());
  DashboardController dashboardController = Get.put(DashboardController());

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController originalPriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController productCheckoutPageUrlController =
      TextEditingController();

  final formFieldKey = GlobalKey<FormState>();

  File _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      getProductDataBloc.setProductImage(_image);
    } else {
      print('No image selected.');
    }
  }

  @override
  void initState() {
    nameController.text = widget.productDetail.productDetails.productName;
    priceController.text =
        widget.productDetail.productDetails.productPrice.toString();
    originalPriceController.text =
        widget.productDetail.originalPrice.toString();
    productController.originalPrice.value =
        widget.productDetail.originalPriceStatus == '1' ? true : false;
    descriptionController.text =
        widget.productDetail.productDetails.productDescription != 'null'
            ? widget.productDetail.productDetails.productDescription
            : "";
    productCheckoutPageUrlController.text =
        widget.productDetail.checkoutPageUrl;
    productController.applyCouponSwitch.value =
        widget.productDetail.productDetails.addCouponCode == 1 ? true : false;
    productController.disableShippingSwitch.value =
        widget.productDetail.shippingStatus == 1 ? true : false;
    productController.disableThumbnailSwitch.value =
        widget.productDetail.thumbnailStatus == 1 ? true : false;
    // productController.twoStepForm.value = widget.productDetail.twoStepForm == 1 ? true : false;
    productController.billingShippingFirstSwitch.value =
        widget.productDetail.activeShippingBilling == 1 ? true : false;
    productController.requireName.value =
        widget.productDetail.requireName == 1 ? true : false;
    productController.requirePhone.value =
        widget.productDetail.requirePhone == 1 ? true : false;
    getProductDataBloc
        .setProductDisplayImage(productController.disableThumbnailSwitch.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 36.0),
          child: SingleChildScrollView(
            child: Form(
              key: formFieldKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20.0, bottom: 6.0),
                    child: Text(
                      "Order Form Name",
                      style: GoogleFonts.roboto(
                        color: mTextboxTitleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  SecondTextField(
                    controller: nameController,
                    hintText: "Order Form name",
                    enabled: true,
                    obscureText: false,
                    validator: (val) {
                      return FieldValidator.validateValueIsEmpty(val);
                    },
                  ),

                  ///Comment from Client Side
                  /* Container(
                  margin: EdgeInsets.only(top: 15.0, bottom: 4.0),
                  child: Text(
                    "Add Coupon Code ?",
                    style: GoogleFonts.roboto(
                      color: mTextboxTitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 4.0,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "OFF",
                        style: GoogleFonts.roboto(
                            color: mTextboxHintColor, fontSize: 14.0),
                      ),
                      Obx(
                        () => Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                            activeColor: mBtnColor,
                            onChanged: (val) =>
                                productController.applyCouponSwitch.value = val,
                            value: productController.applyCouponSwitch.value,
                          ),
                        ),
                      ),
                      Text(
                        "ON",
                        style: GoogleFonts.roboto(
                            color: mTextboxHintColor, fontSize: 15.0),
                      ),
                    ],
                  ),
                ),*/
                  Container(
                    margin: EdgeInsets.only(top: 15.0, bottom: 6.0),
                    child: Text(
                      "Description",
                      style: GoogleFonts.roboto(
                        color: mTextboxTitleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  SecondTextField(
                    controller: descriptionController,
                    hintText: "Describe your Order Form here…",
                    enabled: true,
                    maxline: 4,
                    obscureText: false,
                    validator: (val) {
                      return FieldValidator.validateValueIsEmpty(val);
                    },
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 15.0, bottom: 6.0),
                    child: Text(
                      "Order Form Price",
                      style: GoogleFonts.roboto(
                        color: mTextboxTitleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
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
                      Expanded(
                        child: SecondTextField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
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

                  /*Container(
                  margin: EdgeInsets.only(top: 15.0, bottom: 6.0),
                  child: Text(
                    "Assign Tag",
                    style: GoogleFonts.roboto(
                      color: mTextboxTitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                 Container(
                  margin: EdgeInsets.only(bottom: 6.0),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: mWhiteColor,
                    border: Border.all(color: mborderColor),
                  ),
                  child: Obx(
                    () => DropdownButton<String>(
                      value:
                          dashboardController.selectedTagList.value.length == 0
                              ? null
                              : dashboardController.selectedTagList.value,
                      underline: SizedBox(),
                      hint: Text('  Select a tag'),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: TextStyle(color: Colors.blue),
                      items: List.generate(
                          dashboardController.tagList.length,
                          (index) => DropdownMenuItem<String>(
                                child: Text(
                                    dashboardController.tagList[index].tagName),
                                value: dashboardController.tagList[index].tagId,
                              )),
                      onChanged: (String val) {
                        setState(() {
                          dashboardController.selectedTagList.value = val;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15.0, bottom: 6.0),
                  child: Text(
                    "Checkout URL",
                    style: GoogleFonts.roboto(
                      color: mTextboxTitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                SecondTextField(
                  controller: productCheckoutPageUrlController,
                  hintText: "http://",
                  enabled: true,
                  obscureText: false,
                  validator: (val) {
                    return FieldValidator.validateValueIsEmpty(val);
                  },
                ),
                Obx(
                  () => (productController.addToFunnelSwitch.value)
                      ? Container(
                          margin: EdgeInsets.only(top: 15.0, bottom: 6.0),
                          child: Text(
                            "Add to Funnel",
                            style: GoogleFonts.roboto(
                              color: mTextboxTitleColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                            ),
                          ),
                        )
                      : Container(),
                ),
                Obx(
                  () => (productController.addToFunnelSwitch.value)
                      ? Container(
                          margin: EdgeInsets.only(bottom: 6.0),
                          decoration: BoxDecoration(
                            color: mWhiteColor,
                            border: Border.all(color: mborderColor),
                          ),
                          child: Obx(
                            () => DropdownButton(
                              underline: SizedBox(),
                              hint: productController.selectedFunnelValue ==
                                      ''.obs
                                  ? Text(' Select Funnel')
                                  : Text(
                                      "  " +
                                          productController.selectedFunnelValue
                                              .toString(),
                                      style: TextStyle(color: Colors.blue),
                                    ),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: TextStyle(color: Colors.blue),
                              items: funnelList.map(
                                (FunnelDataList val) {
                                  return DropdownMenuItem<String>(
                                    value: val.funnelName,
                                    child: Text(val.funnelName),
                                  );
                                },
                              ).toList(),
                              onChanged: (String val) {
                                setState(() {
                                  productController.selectedFunnelValue =
                                      val.obs;
                                });
                              },
                            ),
                          ),
                        )
                      : Container(),
                ),
                Obx(
                  () => (productController.addToFunnelSwitch.value &&
                          productController.selectedFunnelValue.value != '')
                      ? Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 9.0, bottom: 6.0),
                          child: CustomButton(
                            width: Get.width / 2,
                            height: 40.0,
                            text: "DisConnect".toUpperCase(),
                            onPressed: () {},
                            textColor: mWhiteColor,
                          ),
                        )
                      : Container(),
                ),*/

                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Original Price",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            color: mTextboxTitleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "OFF",
                              style: GoogleFonts.roboto(
                                color: mTextboxHintColor,
                                fontSize: 14.0,
                              ),
                            ),
                            Obx(
                              () => Transform.scale(
                                scale: 0.8,
                                child: CupertinoSwitch(
                                  onChanged: (val) {
                                    productController.originalPrice.value = val;
                                    getProductDataBloc
                                        .setProductDisplayImage(val);
                                    originalPriceController.text = val
                                        ? widget.productDetail.originalPrice ==
                                                '0'
                                            ? widget.productDetail.originalPrice
                                            : priceController.text
                                        : '0';
                                  },
                                  value: productController.originalPrice.value,
                                  activeColor: mBtnColor,
                                ),
                              ),
                            ),
                            Text(
                              "ON",
                              style: GoogleFonts.roboto(
                                color: mTextboxHintColor,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 15.0, bottom: 6.0),
                    child: Text(
                      "Original Price",
                      style: GoogleFonts.roboto(
                        color: mTextboxTitleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
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
                      Expanded(
                        child: Obx(
                          () => SecondTextField(
                            controller: originalPriceController,
                            keyboardType: TextInputType.number,
                            hintText: "",
                            enabled: productController.originalPrice.value,
                            obscureText: false,
                            validator: (val) {
                              return productController.originalPrice.value
                                  ? FieldValidator.validateOriginalPrice(
                                      val, priceController.text)
                                  : null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0, bottom: 6.0),
                    child: Text(
                      "Select Group",
                      style: GoogleFonts.roboto(
                        color: mTextboxTitleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 6.0),
                    decoration: BoxDecoration(
                      color: mWhiteColor,
                      border: Border.all(color: mborderColor),
                    ),
                    child: Obx(
                      () => DropdownButton(
                        underline: SizedBox(),
                        hint: productController.selectedGroupValue == ''.obs
                            ? Text(' Select a Group')
                            : Text(
                                "  " +
                                    productController.selectedGroupValue
                                        .toString(),
                                style: TextStyle(color: Colors.blue),
                              ),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: TextStyle(color: Colors.blue),
                        items: productGroups.map(
                          (Groups val) {
                            return DropdownMenuItem<String>(
                              value: val.name,
                              child: Text(val.name),
                            );
                          },
                        ).toList(),
                        onChanged: (String val) {
                          setState(() {
                            productController.selectedGroupValue = val.obs;
                          });
                        },
                      ),
                    ),
                  ),

                  /// Require Name & Require Phone Remove from Clint.
                  /*  Container(
                  margin: EdgeInsets.only(top: 20.0, bottom: 6.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => GestureDetector(
                            onTap: () => productController.requireName.value =
                                !productController.requireName.value,
                            child: Row(
                              children: [
                                checkBox(productController.requireName),
                                SizedBox(width: 10.0),
                                Text(
                                  "Require Name",
                                  style: GoogleFonts.roboto(
                                    color: mTextboxHintColor,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Obx(
                          () => GestureDetector(
                            onTap: () {
                              productController.requirePhone.value =
                                  productController.requirePhone.isFalse;
                            },
                            child: Row(
                              children: [
                                checkBox(productController.requirePhone),
                                SizedBox(width: 10.0),
                                Text(
                                  "Require Phone",
                                  style: GoogleFonts.roboto(
                                    color: mTextboxHintColor,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),*/
                  // Wrap(
                  //   alignment: WrapAlignment.spaceEvenly,
                  //   children: [
                  /// Two Step From and Shipping Info and Billing / Shipping First Remove from Clint.
                  /*  Padding(
                Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Two Step Form",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                              color: mTextboxTitleColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "OFF",
                                style: GoogleFonts.roboto(
                                  color: mTextboxHintColor,
                                  fontSize: 14.0,
                                ),
                              ),
                              Obx(
                                () => Transform.scale(
                                  scale: 0.8,
                                  child: CupertinoSwitch(
                                    onChanged: (val) {
                                      productController.twoStepForm.value = val;
                                    },
                                    value: productController.twoStepForm.value,
                                    activeColor: mBtnColor,
                                  ),
                                ),
                              ),
                              Text(
                                "ON",
                                style: GoogleFonts.roboto(
                                  color: mTextboxHintColor,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Shipping Info",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                              color: mTextboxTitleColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "OFF",
                                style: GoogleFonts.roboto(
                                  color: mTextboxHintColor,
                                  fontSize: 14.0,
                                ),
                              ),
                              Obx(
                                () => Transform.scale(
                                  scale: 0.8,
                                  child: CupertinoSwitch(
                                    onChanged: (val) {
                                      productController.disableShippingSwitch.value = val;
                                    },
                                    value: productController.disableShippingSwitch.value,
                                    activeColor: mBtnColor,
                                  ),
                                ),
                              ),
                              Text(
                                "ON",
                                style: GoogleFonts.roboto(
                                  color: mTextboxHintColor,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Billing / Shipping First",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                              color: mTextboxTitleColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "SHIPPING",
                                style: GoogleFonts.roboto(
                                  color: mTextboxHintColor,
                                  fontSize: 14.0,
                                ),
                              ),
                              Obx(
                                () => Transform.scale(
                                  scale: 0.8,
                                  child: CupertinoSwitch(
                                    onChanged: (val) {
                                      productController.billingShippingFirstSwitch.value = val;
                                    },
                                    value: productController.billingShippingFirstSwitch.value,
                                    activeColor: mBtnColor,
                                  ),
                                ),
                              ),
                              Text(
                                "BILLING",
                                style: GoogleFonts.roboto(
                                  color: mTextboxHintColor,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),*/

                  /// COMMENT BY CLIENT
                  /* Container(
                  margin: EdgeInsets.only(top: 15.0),
                  child: Text(
                    "Additional Options",
                    style: GoogleFonts.roboto(
                      color: darkTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Disable Thumbnail",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          color: mTextboxTitleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "IMAGE",
                            style: GoogleFonts.roboto(
                              color: mTextboxHintColor,
                              fontSize: 14.0,
                            ),
                          ),
                          Obx(
                            () => Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                onChanged: (val) {
                                  productController
                                      .disableThumbnailSwitch.value = val;
                                  getProductDataBloc
                                      .setProductDisplayImage(val);
                                },
                                value: productController
                                    .disableThumbnailSwitch.value,
                                activeColor: mBtnColor,
                              ),
                            ),
                          ),
                          Text(
                            "PAGE",
                            style: GoogleFonts.roboto(
                              color: mTextboxHintColor,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),*/
                  //   ],
                  // ),
                  /// COMMENT BY CLIENT
                  /*StreamBuilder(
                  initialData: productController.disableThumbnailSwitch.value,
                  stream: getProductDataBloc.productDisplayImageStream,
                  builder: (context, snapshot) {
                    return snapshot.hasData && !snapshot.data
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 4.0, top: 15.0, bottom: 6.0),
                                child: Text(
                                  "Order Form Image",
                                  style: GoogleFonts.roboto(
                                    color: mTextboxTitleColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => getImage(),
                                child: Center(
                                  child: Container(
                                    width: Get.width * 0.8,
                                    height: Get.height * 0.3,
                                    padding: EdgeInsets.all(10.0),
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    decoration: DottedDecoration(
                                      shape: Shape.box,
                                      color: mborderColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: StreamBuilder(
                                      stream:
                                          getProductDataBloc.productImageStream,
                                      builder: (context, snapshot) {
                                        return !snapshot.hasData &&
                                                widget
                                                        .productDetail
                                                        .productDetails
                                                        .productImage ==
                                                    null
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Image.asset(
                                                      AppString.iconImagesPath +
                                                          "ic_savecloud.png",
                                                      width: 25,
                                                      height: 25,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      top: 15.0,
                                                      bottom: 6.0,
                                                    ),
                                                    child: Text(
                                                      "Drag and drop files here",
                                                      style: GoogleFonts.roboto(
                                                        color:
                                                            mTextboxTitleColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      top: 5.0,
                                                    ),
                                                    child: Text(
                                                      "2MB - 500 px(JPG,PNG,GIF)",
                                                      style: GoogleFonts.roboto(
                                                        color:
                                                            mTextboxTitleColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : snapshot.hasData
                                                ? Image.file(
                                                    snapshot.data,
                                                    fit: BoxFit.fill,
                                                  )
                                                : Image.network(
                                                    APIUtils.productImageBaseUrl +
                                                        widget
                                                            .productDetail
                                                            .productDetails
                                                            .productImage,
                                                    fit: BoxFit.fill,
                                                  );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container();
                  },
                ),*/
                  GestureDetector(
                    onTap: () {
                      final form = formFieldKey.currentState;
                      if (form.validate()) {
                        productGroups.forEach((element) {
                          if (element.name ==
                              productController.selectedGroupValue.value)
                            productController.selectedGroupId.value =
                                element.id;
                        });
                        updateProductDetailService(
                          productId: widget.productDetail.id,
                          productName: nameController.text.isEmpty
                              ? ''
                              : nameController.text,
                          productDescription: descriptionController.text.isEmpty
                              ? ''
                              : descriptionController.text,
                          productPrice: priceController.text.isEmpty
                              ? ''
                              : priceController.text,
                          originalPrice: originalPriceController.text.isEmpty
                              ? ''
                              : originalPriceController.text,
                          productCheckoutPageUrl:
                              productCheckoutPageUrlController.text.isEmpty
                                  ? ''
                                  : productCheckoutPageUrlController.text,
                          image: _image,
                        );
                        form.save();
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
                        padding: EdgeInsets.symmetric(
                            vertical: 9.0, horizontal: 16.0),
                        child: Image.asset(
                          AppString.iconImagesPath + "ic_cloud_save.png",
                          color: optionIconColor,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
    );
  }

  Widget checkBox(RxBool boolVal) {
    return Container(
      height: 21.0,
      width: 21.0,
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: Colors.blue),
        borderRadius: BorderRadius.circular(3.0),
      ),
      child: Theme(
        data: ThemeData(unselectedWidgetColor: Colors.transparent),
        child: Checkbox(
          checkColor: Colors.blue,
          activeColor: mWhiteColor,
          value: boolVal.value,
          onChanged: (val) {
            boolVal.value = val;
          },
        ),
      ),
    );
  }
}
