import 'package:get/get.dart';
import 'package:mint_bird_app/screens/subscriptions/models/subscription_detail_model.dart';
import 'package:mint_bird_app/screens/subscriptions/models/subscription_list_data_model.dart';

class SubscriptionController extends GetxController {
  RxBool loading = false.obs;
  RxString subscription = ''.obs;
  RxString mrr = ''.obs;
  RxString yearlyRevenue = ''.obs;
  RxInt currentPage = 1.obs;
  RxInt lastPage = 0.obs;
  RxString tsStatus = "".obs;

  Rx<SubscriptionsDetailListDataModel> subscriptionsDetails = SubscriptionsDetailListDataModel().obs;
  RxBool bottomLoader = false.obs;
  RxList<SubscriptionDetail> subscriptionsDetailList =
      <SubscriptionDetail>[].obs;
}
