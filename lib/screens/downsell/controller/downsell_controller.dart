import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class DownSellController extends GetxController {
  RxBool downStatusSwitch = false.obs;
  RxInt selectedCheckoutTemplate = 0.obs;
  RxInt customizeTabIndex = 0.obs;
  RxDouble downsellLoads = 0.0.obs;

  RxString downSellId = "".obs;
  String selectedDownSellVal = "Select a Group";
  RxList<Map> downSellGroup = [{}].obs;
  RxBool isLoading = false.obs;
  RxString selectedGroup = "".obs;
  RxString selectedGroupId = ''.obs;
  RxBool displayThumbnailSwitch = false.obs;

  updateSelDownSellDropDownVal(String value) {
    selectedDownSellVal = value;
  }
}

class GetDownSellDataBloc {
  StreamController<File> downSellImageController = PublishSubject<File>();
  StreamController<bool> downSellDisplayImageController =
      PublishSubject<bool>();

  Stream<File> get downSellImageStream => downSellImageController.stream;

  Stream<bool> get downSellDisplayImageStream =>
      downSellDisplayImageController.stream;

  Sink<File> get downSellImageSink => downSellImageController.sink;

  Sink<bool> get downSellDisplayImageSink =>
      downSellDisplayImageController.sink;

  setDownSellImage(File image) => downSellImageSink.add(image);

  setDownSellDisplayImage(bool image) => downSellDisplayImageSink.add(image);

  void dispose() {
    downSellImageController.close();
    downSellDisplayImageController.close();
  }
}

final GetDownSellDataBloc getDownSellDataBloc = GetDownSellDataBloc();
