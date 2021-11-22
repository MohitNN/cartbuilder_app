import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mint_bird_app/screens/subscriptions/controller/subscriptions_controller.dart';
import 'package:mint_bird_app/screens/subscriptions/models/subscription_detail_model.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/widgets/shimmer_loading_card.dart';

class SubscriptionDetails extends StatefulWidget {
  @override
  _SubscriptionDetailsState createState() => _SubscriptionDetailsState();
}

class _SubscriptionDetailsState extends State<SubscriptionDetails> {
  SubscriptionController subscriptionController =
      Get.put(SubscriptionController());

  List<String> status = [
    "Cancel",
    "Success",
    "Processing",
    "Failed",
    "Refunded"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: Get.height / 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                      // getSubscriptionsServices();
                      // reportingController.reportPageController.value
                      //     .animateToPage(1,
                      //     duration: Duration(milliseconds: 300),
                      //     curve: Curves.ease);
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                Spacer(),
                Text(
                  "Subscription Detail",
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
                      color: mPrimaryColor),
                ),
              ],
            ),
          ),
          Expanded(child: Obx(() {
            return subscriptionController.loading.value
                ? detailLoading()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 16, left: 16, right: 16),
                          height: 200,
                          padding: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 6,
                                    offset: Offset(4, 4))
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: mPrimaryColor,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(6))),
                                child: Text(
                                  "General",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Date Created",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Obx(() {
                                        return Text(DateFormat("dd/MM/yyyy")
                                            .format(subscriptionController
                                                .subscriptionsDetails
                                                .value
                                                .data
                                                .transaction
                                                .createdAt));
                                      }),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Status",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: mPrimaryColor),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: DropdownButton<String>(
                                            value: subscriptionController
                                                .tsStatus.value,
                                            onChanged: (value) {
                                              subscriptionController
                                                  .tsStatus.value = value;
                                              // updateStatusService();
                                            },
                                            underline: SizedBox(),
                                            isExpanded: true,
                                            items: List.generate(
                                                status.length,
                                                (index) => DropdownMenuItem(
                                                      child:
                                                          Text(status[index]),
                                                      value: status[index],
                                                    ))),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, left: 16, right: 16),
                          height: 200,
                          padding: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 6,
                                    offset: Offset(4, 4))
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: mPrimaryColor,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(6))),
                                child: Text(
                                  "Billing",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.location_on_outlined),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Address",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.mail_outline_outlined),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Email",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.call),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Phone",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, left: 16, right: 16),
                          height: 200,
                          padding: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 6,
                                    offset: Offset(4, 4))
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: mPrimaryColor,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(6))),
                                child: Text(
                                  "Shipping",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.location_on_outlined),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Address",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          color: mPrimaryColor,
                          height: 50,
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            "Product",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ),
                        Obx(() {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 16),
                              itemCount: subscriptionController
                                  .subscriptionsDetails
                                  .value
                                  .data
                                  .products
                                  .length,
                              itemBuilder: (context, index) {
                                return subscriptionsCard(subscriptionController
                                    .subscriptionsDetails
                                    .value
                                    .data
                                    .products[index]);
                              });
                        })
                      ],
                    ),
                  );
          }))
        ],
      ),
    );
  }
}

Widget subscriptionsCard(Product data) {
  return InkWell(
    onTap: () {
      // reportingController.reportPageController.value.animateToPage(2,
      //     duration: Duration(milliseconds: 300), curve: Curves.ease);
    },
    child: Container(
      height: 100,
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(2, 2),
              blurRadius: 6,
            )
          ]),
      child: Row(
        children: [
          Container(
            width: 10,
            decoration: BoxDecoration(
                color: mPrimaryColor,
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(6))),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.inbox,
                      size: 16,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      data.productDetails.productName,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.equalizer_rounded,
                      size: 16,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      data.orders.toString(),
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.blue[100].withOpacity(0.5),
                borderRadius: BorderRadius.circular(40)),
            child: Text(
              "\$${data.productDetails.productPrice}",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget detailLoading() {
  return SingleChildScrollView(
    child: Column(
      children: [
        SizedBox(
          height: 10,
        ),
        shimmerLoadingCard(height: 200, radius: 10),
        SizedBox(
          height: 20,
        ),
        shimmerLoadingCard(height: 200, radius: 10),
        SizedBox(
          height: 20,
        ),
        shimmerLoadingCard(height: 200, radius: 10),
        SizedBox(
          height: 20,
        ),
        shimmerLoadingCard(height: 200, radius: 10),
      ],
    ),
  );
}
