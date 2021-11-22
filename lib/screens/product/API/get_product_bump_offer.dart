import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/screens/product/models/added_bump_offer_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:rxdart/rxdart.dart';

getProductBumpOfferService(String productId) async {
  ProductController productController = Get.put(ProductController());
  var response = await http.post(
    Uri.parse(APIUtils.baseUrl + APIUtils.getAddedBumpOffer),
    headers: {
      "Authorization": "Bearer ${authController.userToken.value}",
    },
    body: {'product_id': productId},
  );

  Map<String, dynamic> decodedData = jsonDecode(response.body);

  if (decodedData["code"] == 200) {
    productController.isDialogLoading.value = false;
    getAddedBumpOfferListBloc.setAddedBumpOfferList(
        AddedBumpOfferModel.fromJson(decodedData).response);
  }
}

class GetAddedBumpOfferListBloc {
  StreamController<List<AddedBumpOffer>> addedBumpOfferListController =
      PublishSubject<List<AddedBumpOffer>>();

  Stream<List<AddedBumpOffer>> get addedBumpOfferListStream =>
      addedBumpOfferListController.stream;

  Sink<List<AddedBumpOffer>> get addedBumpOfferListSink =>
      addedBumpOfferListController.sink;

  setAddedBumpOfferList(List<AddedBumpOffer> data) {
    addedBumpOfferListSink.add(data);
  }

  void dispose() {
    addedBumpOfferListController.close();
  }
}

final GetAddedBumpOfferListBloc getAddedBumpOfferListBloc =
    GetAddedBumpOfferListBloc();
