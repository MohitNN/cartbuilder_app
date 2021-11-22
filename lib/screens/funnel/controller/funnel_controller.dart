import 'dart:async';

import 'package:get/get.dart';
import 'package:mint_bird_app/screens/funnel/model/all_downsell_model.dart';
import 'package:mint_bird_app/screens/funnel/model/all_upsell_model.dart';
import 'package:mint_bird_app/screens/funnel/model/single_funnel_product_model.dart';
import 'package:mint_bird_app/screens/funnel/model/user_funnel_model.dart';
import 'package:rxdart/subjects.dart';

class FunnelController extends GetxController {
  RxString selectedGroup = ''.obs;
  RxString funnelId = ''.obs;
  RxList<Map> funnelGroup = [{}].obs;
  RxBool isLoading = false.obs;
  RxList<FunnelsProduct> funnelProducts = <FunnelsProduct>[].obs;
  RxList<FunnelsProduct1> funnelProductList = <FunnelsProduct1>[].obs;
  RxList<String> upsellId = <String>[].obs;
  RxList<String> downsellId = <String>[].obs;
  RxBool thumbnailSwitch = true.obs;
  Rx<AllUpsellModel> allUpsellModel = AllUpsellModel().obs;
  Rx<AllDownsellModel> allDownsellModel = AllDownsellModel().obs;
  RxList<FunnelsProduct1> newFunnelProductList = <FunnelsProduct1>[].obs;
  RxList<String> existingFunnelUpsells = <String>[].obs;
  RxList<String> existingFunnelDownsell = <String>[].obs;
  RxList<bool> lengthOfAvailable = <bool>[].obs;
  RxBool isUpsellOpen = false.obs;
  RxBool isDownsellOpen = false.obs;
  RxInt selectedUpsellIndex = 0.obs;
  RxString selectedUpsellId = "".obs;
  RxBool isUpsell = false.obs;
}

class GetFunnelListBloc {
  StreamController<List<FunnelsProduct>> funnelListController =
      PublishSubject<List<FunnelsProduct>>();

  Stream<List<FunnelsProduct>> get funnelListStream =>
      funnelListController.stream;

  Sink<List<FunnelsProduct>> get funnelListSink => funnelListController.sink;

  setFunnelList(data) {
    funnelListSink.add(data);
  }

  void dispose() {
    funnelListController.close();
  }
}

final GetFunnelListBloc getFunnelListBloc = GetFunnelListBloc();
