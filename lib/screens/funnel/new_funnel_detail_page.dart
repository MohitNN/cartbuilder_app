import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/auth/API/get_user_connected_account.dart';
import 'package:mint_bird_app/screens/funnel/API/get_single_funnel_product.dart';
import 'package:mint_bird_app/screens/funnel/controller/funnel_controller.dart';
import 'package:mint_bird_app/screens/funnel/funnel_detail_tabs/funnel_detail_tab.dart';
import 'package:mint_bird_app/screens/funnel/funnel_detail_tabs/new_funnel_flow.dart';
import 'package:mint_bird_app/screens/funnel/model/user_funnel_model.dart';
import 'package:mint_bird_app/utils/m_colors.dart';

class NewFunnelDetailPage extends StatefulWidget {
  final FunnelDatum data;

  const NewFunnelDetailPage({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  _NewFunnelDetailPageState createState() => _NewFunnelDetailPageState();
}

class _NewFunnelDetailPageState extends State<NewFunnelDetailPage> {
  FunnelController funnelController = Get.put(FunnelController());
  TabController _tabController;

  List<SelectedPaymentOption> selectedPaymentOption = [];

  List<String> tabs = [
    'Funnel Details',
    'Funnel Flow',
  ];

  @override
  void initState() {
    getSingleFunnelProductService(widget.data.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
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
              widget.data.funnelDetails.funnelName,
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
              FunnelDetailTab(data: widget.data),
              NewFunnelFlow(),
            ],
          )),
    );
  }
}
