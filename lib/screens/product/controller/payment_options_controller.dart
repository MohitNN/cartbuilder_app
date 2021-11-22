import 'package:get/get.dart';

class PaymentOptionsController extends GetxController {
  RxString pricingName = ''.obs;
  RxString productPrice = '0'.obs;
  RxString monthlyProductPrice = '0'.obs;
  RxString todayProductPrice = '0'.obs;
  RxString trailNumber = '0'.obs;

  RxList<Map> paymentType = [
    {'id': '1', 'name': 'One-time fee'},
    {'id': '2', 'name': 'Subscription'},
    {'id': '3', 'name': 'Split pay'},
  ].obs;
  RxString selectedPaymentType = 'One-time fee'.obs;

  RxList<Map> trailPeriod = [
    {'id': '0', 'name': 'None'},
    {'id': '1', 'name': '1 days'},
    {'id': '2', 'name': '3 days'},
    {'id': '3', 'name': '7 days'},
    {'id': '4', 'name': '30 days'},
    {'id': '5', 'name': 'custom'},
  ].obs;
  RxString selectedTrailPeriod = '1'.obs;

  RxList<Map> limitQuantityAvailable = [
    {'id': '1', 'name': 'Set to Unlimited'},
  ].obs;
  RxString selectedLimitQuantityAvailable = ''.obs;

  RxList<Map> numbersOfPayment = [
    {'id': '1', 'name': '2 payments'},
    {'id': '2', 'name': '3 payments'},
    {'id': '3', 'name': '4 payments'},
    {'id': '4', 'name': '5 payments'},
    {'id': '5', 'name': '6 payments'},
  ].obs;
  RxString selectedNumbersOfPayment = '1'.obs;

  RxList<Map> billingFrequency = [
    {'id': '0', 'name': 'Monthly'},
    {'id': '1', 'name': 'Annually'},
    {'id': '2', 'name': 'Quarterly'},
    {'id': '3', 'name': 'Every 6 Months'},
    {'id': '4', 'name': 'Every 2 Months'},
    {'id': '5', 'name': 'Weekly'},
    {'id': '6', 'name': 'Daily'},
  ].obs;
  RxString selectedBillingFrequency = '0'.obs;

  RxList<Map> trailType = [
    {'id': '7', 'name': 'days'},
    {'id': '8', 'name': 'weeks'},
    {'id': '9', 'name': 'months'},
  ].obs;
  RxString selectedTrailType = 'days'.obs;
}

PaymentOptionsController paymentOptionsController = PaymentOptionsController();
