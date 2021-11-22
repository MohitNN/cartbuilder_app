import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/auth/login_screen.dart';
import 'package:mint_bird_app/screens/bump_offers/API/get_user_bump_offers.dart';
import 'package:mint_bird_app/screens/bump_offers/bump_offer_list.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/dime_sales/API/get_dime_sales.dart';
import 'package:mint_bird_app/screens/dime_sales/dime_sales_list.dart';
import 'package:mint_bird_app/screens/downsell/API/get_user_downsell.dart';
import 'package:mint_bird_app/screens/product/API/get_user_product.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/screens/product/models/user_product_model.dart';
import 'package:mint_bird_app/screens/product/product_detail_tabs/widget_product_list_item.dart';
import 'package:mint_bird_app/screens/time_sales/API/time_sale_list.dart';
import 'package:mint_bird_app/screens/time_sales/time_sales_list.dart';
import 'package:mint_bird_app/screens/upsell/API/get_user_upsell.dart';
import 'package:mint_bird_app/screens/upsell/models/user_upsell_model.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/utils/validator.dart';
import 'package:mint_bird_app/widgets/search_textfield.dart';
import 'package:mint_bird_app/widgets/shimmer_loading_card.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../downsell/models/user_downsell_model.dart';

class ProductTab extends StatefulWidget {
  @override
  _ProductTabState createState() => _ProductTabState();
}

class _ProductTabState extends State<ProductTab> {
  DashboardController dashboardController = Get.put(DashboardController());
  ProductController productController = Get.put(ProductController());
  TextEditingController searchController = TextEditingController();
  PaginationViewType paginationViewType;
  GlobalKey<PaginationViewState> key;
  List<ProductData> productList;
  List<UpSellDatum> upSellsList;
  List<DownSellDatum> downSellsList;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    paginationViewType = PaginationViewType.listView;
    key = GlobalKey<PaginationViewState>();
    scrollController
      ..addListener(() {
        var triggerFetchMoreSize =
            0.9 * scrollController.position.maxScrollExtent;
        if (scrollController.position.pixels > triggerFetchMoreSize &&
            !dashboardController.bottomLoader.value) {
          if (dashboardController.currentPage.value <=
              dashboardController.lastPage.value) {
            dashboardController.bottomLoader.value = true;
            if (productController.isProductTabSelected.value == 0) {
              getUserProductService();
            } else if (productController.isProductTabSelected.value == 1) {
              getUserUpSellService();
            } else if (productController.isProductTabSelected.value == 2) {
              getUserDownSellService();
            } else if (productController.isProductTabSelected.value == 3) {
              getUserBumpOffersService();
            } else if (productController.isProductTabSelected.value == 4) {
              getUserDimeSalesService();
            } else {
              getUserTimeSalesService();
            }
          }
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: mPrimaryColor,
          child: Padding(
            padding: EdgeInsets.only(left: 10, top: 32, right: 16),
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
        ),
        Container(
          decoration: BoxDecoration(
            color: mPrimaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.0),
            ),
          ),
          child: Column(
            children: [
              tabProductWidget(),
              searchTextWidget(),
            ],
          ),
        ),
        Obx(
          () {
            return Expanded(
                child: dashboardController.isLoading.value &&
                        !dashboardController.bottomLoader.value
                    ? productShimmer()
                    : productController.isProductTabSelected.value == 0
                        ? dashboardController.listOfProduct.length >= 0
                            ? dashboardController.listOfProduct.length == 0
                                ? Center(
                                    child: Text("No Order Form Found"),
                                  )
                                : ListView.builder(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    controller: scrollController,
                                    itemCount: dashboardController
                                        .listOfProduct.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          productListItem(
                                              dashboardController
                                                  .listOfProduct[index],
                                              index),
                                          dashboardController
                                                      .bottomLoader.value &&
                                                  index + 1 ==
                                                      dashboardController
                                                          .listOfProduct.length
                                              ? productShimmer(
                                                  verticalPadding: 0)
                                              : SizedBox()
                                        ],
                                      );
                                    })
                            : Center(
                                child: Text("No Order Form Found"),
                              )
                        : productController.isProductTabSelected.value == 1
                            ? dashboardController.listOfUpsell.length > 0
                                ? dashboardController.listOfUpsell.length == 0
                                    ? Center(
                                        child: Text("No Upsell Found"),
                                      )
                                    : ListView.builder(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        controller: scrollController,
                                        itemCount: dashboardController
                                            .listOfUpsell.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              upSellListItem(
                                                  dashboardController
                                                      .listOfUpsell[index],
                                                  index),
                                              dashboardController
                                                          .bottomLoader.value &&
                                                      index + 1 ==
                                                          dashboardController
                                                              .listOfUpsell
                                                              .length
                                                  ? productShimmer(
                                                      verticalPadding: 0)
                                                  : SizedBox()
                                            ],
                                          );
                                        })
                                : Center(
                                    child: Text("No Upsell Found"),
                                  )
                            : productController.isProductTabSelected.value == 2
                                ? dashboardController.listOfDownsell.length > 0
                                    ? dashboardController
                                                .listOfDownsell.length ==
                                            0
                                        ? Center(
                                            child: Text("No Downsell Found"),
                                          )
                                        : ListView.builder(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20),
                                            controller: scrollController,
                                            itemCount: dashboardController
                                                .listOfDownsell.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  downSellListItem(
                                                      dashboardController
                                                              .listOfDownsell[
                                                          index],
                                                      index),
                                                  dashboardController
                                                              .bottomLoader
                                                              .value &&
                                                          index + 1 ==
                                                              dashboardController
                                                                  .listOfDownsell
                                                                  .length
                                                      ? productShimmer(
                                                          verticalPadding: 0)
                                                      : SizedBox()
                                                ],
                                              );
                                            })
                                    : Center(
                                        child: Text("No Downsell Found"),
                                      )
                                : productController
                                            .isProductTabSelected.value ==
                                        3
                                    ? BumpOfferList(scrollController)
                                    : productController
                                                .isProductTabSelected.value ==
                                            4
                                        ? DimeSalesList(scrollController)
                                        : TimeSalesList(scrollController));
          },
        ),
      ],
    );
  }

  Widget tabProductWidget() {
    ProductController productController = Get.put(ProductController());
    return Obx(() {
      return Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  searchController.clear();
                  productController.isProductTabSelected.value = 0;
                  dashboardController.lastPage.value = 0;
                  dashboardController.currentPage.value = 1;
                  dashboardController.listOfProduct.clear();
                  dashboardController.searchQuery.value = "";
                  getUserProductService();
                },
                child: Text(
                  "Order Forms",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: productController.isProductTabSelected.value == 0
                        ? mWhiteColor
                        : unSelectedLabel,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  searchController.clear();
                  productController.isProductTabSelected.value = 1;
                  dashboardController.lastPage.value = 0;
                  dashboardController.currentPage.value = 1;
                  dashboardController.listOfUpsell.clear();
                  dashboardController.searchQuery.value = "";
                  getUserUpSellService();
                },
                child: Text(
                  "Upsells",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: productController.isProductTabSelected.value == 1
                        ? mWhiteColor
                        : unSelectedLabel,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  searchController.clear();
                  productController.isProductTabSelected.value = 2;
                  dashboardController.lastPage.value = 0;
                  dashboardController.currentPage.value = 1;
                  dashboardController.listOfDownsell.clear();
                  dashboardController.searchQuery.value = "";
                  getUserDownSellService();
                },
                child: Text(
                  "Downsells",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: productController.isProductTabSelected.value == 2
                        ? mWhiteColor
                        : unSelectedLabel,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  searchController.clear();
                  productController.isProductTabSelected.value = 3;
                  dashboardController.currentPage.value = 1;
                  dashboardController.lastPage.value = 0;
                  dashboardController.searchQuery.value = "";
                  dashboardController.listOfBumpOffers.clear();
                  getUserBumpOffersService();
                },
                child: Text(
                  "Bump Offer",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: productController.isProductTabSelected.value == 3
                        ? mWhiteColor
                        : unSelectedLabel,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  searchController.clear();
                  productController.isProductTabSelected.value = 4;
                  dashboardController.lastPage.value = 0;
                  dashboardController.currentPage.value = 1;
                  dashboardController.listOfDimeSale.clear();
                  dashboardController.searchQuery.value = "";
                  getUserDimeSalesService();
                },
                child: Text(
                  "Dime Sales",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: productController.isProductTabSelected.value == 4
                        ? mWhiteColor
                        : unSelectedLabel,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  searchController.clear();
                  productController.isProductTabSelected.value = 5;
                  dashboardController.lastPage.value = 0;
                  dashboardController.currentPage.value = 1;
                  dashboardController.listOfTimesell.clear();
                  dashboardController.searchQuery.value = "";
                  getUserTimeSalesService();
                },
                child: Text(
                  "Time Sales",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: productController.isProductTabSelected.value == 5
                        ? mWhiteColor
                        : unSelectedLabel,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget searchTextWidget() {
    return Obx(
      () {
        return Container(
          margin: EdgeInsets.only(bottom: 20.0),
          child: productController.isProductTabSelected.value == 0
              ? SearchTextField(
                  textInputAction: TextInputAction.search,
                  controller: searchController,
                  hintText: "Search Order Forms",
                  obscureText: false,
                  onCancel: () {
                    if (searchController.text.isNotEmpty) {
                      dashboardController.searchQuery.value = "";
                      searchController.clear();
                      dashboardController.currentPage.value = 1;
                      dashboardController.listOfProduct.clear();
                      getUserProductService();
                    }
                  },
                  onSaved: (value) {
                    if (value.isNotEmpty) {
                      dashboardController.searchQuery.value = value;
                      dashboardController.currentPage.value = 1;
                      dashboardController.listOfProduct.clear();
                      dashboardController.lastPage.value = 0;
                      getUserProductService();
                    }
                  },
                  validator: (val) {
                    return FieldValidator.validateValueIsEmpty(val);
                  },
                )
              : productController.isProductTabSelected.value == 1
                  ? SearchTextField(
                      controller: searchController,
                      hintText: "Search Upsells",
                      textInputAction: TextInputAction.search,
                      obscureText: false,
                      onCancel: () {
                        if (searchController.text.isNotEmpty) {
                          dashboardController.searchQuery.value = "";
                          searchController.clear();
                          dashboardController.lastPage.value = 0;
                          dashboardController.currentPage.value = 1;
                          dashboardController.listOfUpsell.clear();
                          getUserUpSellService();
                        }
                      },
                      validator: (val) {
                        return FieldValidator.validateValueIsEmpty(val);
                      },
                      onSaved: (val) {
                        if (val.isNotEmpty) {
                          dashboardController.searchQuery.value = val;
                          dashboardController.currentPage.value = 1;
                          dashboardController.lastPage.value = 0;
                          dashboardController.listOfUpsell.clear();
                          getUserUpSellService();
                        }
                      },
                    )
                  : productController.isProductTabSelected.value == 2
                      ? SearchTextField(
                          controller: searchController,
                          hintText: "Search Downsells",
                          obscureText: false,
                          textInputAction: TextInputAction.search,
                          onCancel: () {
                            if (searchController.text.isNotEmpty) {
                              dashboardController.searchQuery.value = "";
                              searchController.clear();
                              dashboardController.lastPage.value = 0;
                              dashboardController.currentPage.value = 1;
                              dashboardController.listOfDownsell.clear();
                              getUserDownSellService();
                            }
                          },
                          onSaved: (val) {
                            if (val.isNotEmpty) {
                              dashboardController.searchQuery.value = val;
                              dashboardController.currentPage.value = 1;
                              dashboardController.lastPage.value = 0;
                              dashboardController.listOfDownsell.clear();
                              getUserDownSellService();
                            }
                          },
                          validator: (val) {
                            return FieldValidator.validateValueIsEmpty(val);
                          },
                        )
                      : productController.isProductTabSelected.value == 3
                          ? SearchTextField(
                              controller: searchController,
                              hintText: "Search Bump Offers",
                              obscureText: false,
                              textInputAction: TextInputAction.search,
                              onCancel: () {
                                if (searchController.text.isNotEmpty) {
                                  dashboardController.searchQuery.value = "";
                                  searchController.clear();
                                  dashboardController.lastPage.value = 0;
                                  dashboardController.currentPage.value = 1;
                                  dashboardController.listOfBumpOffers.clear();
                                  getUserBumpOffersService();
                                }
                              },
                              onSaved: (val) {
                                if (val.isNotEmpty) {
                                  dashboardController.searchQuery.value = val;
                                  dashboardController.currentPage.value = 1;
                                  dashboardController.lastPage.value = 0;
                                  dashboardController.listOfBumpOffers.clear();
                                  getUserBumpOffersService();
                                }
                              },
                              validator: (val) {
                                return FieldValidator.validateValueIsEmpty(val);
                              },
                            )
                          : productController.isProductTabSelected.value == 4
                              ? SearchTextField(
                                  controller: searchController,
                                  hintText: "Search Dime Sales",
                                  obscureText: false,
                                  textInputAction: TextInputAction.search,
                                  onCancel: () {
                                    if (searchController.text.isNotEmpty) {
                                      dashboardController.searchQuery.value =
                                          "";
                                      searchController.clear();
                                      dashboardController.lastPage.value = 0;
                                      dashboardController.currentPage.value = 1;
                                      dashboardController.listOfDimeSale
                                          .clear();
                                      getUserDimeSalesService();
                                    }
                                  },
                                  onSaved: (val) {
                                    if (val.isNotEmpty) {
                                      dashboardController.searchQuery.value =
                                          val;
                                      dashboardController.currentPage.value = 1;
                                      dashboardController.lastPage.value = 0;
                                      dashboardController.listOfDimeSale
                                          .clear();
                                      getUserDimeSalesService();
                                    }
                                  },
                                  validator: (val) {
                                    return FieldValidator.validateValueIsEmpty(
                                        val);
                                  },
                                )
                              : SearchTextField(
                                  controller: searchController,
                                  hintText: "Search Time Sales",
                                  obscureText: false,
                                  textInputAction: TextInputAction.search,
                                  onCancel: () {
                                    if (searchController.text.isNotEmpty) {
                                      dashboardController.searchQuery.value =
                                          "";
                                      searchController.clear();
                                      dashboardController.lastPage.value = 0;
                                      dashboardController.currentPage.value = 1;
                                      dashboardController.listOfTimesell
                                          .clear();
                                      getUserTimeSalesService();
                                    }
                                  },
                                  onSaved: (val) {
                                    if (val.isNotEmpty) {
                                      dashboardController.searchQuery.value =
                                          val;
                                      dashboardController.currentPage.value = 1;
                                      dashboardController.lastPage.value = 0;
                                      dashboardController.listOfTimesell
                                          .clear();
                                      getUserTimeSalesService();
                                    }
                                  },
                                  validator: (val) {
                                    return FieldValidator.validateValueIsEmpty(
                                        val);
                                  },
                                ),
        );
      },
    );
  }
}

Widget productShimmer({double verticalPadding}) {
  return ListView.builder(
      shrinkWrap: true,
      padding:
          EdgeInsets.symmetric(vertical: verticalPadding ?? 20, horizontal: 10),
      itemCount: verticalPadding == 0 ? 3 : 7,
      itemBuilder: (context, index) {
        return Column(
          children: [
            SizedBox(
              height: 5,
            ),
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
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: shimmerLoadingCard(height: 15)),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(child: shimmerLoadingCard(height: 20)),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(child: shimmerLoadingCard(height: 20)),
                  Spacer(
                    flex: 2,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
          ],
        );
      });
}
