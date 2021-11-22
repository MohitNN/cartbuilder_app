import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/dashboard/widgets/create_product.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';

class ProductCustomiseSuccessPage extends StatefulWidget {
  @override
  _ProductCustomiseSuccessPageState createState() =>
      _ProductCustomiseSuccessPageState();
}

class _ProductCustomiseSuccessPageState
    extends State<ProductCustomiseSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Edit Page",
                    style: GoogleFonts.poppins(
                      color: mCustomizeTabText,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_left,
                        color: mCustomizeTabBorder,
                        size: 30.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Icon(
                          Icons.subdirectory_arrow_right,
                          color: mCustomizeTabBorder,
                          size: 30.0,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: mCustomizeTabBorder),
                        ),
                        child: Image.asset(
                          AppString.iconImagesPath + "ic_eye_.png",
                          height: 24,
                          width: 24,
                          // color: mCustomizeTabBorder,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView(
                children: [
                  GetEditContainer(37.67, widget1()),
                  SizedBox(height: 11.33),
                  GetEditContainer(125.67, widget2()),
                  SizedBox(height: 11.33),
                  GetEditContainer(125.67, widget3()),
                  SizedBox(height: 11.33),
                  GetEditContainer(37.67, widget4()),
                  SizedBox(height: 11.33),
                  Container(
                    margin: EdgeInsets.only(top: 30.0),
                    height: 64,
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: Color(0xff00A3F5)),
                    child: Center(
                      child: Text(
                        "SAVE CHANGES",
                        style: getDefaultTextStyle(18.0, Colors.white,
                            fontweight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget widget1() {
    return Text(
      "Edit Header Text",
      style: getDefaultTextStyle(15, Color(0xff00A3F5),
          fontweight: FontWeight.bold),
    );
  }

  Widget widget2() {
    return Container(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(
            flex: 3,
          ),
          Container(
            child: Icon(
              Icons.local_gas_station,
              color: Color(0xff00A3F5),
              size: 50.0,
            ),
          ),
          SizedBox(
            height: 17.0,
          ),
          Text(
            "Edit Header ",
            style: getDefaultTextStyle(12, Color(0xff00A3F5),
                fontweight: FontWeight.w800),
          ),
          Spacer(
            flex: 3,
          )
        ],
      ),
    );
  }

  Widget widget3() {
    return Container(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(
            flex: 3,
          ),
          Container(
            height: 42,
            width: 65,
            child: Image.network(
              "https://webstockreview.net/images/video-clipart-cine-camera-7.png",
              fit: BoxFit.fill,
              color: Colors.blue,
            ),
          ),
          SizedBox(
            height: 17.0,
          ),
          Text(
            "Edit Video",
            style: getDefaultTextStyle(12, Color(0xff00A3F5),
                fontweight: FontWeight.w800),
          ),
          Spacer(
            flex: 3,
          )
        ],
      ),
    );
  }

  Widget widget4() {
    return Text(
      "Edit OTO",
      style: getDefaultTextStyle(11, Color(0xff00A3F5),
          fontweight: FontWeight.bold),
    );
  }

  Widget widget7() {
    return Text(
      "Edit Bullet Points",
      style: getDefaultTextStyle(11, Color(0xff00A3F5),
          fontweight: FontWeight.bold),
    );
  }

  Widget widget8() {
    return Text(
      "Edit Testimonals",
      style: getDefaultTextStyle(11, Color(0xff00A3F5),
          fontweight: FontWeight.bold),
    );
  }

  // ignore: non_constant_identifier_names
  Widget GetEditContainer(height, widget) {
    return Container(
      color: Color(0xffD8EDFC),
      child: DottedBorder(
        color: Color(0xff86cdff), //color of dotted/dash line
        strokeWidth: 1, //thickness of dash/dots
        dashPattern: [5, 5],
        child: Container(
          height: height,
          width: Get.width,
          decoration: BoxDecoration(color: Color(0xffD8EDFC)),
          child: Center(
            child: widget,
          ),
        ),
      ),
    );
  }
}
