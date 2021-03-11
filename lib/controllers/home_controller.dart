// Created by AMIT JANGID on 10/03/21.

import 'package:barcode_scanner_flutter/models/barcode_scanner_result.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  final barcodeScannerResultList = [].obs;

  static HomeController get to => Get.find<HomeController>();

  @override
  onInit() {
    super.onInit();

    Permission.camera.request();

    // calling get scanned value list method
    getScannedValueList();
  }

  // this method will get scanned result from database
  getScannedValueList() async {
    barcodeScannerResultList.clear();

    List<BarcodeScannerResult> _barcodeScannerResultList = await BarcodeScannerResultDb.getBarcodeScannerResult();
    barcodeScannerResultList.addAll(_barcodeScannerResultList);
  }
}
