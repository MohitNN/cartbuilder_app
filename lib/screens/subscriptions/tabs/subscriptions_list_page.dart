import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mint_bird_app/screens/subscriptions/API/get_subscriptions_detail_service.dart';
import 'package:mint_bird_app/screens/subscriptions/API/get_subscriptions_service.dart';
import 'package:mint_bird_app/screens/subscriptions/controller/subscriptions_controller.dart';
import 'package:mint_bird_app/screens/subscriptions/models/subscription_list_data_model.dart';
import 'package:mint_bird_app/screens/subscriptions/tabs/subscriptions_detail_page.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/widgets/loaders.dart';
import 'package:mint_bird_app/widgets/shimmer_loading_card.dart';

class SubscriptionsList extends StatefulWidget {
  @override
  _SubscriptionsListState createState() => _SubscriptionsListState();
}

class _SubscriptionsListState extends State<SubscriptionsList> {
  SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController
      ..addListener(() {
        var triggerFetchMoreSize =
            0.9 * scrollController.position.maxScrollExtent;
        if (scrollController.position.pixels > triggerFetchMoreSize &&
            !subscriptionController.bottomLoader.value) {
          if (subscriptionController.currentPage.value <=
              subscriptionController.lastPage.value) {
            subscriptionController.bottomLoader.value = true;
            getSubscriptionsServices();
          }
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: Get.height / 20),
            Row(
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.arrow_back_ios),
                ),
                Spacer(),
                Text(
                  "Subscriptions",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.16),
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      )
                    ],
                    color: mPrimaryColor,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Obx(
                () {
                  return subscriptionController.loading.value &&
                          !subscriptionController.bottomLoader.value
                      ? appLoader
                      : subscriptionController.subscriptionsDetailList.length >
                              0
                          ? ListView.builder(
                              controller: scrollController,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              itemCount: subscriptionController
                                  .subscriptionsDetailList.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    subscriptionsCard(subscriptionController
                                        .subscriptionsDetailList[index]),
                                    index + 1 ==
                                                subscriptionController
                                                    .subscriptionsDetailList
                                                    .length &&
                                            subscriptionController
                                                .bottomLoader.value
                                        ? subscriptionsShimmer(vPad: 0)
                                        : SizedBox()
                                  ],
                                );
                              })
                          : Center(child: Text("No Subscriptions found"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget subscriptionsShimmer({double vPad}) {
    return ListView.builder(
        itemCount: 6,
        shrinkWrap: true,
        physics: vPad == 0
            ? NeverScrollableScrollPhysics()
            : BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: vPad == null ? 16 : 0),
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(2, 2),
                    blurRadius: 10,
                  )
                ]),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      shimmerLoadingCard(height: 15),
                      shimmerLoadingCard(height: 15),
                      shimmerLoadingCard(height: 15),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                shimmerLoadingCard(height: 30, width: 50),
                SizedBox(
                  width: 10,
                ),
                shimmerLoadingCard(height: 40, width: 40),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          );
        });
  }

  Widget subscriptionsCard(SubscriptionDetail record) {
    return InkWell(
      onTap: () {
        getSubscriptionsDetailServices(record.id);
        Get.to(SubscriptionDetails());
      },
      child: Container(
        height: 100,
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(2, 2),
              blurRadius: 6,
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 10,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(6))),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person, size: 16),
                          SizedBox(width: 5),
                          Text(
                            record.userDetails.fullName ?? "",
                            style: TextStyle(fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.mobile_friendly, size: 16),
                      SizedBox(width: 5),
                      Text(
                        record.userDetails.phone != 'null'
                            ? record.userDetails.phone
                            : '',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16),
                      SizedBox(width: 5),
                      Text(
                        DateFormat("dd MMM yyyy hh:mm a")
                            .format(record.updatedAt),
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(Icons.mail_outline_outlined, size: 16),
                    SizedBox(width: 5),
                    Text(
                      record.userDetails.email ?? "",
                      style: TextStyle(fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.blue[100].withOpacity(0.5),
                          borderRadius: BorderRadius.circular(40)),
                      child: Text(
                        "\$${record.totalAmount ?? ''}",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.dialog(AlertDialog(
                          title: Text("Are you sure ?"),
                          content: Text(
                              "You want to permanently delete subscription details"),
                          actions: [
                            MaterialButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text("Cancel"),
                            ),
                            MaterialButton(
                              onPressed: () {
                                Get.back();
                                // deleteTransactionServices(record.id);
                              },
                              child: Text(
                                "Delete",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: mPrimaryColor,
                            ),
                          ],
                        ));
                      },
                      icon: Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.redAccent,
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
