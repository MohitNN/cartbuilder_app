import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/auth/login_screen.dart';
import 'package:mint_bird_app/screens/dashboard/API/delete_funnel.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/funnel/API/get_all_downsell.dart';
import 'package:mint_bird_app/screens/funnel/API/get_all_upsell.dart';
import 'package:mint_bird_app/screens/funnel/API/get_funnel.dart';
import 'package:mint_bird_app/screens/funnel/API/get_funnel_group.dart';
import 'package:mint_bird_app/screens/funnel/API/get_funnel_proudtcs.dart';
import 'package:mint_bird_app/screens/funnel/controller/funnel_controller.dart';
import 'package:mint_bird_app/screens/funnel/model/user_funnel_model.dart';
import 'package:mint_bird_app/screens/funnel/new_funnel_detail_page.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/utils/validator.dart';
import 'package:mint_bird_app/widgets/delete_popup.dart';
import 'package:mint_bird_app/widgets/loaders.dart';
import 'package:mint_bird_app/widgets/search_textfield.dart';
import 'package:mint_bird_app/widgets/shimmer_loading_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FunnelTab extends StatefulWidget {
  @override
  _FunnelTabState createState() => _FunnelTabState();
}

class _FunnelTabState extends State<FunnelTab> {
  TextEditingController searchController = TextEditingController();
  DashboardController dashboardController = Get.put(DashboardController());
  FunnelController funnelController = Get.put(FunnelController());
  ScrollController scrollController = ScrollController();

  List<FunnelDatum> funnelData;

  @override
  void initState() {
    scrollController
      ..addListener(() {
        var triggerFetchMoreSize =
            0.9 * scrollController.position.maxScrollExtent;
        if (scrollController.position.pixels > triggerFetchMoreSize &&
            !dashboardController.bottomLoader.value) {
          if (dashboardController.currentPage.value <=
              dashboardController.lastPage.value) {
            dashboardController.bottomLoader.value = true;
            getUserFunnelService();
          }
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: mPrimaryColor1,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(39),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, top: 44, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        dashboardController.scaffoldKey.value.currentState
                            .openDrawer();
                      },
                      icon: Icon(
                        Icons.dehaze,
                        color: optionIconColor,
                      ),
                    ),
                    PopupMenuButton<String>(
                      iconSize: 35,
                      icon: Icon(
                        Icons.more_horiz_rounded,
                        color: optionIconColor,
                      ),
                      onSelected: (value) async {
                        if (value == "Logout") {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.clear();
                          Get.offAll(() => LoginScreen());
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return {'Logout', 'Settings'}.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30.0, top: 10.0),
                child: Text(
                  "Funnel Library",
                  style: GoogleFonts.poppins(
                    fontSize: 21,
                    color: mBgColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 4.0, bottom: 47.0),
                child: SearchTextField(
                  controller: searchController,
                  hintText: "Search Funnels",
                  obscureText: false,
                  onSaved: (val) {
                    FocusScope.of(context).unfocus();
                    dashboardController.lastPage.value = 0;
                    dashboardController.currentPage.value = 1;
                    dashboardController.listOfFunnel.clear();
                    dashboardController.searchQuery.value = val;
                    getUserFunnelService();
                  },
                  onCancel: () {
                    if (searchController.text.isNotEmpty) {
                      searchController.clear();
                      dashboardController.lastPage.value = 0;
                      dashboardController.searchQuery.value = "";
                      dashboardController.listOfFunnel.clear();
                      dashboardController.currentPage.value = 1;
                      getUserFunnelService();
                    }
                  },
                  validator: (val) {
                    return FieldValidator.validateValueIsEmpty(val);
                  },
                ),
              )
            ],
          ),
        ),
        Obx(() {
          return Padding(
            padding: EdgeInsets.only(top: 240),
            child: dashboardController.isLoading.value &&
                    !dashboardController.bottomLoader.value
                ? funnelShimmer()
                : dashboardController.listOfFunnel.length == 0
                    ? Center(child: Text("No Funnel Found"))
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        controller: scrollController,
                        itemCount: dashboardController.listOfFunnel.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              funnelListItem(
                                  dashboardController.listOfFunnel[index]),
                              dashboardController.bottomLoader.value &&
                                      index + 1 ==
                                          dashboardController
                                              .listOfFunnel.length
                                  ? funnelShimmer()
                                  : SizedBox()
                            ],
                          );
                        }),
          );
        }),
        Obx(() {
          return authController.loading.value ? blurLoader : SizedBox();
        })
      ],
    );
  }

  Widget funnelListItem(FunnelDatum data) {
    FunnelController funnelController = Get.put(FunnelController());
    funnelController.funnelGroup.forEach((element) {
      if (data.id == element["id"]) {
        print(element["name"]);
      }
    });
    return Container(
      margin: EdgeInsets.only(left: 18.0, right: 11.0, bottom: 16.0),
      decoration: BoxDecoration(
        color: mWhiteColor,
        border: Border.all(color: mborderColor),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () async {
            await getAllUpsell();
            await getAllDownsell();
            dashboardController.selectedTagList.value =
                data.funnelDetails.funnelTag == null
                    ? ""
                    : data.funnelDetails.funnelTag;
            funnelController.upsellId.clear();
            funnelController.downsellId.clear();
            if (data.funnelsProduct != null) {
              funnelController.funnelProducts = data.funnelsProduct.obs;
              data.funnelsProduct.forEach((element) {
                funnelController.upsellId.add(element.upsell);
                if (element.downsell != null) {
                  element.downsell.forEach((element2) {
                    funnelController.downsellId.add(element2.downsell);
                  });
                }
              });
            } else {
              funnelController.funnelProducts.clear();
            }
            funnelController.funnelId.value = data.id;
            await getFunnelGroupService();

            funnelController.selectedGroup.value =
                data.funnelDetails.funnelGroupTag == null
                    ? ""
                    : data.funnelDetails.funnelGroupTag;
            getFunnelProducts();
            Get.to(() => NewFunnelDetailPage(data: data));
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 7.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        data.funnelDetails.funnelName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: mBlackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Container(
                      width: Get.width / 5.1,
                      decoration: BoxDecoration(
                        color: myellowColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
                          child: Text(
                            "\$ ${data.funnelPrice}",
                            style: TextStyle(
                              color: mDrawerUnameColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: mborderColor,
                thickness: 1.0,
                height: 1.0,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 15.0,
                  top: 6.0,
                  bottom: 6.0,
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    labelNumber("Views", data.views.toString()),
                    labelNumber("Orders", data.order.toString()),
                    labelNumber("Sales", "\$${data.totalSales}"),
                    labelNumber("Conv", "${data.conv.toString()}%"),
                    SizedBox(width: 10.0),
                    deletePopUp(
                        title: "Funnel",
                        onDelete: () {
                          deleteFunnel(data.id);
                        })
                  ],
                ),
              ),
              Divider(
                color: mborderColor,
                thickness: 1.0,
                height: 1.0,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
                  margin: EdgeInsets.symmetric(vertical: 7.0, horizontal: 18.0),
                  decoration: BoxDecoration(
                    color: mSellsFunnelColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    data.funnelGroupName,
                    style: GoogleFonts.roboto(
                      color: mWhiteColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget labelNumber(String label, String num) {
  return Expanded(
    child: Column(
      children: [
        Text(
          label,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.roboto(
            color: mFunnelLableColor,
            fontWeight: FontWeight.w400,
            fontSize: 10.0,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          num,
          style: GoogleFonts.mavenPro(
            color: mFunnelLableColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget funnelShimmer() {
  return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: 7,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          margin: EdgeInsets.only(left: 18.0, right: 11.0, bottom: 16.0),
          decoration: BoxDecoration(
            color: mWhiteColor,
            border: Border.all(color: mborderColor),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: shimmerLoadingCard(height: 15)),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(child: shimmerLoadingCard(height: 20)),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              shimmerLoadingCard(height: 3),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Spacer(),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        shimmerLoadingCard(height: 10),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: shimmerLoadingCard(height: 20),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        shimmerLoadingCard(height: 10),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: shimmerLoadingCard(height: 20),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        shimmerLoadingCard(height: 10),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: shimmerLoadingCard(height: 20),
                        ),
                      ],
                    ),
                  ),
                  Spacer()
                ],
              ),
              SizedBox(
                height: 10,
              ),
              shimmerLoadingCard(height: 3),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Spacer(
                      flex: 3,
                    ),
                    Expanded(child: shimmerLoadingCard(height: 15)),
                  ],
                ),
              )
            ],
          ),
        );
      });
}
