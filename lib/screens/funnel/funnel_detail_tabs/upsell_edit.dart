import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:mint_bird_app/screens/funnel/controller/funnel_controller.dart';
import 'package:mint_bird_app/screens/upsell/controller/upsell_controller.dart';
import 'package:mint_bird_app/utils/m_colors.dart';

class UpsellEdit extends StatefulWidget {
  final String name;
  final String upsellId;
  final String type;

  const UpsellEdit({Key key, this.name, this.upsellId, this.type})
      : super(key: key);

  @override
  _UpsellEditState createState() => _UpsellEditState();
}

class _UpsellEditState extends State<UpsellEdit> {
  UpsellController upsellController = Get.put(UpsellController());
  FunnelController funnelController = Get.put(FunnelController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mBgColor,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: mbackColor,
              size: 20.0,
            )),
        title: Text(
          widget.name,
          style: GoogleFonts.roboto(
            color: mTextColor,
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0,
      ),
      body: Obx(() {
        return Container(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              InAppWebView(
                onProgressChanged: (controller, value) {
                  upsellController.upsellLoads.value = (value / 100).toDouble();
                },
                initialUrlRequest: URLRequest(
                    url: Uri.parse(
                        "https://app.mintbird.com/customize-iframe/${widget.type}/${widget.upsellId}/${funnelController.funnelId.value}")),
              ),
              upsellController.upsellLoads.value == 1.0
                  ? SizedBox()
                  : Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.16),
                                  offset: Offset(2, 2),
                                  blurRadius: 6)
                            ]),
                        child: LiquidCircularProgressIndicator(
                          center: Text(
                            "${((upsellController.upsellLoads.value) * 100)}",
                            style: TextStyle(
                                color:
                                    ((upsellController.upsellLoads.value) * 100)
                                                .ceil() >
                                            50
                                        ? Colors.white
                                        : mPrimaryColor1),
                          ),
                          value: upsellController.upsellLoads.value,
                          backgroundColor: Colors.white,
                          direction: Axis.vertical,
                          valueColor: AlwaysStoppedAnimation(mPrimaryColor),
                        ),
                      ),
                    ),
            ],
          ),
        );
      }),
    );
  }
}
