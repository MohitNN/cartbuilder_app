import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/upsell/models/user_upsell_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:rxdart/rxdart.dart';

Future<List<Map>> getUpSellListService(String type) async {
  DashboardController dashboardController = Get.put(DashboardController());
  dashboardController.isLoading.value = true;
  var response = (type == 'downsell')
      ? await http.get(
          Uri.parse(APIUtils.baseUrl + APIUtils.getDownSellList),
          headers: {
            "Authorization": "Bearer ${authController.userToken.value}",
          },
        )
      : await http.get(
          Uri.parse(APIUtils.baseUrl + APIUtils.getUpsellList),
          headers: {
            "Authorization": "Bearer ${authController.userToken.value}",
          },
        );
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  List<Map> upsellList = [];
  if (decodedData["code"] == 200) {
    decodedData['response'].forEach((val) {
      upsellList.add(val);
    });
    getUpSellsListBloc.setUpDataList(upsellList);
    return upsellList;
  } else {
    return [];
  }
}

Future<UserUpsellModel> getUserUpSellService() async {
  print("*** UPSELL");
  DashboardController dashboardController = Get.put(DashboardController());
  dashboardController.isLoading.value = true;
  var response = await http.get(
      Uri.parse(APIUtils.baseUrl +
          APIUtils.getUserUpSell +
          "${dashboardController.searchQuery.value.length > 0 ? "?search=${dashboardController.searchQuery.value}" : ""}" +
          "${dashboardController.currentPage.value == 1 && dashboardController.searchQuery.value.length > 0 ? "" : "?page=${dashboardController.currentPage.value}"}"),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  print("*** UPSELL  $decodedData");
  if (decodedData["code"] == 200) {
    getUpSellsListBloc
        .setUpSellsList(UserUpsellModel.fromJson(decodedData).upsells);
    UserUpsellModel userUpsellModel = UserUpsellModel.fromJson(decodedData);
    dashboardController.lastPage.value = userUpsellModel.lastPage;
    dashboardController.currentPage.value =
        dashboardController.currentPage.value + 1;
    userUpsellModel.upsells.forEach((element) {
      dashboardController.listOfUpsell.add(element);
    });
    dashboardController.isLoading.value = false;
    dashboardController.bottomLoader.value = false;
    return userUpsellModel;
  } else {
    dashboardController.isLoading.value = false;
    dashboardController.bottomLoader.value = false;
    return UserUpsellModel();
  }
}

class GetUpSellsListBloc {
  StreamController<List<UpSellDatum>> upSellsListController =
      PublishSubject<List<UpSellDatum>>();
  StreamController<List<Map>> upDataListController =
      PublishSubject<List<Map>>();

  Stream<List<UpSellDatum>> get upSellsListStream =>
      upSellsListController.stream;

  Stream<List<Map>> get upDataListStream => upDataListController.stream;

  Sink<List<UpSellDatum>> get upSellsListSink => upSellsListController.sink;

  Sink<List<Map>> get upDataListSink => upDataListController.sink;

  setUpSellsList(data) {
    upSellsListSink.add(data);
  }

  setUpDataList(data) {
    upDataListSink.add(data);
  }

  void dispose() {
    upSellsListController.close();
    upDataListController.close();
  }
}

final GetUpSellsListBloc getUpSellsListBloc = GetUpSellsListBloc();
