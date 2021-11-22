import 'dart:io';

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/funnel/API/update_funnel_service.dart';
import 'package:mint_bird_app/screens/funnel/controller/funnel_controller.dart';
import 'package:mint_bird_app/screens/funnel/model/user_funnel_model.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/utils/validator.dart';
import 'package:mint_bird_app/widgets/loaders.dart';
import 'package:mint_bird_app/widgets/second_textfield.dart';

import '../../../utils/m_colors.dart';

class FunnelDetailTab extends StatefulWidget {
  final FunnelDatum data;

  const FunnelDetailTab({Key key, this.data}) : super(key: key);

  @override
  _FunnelDetailTabState createState() => _FunnelDetailTabState();
}

class _FunnelDetailTabState extends State<FunnelDetailTab> {
  TextEditingController nameController = TextEditingController();
  TextEditingController checkoutController = TextEditingController();
  FunnelController funnelController = Get.put(FunnelController());
  DashboardController dashboardController = Get.put(DashboardController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    nameController.text = widget.data.funnelDetails.funnelName;
    checkoutController.text = widget.data.checkoutPageUrl;
    funnelController.thumbnailSwitch.value =
        widget.data.funnelImage == null ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return funnelController.isLoading.value
          ? blurLoader
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 36.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20.0, bottom: 6.0),
                        child: Text(
                          "Funnel Name",
                          style: GoogleFonts.roboto(
                            color: mTextboxTitleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      SecondTextField(
                        controller: nameController,
                        hintText: "Funnel name",
                        enabled: true,
                        obscureText: false,
                        validator: (val) {
                          return FieldValidator.validateValueIsEmpty(val);
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.0, bottom: 6.0),
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
                        controller: checkoutController,
                        hintText: "Checkout URL",
                        enabled: true,
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
                          "Select Group",
                          style: GoogleFonts.roboto(
                            color: mTextboxTitleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      Obx(() {
                        return funnelController.funnelGroup.length > 0
                            ? Container(
                                padding: EdgeInsets.all(2.0),
                                margin: EdgeInsets.only(top: 10.0),
                                width: Get.width,
                                child: DropdownButtonFormField<String>(
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
                                        color: dollarIconColor,
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
                                  style: TextStyle(
                                      color: mBlackColor, fontSize: 16),
                                  iconSize: 32,
                                  hint: Text(
                                    funnelController.selectedGroup.value
                                        .toString(),
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  items: List.generate(
                                      funnelController.funnelGroup.length,
                                      (index) {
                                    return DropdownMenuItem(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 8),
                                        child: Text(
                                          funnelController.funnelGroup[index]
                                                  ["name"]
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: mIconColor,
                                          ),
                                        ),
                                      ),
                                      value: funnelController.funnelGroup[index]
                                              ["id"]
                                          .toString(),
                                    );
                                  }),
                                  onChanged: (value) {
                                    funnelController.selectedGroup.value =
                                        value;
                                  },
                                  isExpanded: false,
                                  value: funnelController.selectedGroup.value,
                                  isDense: true,
                                ),
                              )
                            : SizedBox();
                      }),
                      Container(
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
                            value: dashboardController
                                        .selectedTagList.value.length ==
                                    0
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
                                      child: Text(dashboardController
                                          .tagList[index].tagName),
                                      value: dashboardController
                                          .tagList[index].tagId,
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
                        margin: EdgeInsets.only(
                          top: 15.0,
                          bottom: 6.0,
                        ),
                        child: Text(
                          "Disable Thumbnail",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            color: mTextboxTitleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Image",
                            style: GoogleFonts.roboto(
                                color: mTextboxHintColor, fontSize: 14.0),
                          ),
                          Obx(
                            () => Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                onChanged: (val) {
                                  funnelController.thumbnailSwitch.value = val;
                                  getProductDataBloc.setProductDisplayImage(
                                      funnelController.thumbnailSwitch.value);
                                },
                                value: funnelController.thumbnailSwitch.value,
                                activeColor: mBtnColor,
                              ),
                            ),
                          ),
                          Text(
                            "Page",
                            style: GoogleFonts.roboto(
                                color: mTextboxHintColor, fontSize: 14.0),
                          ),
                        ],
                      ),
                      StreamBuilder(
                        initialData: funnelController.thumbnailSwitch.value,
                        stream: getProductDataBloc.productDisplayImageStream,
                        builder: (context, snapshot) {
                          return snapshot.hasData && !snapshot.data
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 15.0, bottom: 6.0),
                                      child: Text(
                                        "Funnel Image",
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: StreamBuilder(
                                            stream: getProductDataBloc
                                                .productImageStream,
                                            builder: (context, snapshot) {
                                              return !snapshot.hasData &&
                                                      widget.data.funnelImage ==
                                                          null
                                                  ? Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Image.asset(
                                                            AppString
                                                                    .iconImagesPath +
                                                                "ic_savecloud.png",
                                                            width: 25,
                                                            height: 25,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: 15.0,
                                                            bottom: 6.0,
                                                          ),
                                                          child: Text(
                                                            "Upload thumbnail here",
                                                            style: GoogleFonts
                                                                .roboto(
                                                              color:
                                                                  mTextboxTitleColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 15.0,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: 5.0,
                                                          ),
                                                          child: Text(
                                                            "2MB - 500 px(JPG,PNG,GIF)",
                                                            style: GoogleFonts
                                                                .roboto(
                                                              color:
                                                                  mTextboxTitleColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
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
                                                          APIUtils.funnelImageBaseUrl +
                                                              widget.data
                                                                  .funnelImage,
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
                      ),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            updateFunnelService(
                              name: nameController.text,
                              checkoutUrl: checkoutController.text,
                              image: _image,
                            );
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
            );
    });
  }
}
