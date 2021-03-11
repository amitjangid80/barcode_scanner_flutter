// Created by AMIT JANGID on 10/03/21.

import 'package:barcode_scanner_flutter/db/db_provider.dart';
import 'package:flutter/material.dart';

class BarcodeScannerResult {
  int code;
  String result;
  String scannedOn;

  BarcodeScannerResult({this.code, @required this.result, @required this.scannedOn});

  factory BarcodeScannerResult.fromJson(Map<String, dynamic> _barcodeScannerResultJson) => BarcodeScannerResult(
        code: _barcodeScannerResultJson['Code'],
        result: _barcodeScannerResultJson['Result'],
        scannedOn: _barcodeScannerResultJson['ScannedOn'],
      );

  Map<String, dynamic> toMap() => {'Code': code, 'Result': result, 'ScannedOn': scannedOn};
}

class BarcodeScannerResultDb {
  static Future<List<BarcodeScannerResult>> getBarcodeScannerResult() async {
    final _db = await DbProvider.db.database;
    String _query = 'SELECT * FROM BarcodeScannerResult';
    var _result = await _db.rawQuery(_query);

    List<BarcodeScannerResult> _barcodeScannerResultList = (_result != null && _result.isNotEmpty)
        ? _result.map((_barcodeScannerResultJson) => BarcodeScannerResult.fromJson(_barcodeScannerResultJson)).toList()
        : [];

    return _barcodeScannerResultList;
  }

  static Future<int> insertIntoBarcodeScannerResult(BarcodeScannerResult _barcodeScannerResult) async {
    final _db = await DbProvider.db.database;
    _barcodeScannerResult.code = await DbProvider.db.getMaxCode(tableName: 'BarcodeScannerResult');

    return await _db.insert('BarcodeScannerResult', _barcodeScannerResult.toMap());
  }
}
