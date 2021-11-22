import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mint_bird_app/screens/downsell/API/get_downsell_details.dart';
import 'package:mint_bird_app/screens/downsell/downsell_detail_tabs/downsell_customise_tab.dart';
import 'package:mint_bird_app/screens/downsell/downsell_detail_tabs/downsell_detail_tab.dart';
import 'package:mint_bird_app/screens/downsell/models/downsell_details_model.dart';
import 'package:mint_bird_app/widgets/shimmer_loading_card.dart';

import '../../utils/m_colors.dart';
import '../upsell/upsell_detail_tabs/product_delivery.dart';
import '../upsell/upsell_detail_tabs/tracking_script.dart';
import 'controller/downsell_controller.dart';
import 'models/user_downsell_model.dart';

class DownSellDetail extends StatefulWidget {
  final DownSellDatum data;
  final String downSellId;
  final String downSellName;

  const DownSellDetail({Key key, this.data, this.downSellId, this.downSellName})
      : super(key: key);

  @override
  _DownSellDetailState createState() => _DownSellDetailState();
}

class _DownSellDetailState extends State<DownSellDetail> {
  TabController _tabController;
  bool status = false;
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

  List<String> tabs = [
    'Downsell Details',
    'Customise',
    'Product Delivery',
    'Tracking Scripts',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
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
            widget.data?.name ?? widget.downSellName,
            style: GoogleFonts.roboto(
              color: mTextColor,
              fontSize: 21,
              fontWeight: FontWeight.w700,
            ),
          ),
          elevation: 0,
          bottom: TabBar(
            indicatorPadding: EdgeInsets.symmetric(horizontal: 8.0),
            labelPadding: EdgeInsets.all(15.0),
            tabs: [
              for (int i = 0; i < tabs.length; i++)
                Text(
                  tabs[i],
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
            ],
            onTap: (value) {},
            controller: _tabController,
            isScrollable: true,
            indicatorColor: mBtnColor,
            labelColor: mBtnColor,
            labelStyle: TextStyle(color: mBtnColor),
            unselectedLabelColor: mTextColor,
          ),
        ),
        body: FutureBuilder<UserDownSellDetailsModel>(
          future:
              getDownSellDetailsService(widget.data?.id ?? widget.downSellId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  DownSellDetailTab(downSell: snapshot.data.downsell),
                  DownsellCustomiseTab(
                      selectedTemplate:
                          snapshot.data.downsell.checkoutDesign.templateId),
                  ProductDeliveryPage(
                    membershipPlatform: snapshot.data.downsell.typeOfDelivery,
                    id: snapshot.data.downsell.id,
                  ),
                  TrackingScriptsPage(snapshot.data.downsell.id),
                ],
              );
            } else
              return downSellDetailShimmer();
          },
        ),
      ),
    );
  }
}

Widget downSellDetailShimmer() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 36.0),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 6.0),
            child: shimmerLoadingCard(height: 15, width: 100),
          ),
          shimmerLoadingCard(height: 50),
          Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 6.0),
              child: shimmerLoadingCard(height: 15, width: 100)),
          Row(
            children: <Widget>[
              shimmerLoadingCard(height: 50, width: 50),
              SizedBox(
                width: 10,
              ),
              Expanded(child: shimmerLoadingCard(height: 50)),
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 6.0),
              child: shimmerLoadingCard(height: 15, width: 100)),
          shimmerLoadingCard(height: 100, radius: 10),
          Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 6.0),
              child: shimmerLoadingCard(height: 15, width: 100)),
          Container(
            margin: EdgeInsets.only(top: 15.0, bottom: 6.0),
            child: shimmerLoadingCard(height: 50),
          ),
          Container(
              margin: EdgeInsets.only(top: 20.0, bottom: 6.0),
              child: shimmerLoadingCard(height: 15, width: 100)),
          shimmerLoadingCard(height: 50),
        ],
      ),
    ),
  );
}
