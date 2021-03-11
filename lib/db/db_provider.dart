// Created by AMIT JANGID on 10/03/21.

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  DbProvider._();

  Database _database;
  static final DbProvider db = DbProvider._();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDb();
    return _database;
  }

  _initDb() async {
    String _path = join(await getDatabasesPath(), 'BarcodeScanner.db');

    return await openDatabase(
      _path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, int version) async {
        // creating tables
        await db.execute(_createBarcodeScannerResultTable);
      },
    );
  }

  String _createBarcodeScannerResultTable = 'CREATE TABLE IF NOT EXISTS BarcodeScannerResult ('
      'Code INTEGER, '
      'ScannedOn TEXT, '
      'Result TEXT)';

  Future<int> getMaxCode({@required String tableName}) async {
    final _db = await database;
    String _query = 'SELECT IFNULL(MAX(Code), 0) + 1 AS Code FROM $tableName';

    // getting max code + 1
    var _result = await _db.rawQuery(_query);
    int _code = _result.first["Code"];

    return _code;
  }
}
