import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mint_bird_app/screens/upsell/models/user_upsell_model.dart';
import 'package:mint_bird_app/screens/upsell/upsell_detail_tabs/product_delivery.dart';
import 'package:mint_bird_app/screens/upsell/upsell_detail_tabs/tracking_script.dart';
import 'package:mint_bird_app/screens/upsell/upsell_detail_tabs/upsell_detail_tab.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/widgets/shimmer_loading_card.dart';

import 'API/get_upsell_details.dart';
import 'controller/upsell_controller.dart';
import 'models/upsell_details_model.dart';
import 'upsell_detail_tabs/upsell_customise_tab.dart';

class UpSellDetail extends StatefulWidget {
  final UpSellDatum data;
  final String upsellId;
  final String upsellName;

  const UpSellDetail({Key key, this.data, this.upsellId, this.upsellName})
      : super(key: key);

  @override
  _UpSellDetailState createState() => _UpSellDetailState();
}

class _UpSellDetailState extends State<UpSellDetail> {
  TabController _tabController;
  bool status = false;
  File _image;
  UpsellController upsellController = Get.put(UpsellController());

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

  List<String> tabs = [
    'Upsell Details',
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
            ),
          ),
          title: Text(
            widget.data?.name ?? widget.upsellName,
            style: GoogleFonts.roboto(
              color: mTextColor,
              fontSize: 21,
              fontWeight: FontWeight.w700,
            ),
          ),
          elevation: 0,
          bottom: TabBar(
            indicatorPadding: EdgeInsets.symmetric(horizontal: 8.0),
            labelPadding: const EdgeInsets.all(15.0),
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
            onTap: (index) {},
            controller: _tabController,
            isScrollable: true,
            indicatorColor: mBtnColor,
            labelColor: mBtnColor,
            labelStyle: TextStyle(color: mBtnColor),
            unselectedLabelColor: mTextColor,
          ),
        ),
        body: FutureBuilder<UserUpsellDetailsModel>(
          future: getUpsellDetailsService(widget.data?.id ?? widget.upsellId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  UpsellDetailTab(upsell: snapshot.data.upsell),
                  UpsellCustomiseTab(
                    selectedTemplate:
                        snapshot.data.upsell.checkoutDesign.templateId,
                  ),
                  ProductDeliveryPage(
                    membershipPlatform: snapshot.data.upsell.typeOfDelivery,
                    id: snapshot.data.upsell.id,
                  ),
                  TrackingScriptsPage(snapshot.data.upsell.id),
                ],
              );
            } else
              return upsellDetailShimmer();
          },
        ),
      ),
    );
  }
}

Widget upsellDetailShimmer() {
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
