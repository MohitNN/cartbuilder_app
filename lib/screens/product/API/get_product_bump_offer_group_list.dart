import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/bump_offers/controller/bump_offer_controller.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/screens/product/models/bump_offer_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:rxdart/rxdart.dart';

getBumpOfferGroupListService() async {
  ProductController productController = Get.put(ProductController());
  BumpOfferController bumpOfferController = Get.put(BumpOfferController());
  productController.isLoading.value = true;
  bumpOfferController.isLoading.value = true;
  var response = await http.get(
      Uri.parse(APIUtils.baseUrl + APIUtils.getBumpOfferGroupList),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });

  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["code"] == 200) {
      productController.bumpOfferGroups.clear();
      decodedData["response"].forEach((element) {
        productController.bumpOfferGroups.add({
          "id": element["_id"],
          "name": element["name"],
        });
      });
      productController.selectedBumpOfferGroup.value =
          productController.bumpOfferGroups.first["id"];
      productController.isLoading.value = false;
      bumpOfferController.isLoading.value = false;
      getBumpOfferService(productController.bumpOfferGroups.first["id"]);
    } else {
      productController.isLoading.value = false;
    }
  }
}

getBumpOfferService(String key) async {
  ProductController productController = Get.put(ProductController());
  productController.isLoading.value = true;
  var response = await http.get(
    Uri.parse(APIUtils.baseUrl + APIUtils.getBumpOffer),
    headers: {
      "Authorization": "Bearer ${authController.userToken.value}",
    },
  );
  productController.isLoading.value = false;

  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (decodedData["code"] == 200) {
    List<BumpOfferData> bumpOffer =
        BumpOfferModel.fromJson(decodedData).response;
    GetBumpOfferListBloc().setBumpOfferList(bumpOffer);
    productController.bumpOffers.clear();
    bumpOffer.forEach((element) {
      productController.bumpOffers.add({
        "id": element.id,
        "name": element.offerName,
        "group": element.group,
      });
    });
    productController.selectedBumpOffer.value =
        productController.bumpOffers.length != 0
            ? productController.bumpOffers.first["id"]
            : '';

    productController.isLoading.value = false;
  } else {
    productController.isLoading.value = false;
  }
}

class GetBumpOfferListBloc {
  StreamController<List<BumpOfferData>> bumpOfferListController =
      PublishSubject<List<BumpOfferData>>();

  Stream<List<BumpOfferData>> get bumpOfferListStream =>
      bumpOfferListController.stream;

  Sink<List<BumpOfferData>> get bumpOfferListSink =>
      bumpOfferListController.sink;

  setBumpOfferList(data) {
    bumpOfferListSink.add(data);
  }

  void dispose() {
    bumpOfferListController.close();
  }
}

final GetBumpOfferListBloc getBumpOfferListBloc = GetBumpOfferListBloc();
