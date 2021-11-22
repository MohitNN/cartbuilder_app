import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mint_bird_app/screens/reporting/controller/reporting_controller.dart';
import 'package:mint_bird_app/screens/reporting/tabs/report_dashboard.dart';

class Reporting extends StatefulWidget {
  const Reporting({Key key}) : super(key: key);

  @override
  _ReportingState createState() => _ReportingState();
}

class _ReportingState extends State<Reporting> {
  ReportingController controller = Get.put(ReportingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      controller: controller.reportPageController.value,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ReportDashBoard(),
        // Transactions(),
        // TransactionDetails(),
      ],
    ));
  }
}
