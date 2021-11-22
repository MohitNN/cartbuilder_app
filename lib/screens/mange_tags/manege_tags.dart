import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/mange_tags/API/get_user_group_list.dart';
import 'package:mint_bird_app/screens/mange_tags/tabs/tags_page.dart';
import 'package:mint_bird_app/utils/m_colors.dart';

class ManageTags extends StatefulWidget {
  const ManageTags({Key key}) : super(key: key);

  @override
  _ManageTagsState createState() => _ManageTagsState();
}

class _ManageTagsState extends State<ManageTags> {
  TabController _tabController;

  List<String> tabs = [
    'Tags',
    // 'Tag Groups',
  ];

  @override
  void initState() {
    getUserGroupList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
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
            '',
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
            UserTagsListPage(),
            // Container(),
          ],
        ),
      ),
    );
  }
}
