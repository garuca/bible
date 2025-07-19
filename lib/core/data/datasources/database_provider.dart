import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();

  factory DatabaseProvider() => _instance;

  DatabaseProvider._internal();

  late Database dbKJA;
  late Database dbKJF;

  Future<void> init() async {
    dbKJA = await _initDB('assets/db/KJA.sqlite', 'KJA.sqlite');
    dbKJF = await _initDB('assets/db/KJF.sqlite', 'KJF.sqlite');
  }

  Future<Database> _initDB(String assetPath, String dbName) async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, dbName);
    if (!await databaseExists(path)) {
      await Directory(dirname(path)).create(recursive: true);
      final data = await rootBundle.load(assetPath);
      final bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );
      await File(path).writeAsBytes(bytes, flush: true);
    }
    return openDatabase(path, readOnly: true);
  }
}