import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/funnel/model/single_funnel_product_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:rxdart/rxdart.dart';

getSingleFunnelProductService(String funnelId) async {
  var response = await http.get(
      Uri.parse(APIUtils.baseUrl + APIUtils.getSingleFunnelProduct + funnelId),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (decodedData["code"] == 200) {
    getSingleFunnelProductBloc.setSingleFunnelProduct(
        SingleFunnelProductModel.fromJson(decodedData).response.funnelsProduct);
    // return SingleFunnelProductModel.fromJson(decodedData).response;
  } else {
    // return Funnel();
  }
}

class GetSingleFunnelProductBloc {
  StreamController<List<FunnelsProduct1>> singleFunnelProductController =
      PublishSubject<List<FunnelsProduct1>>();

  Stream<List<FunnelsProduct1>> get singleFunnelProductStream =>
      singleFunnelProductController.stream;

  Sink<List<FunnelsProduct1>> get singleFunnelProductSink =>
      singleFunnelProductController.sink;

  setSingleFunnelProduct(List<FunnelsProduct1> data) {
    singleFunnelProductSink.add(data);
  }

  void dispose() {
    singleFunnelProductController.close();
  }
}

final GetSingleFunnelProductBloc getSingleFunnelProductBloc =
    GetSingleFunnelProductBloc();
