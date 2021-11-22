import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mint_bird_app/screens/reporting/models/transaction_detail_model.dart';
import 'package:mint_bird_app/screens/reporting/models/transaction_model.dart';

class ReportingController extends GetxController {
  Rx<PageController> reportPageController = PageController().obs;
  RxList<Record> recordList = <Record>[].obs;
  RxBool loading = false.obs;
  Rx<TransactionDetailModel> transactionDetails = TransactionDetailModel().obs;
  RxString tsStatus = "".obs;
  RxString transactionId = "".obs;
  RxInt currentPage = 1.obs;
  RxInt lastPage = 0.obs;
  RxBool bottomLoader = false.obs;
}
