import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/screens/product/models/user_product_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:rxdart/rxdart.dart';

getUserProductService() async {
  print("*** PRODUCT");
  DashboardController dashboardController = Get.put(DashboardController());
  dashboardController.isLoading.value = true;
  var response = await http.get(
      Uri.parse(APIUtils.baseUrl +
          APIUtils.getProducts +
          "${dashboardController.searchQuery.value.length > 0 ? "?search=${dashboardController.searchQuery.value}" : ""}" +
          "${dashboardController.currentPage.value == 1 && dashboardController.searchQuery.value.length > 0 ? "" : "?page=${dashboardController.currentPage.value}"}"),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  print("*** PRODUCT  $decodedData");
  if (decodedData["code"] == 200) {
    getProductListBloc
        .setProductList(UserProductModel.fromJson(decodedData).products);
    UserProductModel userProductModel = UserProductModel.fromJson(decodedData);
    dashboardController.lastPage.value = userProductModel.lastPage;
    dashboardController.currentPage.value =
        dashboardController.currentPage.value + 1;
    userProductModel.products.forEach((element) {
      dashboardController.listOfProduct.add(element);
    });
    dashboardController.isLoading.value = false;
    dashboardController.bottomLoader.value = false;
  } else {
    dashboardController.isLoading.value = false;
    dashboardController.bottomLoader.value = false;
  }
}

class GetProductListBloc {
  StreamController<List<ProductData>> productListController =
      PublishSubject<List<ProductData>>();

  Stream<List<ProductData>> get productListStream =>
      productListController.stream;

  Sink<List<ProductData>> get productListSink => productListController.sink;

  setProductList(data) {
    productListSink.add(data);
  }

  void dispose() {
    productListController.close();
  }
}

final GetProductListBloc getProductListBloc = GetProductListBloc();
