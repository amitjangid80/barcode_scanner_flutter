// Created by AMIT JANGID on 10/03/21.

import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcode_scanner_flutter/main.dart';
import 'package:barcode_scanner_flutter/models/barcode_scanner_result.dart';
import 'package:barcode_scanner_flutter/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiutillib/multiutillib.dart';

class HomeScreen extends StatelessWidget {
  static final String _tag = 'HomeScreen';
  final _homeController = HomeController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Barcode Scanner')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultButton(
            borderRadius: 0,
            text: 'Scan Barcode',
            // calling scan and save barcode result
            onPressed: _scanAndSaveBarcodeResult,
            btnTextStyle: TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: _homeController.barcodeScannerResultList.length,
                itemBuilder: (context, _position) {
                  BarcodeScannerResult _barcodeScannerResult = _homeController.barcodeScannerResultList[_position];

                  return Material(
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichTextWidget(
                          caption: 'Scanned On',
                          description: _barcodeScannerResult.scannedOn,
                          captionStyle: TextStyle(fontSize: 18, color: Colors.black),
                          descriptionStyle: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        RichTextWidget(
                          isDescNewLine: true,
                          caption: 'Scan Result',
                          description: _barcodeScannerResult.result,
                          captionStyle: TextStyle(fontSize: 18, color: Colors.black),
                          descriptionStyle: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // this method will scan barcode or qr code and insert result into datatbase table
  _scanAndSaveBarcodeResult() async {
    try {
      var _result = await BarcodeScanner.scan();

      if (_result != null && _result.isNotEmpty) {
        BarcodeScannerResult _barcodeScannerResult = BarcodeScannerResult(
          result: _result,
          scannedOn: getCurrentDate(newDateTimeFormat: 'dd-MM-yyyy'),
        );

        // inserting records into barcode scanner result table
        var _insertValue = await BarcodeScannerResultDb.insertIntoBarcodeScannerResult(_barcodeScannerResult);

        if (_insertValue != null && _insertValue > 0) {
          _homeController.getScannedValueList();
        }
      }
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while scanning and saving bar code scan result',
      );
    }
  }
}
