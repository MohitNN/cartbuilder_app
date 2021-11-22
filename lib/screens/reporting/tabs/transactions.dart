import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mint_bird_app/screens/reporting/API/delete_transaction_service.dart';
import 'package:mint_bird_app/screens/reporting/API/get_transaction_detail_service.dart';
import 'package:mint_bird_app/screens/reporting/API/get_transaction_service.dart';
import 'package:mint_bird_app/screens/reporting/controller/reporting_controller.dart';
import 'package:mint_bird_app/screens/reporting/models/transaction_model.dart';
import 'package:mint_bird_app/screens/reporting/tabs/transaction_details.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/widgets/shimmer_loading_card.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  ReportingController reportingController = Get.put(ReportingController());
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController
      ..addListener(() {
        var triggerFetchMoreSize =
            0.9 * scrollController.position.maxScrollExtent;
        if (scrollController.position.pixels > triggerFetchMoreSize &&
            !reportingController.bottomLoader.value) {
          if (reportingController.currentPage.value !=
              reportingController.lastPage.value) {
            reportingController.bottomLoader.value = true;
            getTransactionServices();
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
            SizedBox(
              height: Get.height / 20,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                      // reportingController.reportPageController.value
                      //     .animateToPage(
                      //   0,
                      //   duration: Duration(milliseconds: 300),
                      //   curve: Curves.ease,
                      // );
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                Spacer(),
                Text(
                  "Transactions",
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
                  return reportingController.loading.value &&
                          !reportingController.bottomLoader.value
                      ? transactionShimmer()
                      : reportingController.recordList.length > 0
                          ? ListView.builder(
                              controller: scrollController,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              itemCount: reportingController.recordList.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    transactionCard(
                                        reportingController.recordList[index]),
                                    reportingController.bottomLoader.value &&
                                            index + 1 ==
                                                reportingController
                                                    .recordList.length
                                        ? transactionShimmer(vPad: 0)
                                        : SizedBox()
                                  ],
                                );
                              })
                          : Center(
                              child: Text("No transaction found"),
                            );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget transactionShimmer({double vPad}) {
    return ListView.builder(
        itemCount: 6,
        shrinkWrap: true,
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

  Widget transactionCard(Record record) {
    return InkWell(
      onTap: () {
        getTransactionDetailServices(record.id);
        reportingController.tsStatus.value = record.status.toString();
        reportingController.transactionId.value = record.id;

        Get.to(TransactionDetails());
        // reportingController.reportPageController.value.animateToPage(2,
        //     duration: Duration(milliseconds: 300), curve: Curves.ease);
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
            ]),
        child: Row(
          children: [
            Container(
              width: 10,
              decoration: BoxDecoration(
                  color: Colors.green,
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
                        Icons.mail_outline_outlined,
                        size: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          record.userDetails.email,
                          style: TextStyle(fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.mobile_friendly,
                        size: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        record.userDetails.phone ?? "",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        DateFormat("dd MMM yyyy hh:mm a")
                            .format(record.updatedAt),
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.blue[100].withOpacity(0.5),
                  borderRadius: BorderRadius.circular(40)),
              child: Text(
                "\$${record.totalAmount}",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
            IconButton(
                onPressed: () {
                  Get.dialog(AlertDialog(
                    title: Text("Are you sure ?"),
                    content: Text(
                        "You want to permanently delete transaction details"),
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
                          deleteTransactionServices(record.id);
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
                ))
          ],
        ),
      ),
    );
  }
}
