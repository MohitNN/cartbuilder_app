import 'dart:io';
import 'dart:ui';

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/downsell/API/get_down_sell_groups_details.dart';
import 'package:mint_bird_app/screens/downsell/API/update_downsell_detail.dart';
import 'package:mint_bird_app/screens/downsell/models/downsell_details_model.dart';
import 'package:mint_bird_app/screens/product/models/group_data_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/utils/validator.dart';
import 'package:mint_bird_app/widgets/second_textfield.dart';

import '../../../widgets/loaders.dart';
import '../../product/models/group_data_model.dart';
import '../controller/downsell_controller.dart';

class DownSellDetailTab extends StatefulWidget {
  final Downsell downSell;
  const DownSellDetailTab({Key key, this.downSell}) : super(key: key);

  @override
  _DownSellDetailTabState createState() => _DownSellDetailTabState();
}

class _DownSellDetailTabState extends State<DownSellDetailTab> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DownSellController downSellController = Get.put(DownSellController());
  DashboardController dashboardController = Get.put(DashboardController());

  File _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      getDownSellDataBloc.setDownSellImage(_image);
    } else {
      print('No image selected.');
    }
  }

  @override
  void initState() {
    nameController.text = widget.downSell.downsellDetails.downsellName;
    priceController.text =
        widget.downSell.downsellDetails.downsellPrice.toString();
    descriptionController.text =
        widget.downSell.downsellDetails.downsellDescription;
    downSellController.displayThumbnailSwitch.value =
        widget.downSell.thumbnailStatus == '1' ? true : false;
    downSellGroups.forEach((element) {
      if (widget.downSell.downsellDetails.downsellGroupTag == element.id) {
        downSellController.selectedGroup.value = element.name;
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
                    "DownSell Name",
                    style: GoogleFonts.roboto(
                      color: mTextboxTitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                SecondTextField(
                  controller: nameController,
                  hintText: "DownSell name",
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
                  hintText: "Describe your DownSell here…",
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
                      hint: downSellController.selectedGroup == ''.obs
                          ? Text(' Select a Group')
                          : Text(
                              ' ' + downSellController.selectedGroup.toString(),
                              style: TextStyle(color: Colors.blue),
                            ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: TextStyle(color: Colors.blue),
                      items: downSellGroups.map(
                        (Groups val) {
                          return DropdownMenuItem<String>(
                            value: val.name,
                            child: Text(val.name),
                          );
                        },
                      ).toList(),
                      onChanged: (String val) {
                        setState(() {
                          downSellController.selectedGroup = val.obs;
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
                              downSellController.displayThumbnailSwitch.value =
                                  val;
                              getDownSellDataBloc.setDownSellDisplayImage(val);
                            },
                            value:
                                downSellController.displayThumbnailSwitch.value,
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
                  initialData: downSellController.displayThumbnailSwitch.value,
                  stream: getDownSellDataBloc.downSellDisplayImageStream,
                  builder: (context, snapshot) {
                    return snapshot.hasData && !snapshot.data
                        ? Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 4.0, top: 15.0, bottom: 6.0),
                                child: Text(
                                  "Downsell Image",
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
                                        stream: getDownSellDataBloc
                                            .downSellImageStream,
                                        builder: (context, snapshot) {
                                          return !snapshot.hasData &&
                                                  widget
                                                          .downSell
                                                          .downsellDetails
                                                          .downsellImage ==
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
                                                      APIUtils.downSellImageBaseUrl +
                                                          widget
                                                              .downSell
                                                              .downsellDetails
                                                              .downsellImage,
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
                    downSellGroups.forEach((element) {
                      if (element.name ==
                          downSellController.selectedGroup.value)
                        downSellController.selectedGroupId.value = element.id;
                    });
                    updateDownSellDetailService(
                      downSellId: widget.downSell.id,
                      downSellName: nameController.text.isNotEmpty
                          ? nameController.text
                          : '',
                      downSellDescription: descriptionController.text.isNotEmpty
                          ? descriptionController.text
                          : '',
                      downSellPrice: priceController.text.isNotEmpty
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
            return downSellController.isLoading.value
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
