import 'dart:io';
import 'dart:ui';

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/product/models/group_data_model.dart';
import 'package:mint_bird_app/screens/upsell/API/get_upsell_groups_details.dart';
import 'package:mint_bird_app/screens/upsell/API/update_upsell_detail.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/utils/validator.dart';
import 'package:mint_bird_app/widgets/second_textfield.dart';

import '../../../widgets/loaders.dart';
import '../controller/upsell_controller.dart';
import '../models/upsell_details_model.dart';

class UpsellDetailTab extends StatefulWidget {
  final Upsell upsell;

  const UpsellDetailTab({Key key, this.upsell}) : super(key: key);

  @override
  _UpsellDetailTabState createState() => _UpsellDetailTabState();
}

class _UpsellDetailTabState extends State<UpsellDetailTab> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  UpsellController upsellController = Get.put(UpsellController());
  DashboardController dashboardController = Get.put(DashboardController());

  File _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      getUpsellDataBloc.setUpsellImage(_image);
    } else {
      print('No image selected.');
    }
  }

  @override
  void initState() {
    dashboardController.selectedTagList.value =
        dashboardController.tagList.first.tagId;
    nameController.text = widget.upsell.upsellDetails.upsellName;
    priceController.text = widget.upsell.upsellDetails.upsellPrice.toString();
    descriptionController.text = widget.upsell.upsellDetails.upsellDescription;
    upsellController.displayThumbnailSwitch.value =
        widget.upsell.thumbnailStatus == 1 ? true : false;

    upsellGroups.forEach((element) {
      if (widget.upsell.upsellDetails.upsellGroupTag == element.id) {
        upsellController.selectedGroup.value = element.name;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 36.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20.0, bottom: 6.0),
                  child: Text(
                    "Upsell Name",
                    style: GoogleFonts.roboto(
                      color: mTextboxTitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                SecondTextField(
                  controller: nameController,
                  hintText: "Upsell name",
                  enabled: true,
                  obscureText: false,
                  validator: (val) {
                    return FieldValidator.validateValueIsEmpty(val);
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 15.0, bottom: 6.0),
                  child: Text(
                    "Price",
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
                  hintText: "Describe your Upsell here…",
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
                    "Select Group",
                    style: GoogleFonts.roboto(
                      color: mTextboxTitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15.0, bottom: 6.0),
                  decoration: BoxDecoration(
                    color: mWhiteColor,
                    border: Border.all(color: mborderColor),
                  ),
                  child: Obx(
                    () => DropdownButton(
                      underline: SizedBox(),
                      hint: upsellController.selectedGroup == ''.obs
                          ? Text(' Select a Group')
                          : Text(
                              ' ' + upsellController.selectedGroup.toString(),
                              style: TextStyle(color: Colors.blue),
                            ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: TextStyle(color: Colors.blue),
                      items: upsellGroups.map(
                        (Groups val) {
                          return DropdownMenuItem<String>(
                            value: val.name,
                            child: Text(val.name),
                          );
                        },
                      ).toList(),
                      onChanged: (String val) {
                        setState(() {
                          upsellController.selectedGroup = val.obs;
                        });
                      },
                    ),
                  ),
                ),
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
                    "Display Thumbnail",
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
                        "IMAGE",
                        style: GoogleFonts.roboto(
                            color: mTextboxHintColor, fontSize: 14.0),
                      ),
                      Obx(
                        () => Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                            onChanged: (val) {
                              upsellController.displayThumbnailSwitch.value =
                                  val;
                              getUpsellDataBloc.setUpsellDisplayImage(val);
                            },
                            value:
                                upsellController.displayThumbnailSwitch.value,
                            activeColor: mBtnColor,
                          ),
                        ),
                      ),
                      Text(
                        "PAGE",
                        style: GoogleFonts.roboto(
                            color: mTextboxHintColor, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
                StreamBuilder(
                  initialData: upsellController.displayThumbnailSwitch.value,
                  stream: getUpsellDataBloc.upsellDisplayImageStream,
                  builder: (context, snapshot) {
                    return snapshot.hasData && !snapshot.data
                        ? Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 4.0, top: 15.0, bottom: 6.0),
                                child: Text(
                                  "Upsell Image",
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
                                            getUpsellDataBloc.upsellImageStream,
                                        builder: (context, snapshot) {
                                          return !snapshot.hasData &&
                                                  widget.upsell.upsellDetails
                                                          .upsellImage ==
                                                      null
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
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
                                                      margin: EdgeInsets.only(
                                                          top: 15.0,
                                                          bottom: 6.0),
                                                      child: Text(
                                                        "Drag and drop files here",
                                                        style:
                                                            GoogleFonts.roboto(
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
                                                        style:
                                                            GoogleFonts.roboto(
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
                                                      APIUtils.upSellImageBaseUrl +
                                                          widget
                                                              .upsell
                                                              .upsellDetails
                                                              .upsellImage,
                                                      fit: BoxFit.fill,
                                                    );
                                        }),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container();
                  },
                ),
                GestureDetector(
                  onTap: () {
                    upsellGroups.forEach((element) {
                      if (element.name == upsellController.selectedGroup.value)
                        upsellController.selectedGroupId.value = element.id;
                    });
                    updateUpSellDetailService(
                      upSellId: widget.upsell.id,
                      upSellName: nameController.text.isNotEmpty
                          ? nameController.text
                          : '',
                      upSellDescription: descriptionController.text.isNotEmpty
                          ? descriptionController.text
                          : '',
                      upSellPrice: priceController.text.isNotEmpty
                          ? priceController.text
                          : '',
                      image: _image,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: 20.0, top: 10.0),
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: mborderColor),
                      ),
                      padding: EdgeInsets.only(
                          top: 15.0, bottom: 15.0, left: 30.0, right: 30.0),
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
            return upsellController.isLoading.value
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
}
