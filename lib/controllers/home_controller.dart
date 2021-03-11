// Created by AMIT JANGID on 10/03/21.

import 'package:barcode_scanner_flutter/models/barcode_scanner_result.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final barcodeScannerResultList = [].obs;

  static HomeController get to => Get.find<HomeController>();

  getScannedValueList() async {
    barcodeScannerResultList.clear();

    List<BarcodeScannerResult> _barcodeScannerResultList = await BarcodeScannerResultDb.getBarcodeScannerResult();
    barcodeScannerResultList.addAll(_barcodeScannerResultList);
  }
}
