import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/reporting/API/get_dashboard_data.dart';
import 'package:mint_bird_app/screens/reporting/API/get_transaction_service.dart';
import 'package:mint_bird_app/screens/reporting/controller/reporting_controller.dart';
import 'package:mint_bird_app/screens/reporting/models/dashboard_model.dart';
import 'package:mint_bird_app/screens/reporting/tabs/transactions.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';

class ReportDashBoard extends StatefulWidget {
  @override
  _ReportDashBoardState createState() => _ReportDashBoardState();
}

class _ReportDashBoardState extends State<ReportDashBoard> {
  DashboardController dashboardController = Get.put(DashboardController());
  ReportingController reportingController = Get.put(ReportingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height / 20,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        dashboardController.drawerSelectedIndex.value = 99;
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                  Spacer(),
                  Text(
                    "Report",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: mPrimaryColor,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.16),
                          offset: Offset(2, 2),
                          blurRadius: 4,
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              FutureBuilder<DashBoardModel>(
                  future: getDashboardData(),
                  builder: (context, snap) {
                    if (snap.hasData) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              amountCard(
                                  imagePath: "revenue.png",
                                  title: "Gross Revenue",
                                  value:
                                      "\$${snap.data.dashBoardData?.grossRevenue}"),
                              SizedBox(
                                width: 16,
                              ),
                              amountCard(
                                  imagePath: "refund.png",
                                  title: "Gross Refund",
                                  value:
                                      "\$${snap.data.dashBoardData?.grossRefund ?? 0}")
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              amountCard(
                                  imagePath: "commission.png",
                                  title: "Commission",
                                  value:
                                      "\$${snap.data.dashBoardData?.commission ?? 0}"),
                              SizedBox(
                                width: 16,
                              ),
                              amountCard(
                                  imagePath: "netRevenue.png",
                                  title: "Net Revenue",
                                  value:
                                      "\$${snap.data.dashBoardData?.netRevenue ?? 0}")
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              amountCard(
                                  imagePath: "transaction.png",
                                  title: "Transactions",
                                  value:
                                      "\$${snap.data.dashBoardData?.totalTransactions ?? 0}",
                                  onTap: () {
                                    reportingController.recordList.clear();
                                    reportingController.currentPage.value = 1;
                                    reportingController.lastPage.value = 0;
                                    getTransactionServices();
                                    Get.to(Transactions());
                                    // reportingController.reportPageController.value
                                    //     .animateToPage(1,
                                    //         duration: Duration(milliseconds: 300),
                                    //         curve: Curves.ease);
                                  }),
                              SizedBox(
                                width: 16,
                              ),
                              amountCard(
                                  imagePath: "order.png",
                                  title: "Order value",
                                  value:
                                      "\$${snap.data.dashBoardData?.order ?? 0}")
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              amountCard(
                                  imagePath: "refunds.png",
                                  title: "Refunds",
                                  value:
                                      "\$${snap.data.dashBoardData?.refund ?? 0}"),
                              SizedBox(
                                width: 16,
                              ),
                              amountCard(
                                  imagePath: "refundRate.png",
                                  title: "Refund Rate",
                                  value:
                                      "${snap.data.dashBoardData?.refundRate ?? 0} %")
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })
              // Container(
              //     height: 500,
              //     child: WebView(
              //       initialUrl: "https://app.mintbird.com/user/products",
              //       onWebViewCreated: (controller) {},
              //
              //       // initialUrl: Uri.dataFromString(
              //       //         """<div id="SaasOnBoardContainer_2"></div>
              //       //             <script type="text/javascript" src="https://app.saasonboard.com/assets/custom/js/iframe/loginscreenlibrary.js"></script>
              //       // <script type="text/javascript">
              //       // LoginScreenLibrary.init([
              //       // "SaasOnBoardContainer_2",
              //       //     "https://app.saasonboard.com/",
              //       //     "vStJEAiZZKI29bz",
              //       //     "SaasOnBoardIFrame_2"
              //       //     ]);
              //       //   </script>""",
              //       //         mimeType: 'text/html')
              //       //     .toString(),
              //       javascriptMode: JavascriptMode.unrestricted,
              //     )),
            ],
          ),
        ),
      ),
    );
  }
}

Widget amountCard(
    {String title, String imagePath, VoidCallback onTap, String value}) {
  return Expanded(
      child: InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(3, 3),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            AppString.imagesAssetPath + imagePath,
            height: 50,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.blueGrey[300]),
          ),
        ],
      ),
    ),
  ));
}
