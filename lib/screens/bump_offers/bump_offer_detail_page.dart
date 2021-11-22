import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/bump_offers/bump_offer_detail_tabs/custom_detail_tab.dart';
import 'package:mint_bird_app/screens/bump_offers/models/bump_offer_detail_model.dart';
import 'package:mint_bird_app/screens/upsell/upsell_detail_tabs/product_delivery.dart';
import 'package:mint_bird_app/utils/m_colors.dart';

class BumpOfferDetailPage extends StatefulWidget {
  final BumpOfferDetailDataModel data;

  const BumpOfferDetailPage({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  _BumpOfferDetailPageState createState() => _BumpOfferDetailPageState();
}

class _BumpOfferDetailPageState extends State<BumpOfferDetailPage> {
  TabController _tabController;

  List<String> tabs = [
    'Customize',
    'Product Delivery',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
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
            widget.data.response.offerName,
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
            controller: _tabController,
            indicatorColor: mBtnColor,
            labelColor: mBtnColor,
            labelStyle: TextStyle(color: mBtnColor),
            unselectedLabelColor: mTextColor,
            onTap: (value) {},
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            BumpOfferDetailTab(widget.data),
            ProductDeliveryPage(
              membershipPlatform: '',
              id: '',
            ),
          ],
        ),
      ),
    );
  }
}
