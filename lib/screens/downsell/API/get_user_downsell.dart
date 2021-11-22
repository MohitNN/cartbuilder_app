import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/downsell/models/user_downsell_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:rxdart/rxdart.dart';

Future<UserDownSellModel> getUserDownSellService() async {
  print("*** DOWNSELL");
  DashboardController dashboardController = Get.put(DashboardController());
  dashboardController.isLoading.value = true;
  var response = await http.get(
      Uri.parse(APIUtils.baseUrl +
          APIUtils.getUserDownSell +
          "${dashboardController.searchQuery.value.length > 0 ? "?search=${dashboardController.searchQuery.value}" : ""}" +
          "${dashboardController.currentPage.value == 1 && dashboardController.searchQuery.value.length > 0 ? "" : "?page=${dashboardController.currentPage.value}"}"),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });

  Map<String, dynamic> decodedData = jsonDecode(response.body);
  print("*** DOWNSELL  $decodedData");
  if (decodedData["code"] == 200) {
    UserDownSellModel userDownSellModel =
        UserDownSellModel.fromJson(decodedData);
    userDownSellModel.response.forEach((element) {
      dashboardController.listOfDownsell.add(element);
    });
    dashboardController.lastPage.value = userDownSellModel.lastPage;
    dashboardController.currentPage.value =
        dashboardController.currentPage.value + 1;
    dashboardController.isLoading.value = false;
    dashboardController.bottomLoader.value = false;
    return userDownSellModel;
  } else {
    dashboardController.isLoading.value = false;
    dashboardController.bottomLoader.value = false;
    return UserDownSellModel();
  }
}

class GetDownSellsListBloc {
  StreamController<List<Map>> downSellsListController =
      PublishSubject<List<Map>>();

  Stream<List<Map>> get downSellsListStream => downSellsListController.stream;

  Sink<List<Map>> get downSellsListSink => downSellsListController.sink;

  setDownSellsList(data) {
    downSellsListSink.add(data);
  }

  void dispose() {
    downSellsListController.close();
  }
}

final GetDownSellsListBloc getDownSellsListBloc = GetDownSellsListBloc();
