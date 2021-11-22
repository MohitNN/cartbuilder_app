import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/subscriptions/tabs/subscriptions_list_page.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/widgets/loaders.dart';

import 'API/get_subscriptions_service.dart';
import 'API/get_user_group_list.dart';
import 'controller/subscriptions_controller.dart';

class Subscriptions extends StatefulWidget {
  const Subscriptions({Key key}) : super(key: key);

  @override
  _SubscriptionsState createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
  DashboardController dashboardController = Get.put(DashboardController());
  SubscriptionController subscriptionController =
      Get.put(SubscriptionController());

  @override
  void initState() {
    getSubscriptionData();
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
                  onPressed: () {
                    dashboardController.drawerSelectedIndex.value = 99;
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                Spacer(),
                Text(
                  "Subscriptions",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    color: mPrimaryColor,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.16),
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height / 20),
            Expanded(
              child: Obx(
                () => Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 16),
                        subscriptionCard(
                          onTap: () {
                            subscriptionController.subscriptionsDetailList
                                .clear();
                            subscriptionController.currentPage.value = 1;
                            subscriptionController.lastPage.value = 99;
                            getSubscriptionsServices();
                            Get.to(() => SubscriptionsList());
                          },
                          imagePath: "ic_subscription.png",
                          title: "Subscriptions",
                          value:
                              "\$${subscriptionController.subscription.value ?? 0}",
                        ),
                        SizedBox(width: 16),
                        subscriptionCard(
                          onTap: () {},
                          imagePath: "ic_mrr.png",
                          title: "MRR",
                          value: "\$${subscriptionController.mrr.value ?? 0}",
                        ),
                        SizedBox(width: 16),
                        subscriptionCard(
                          onTap: () {},
                          imagePath: "ic_yearlyrevenue.png",
                          title: "Yearly Revenue",
                          value: "\$${subscriptionController.mrr.value ?? 0}",
                        ),
                      ],
                    ),
                    if (subscriptionController.loading.value)
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.white.withOpacity(0.5),
                          child: appLoader,
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget subscriptionCard({
    String title,
    String imagePath,
    String value,
    Function onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(3, 3),
              blurRadius: 10,
            )
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              AppString.iconImagesPath + imagePath,
              width: 50,
            ),
            SizedBox(width: Get.width * 0.05),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey[300],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
