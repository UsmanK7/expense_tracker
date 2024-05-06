import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class DBHelper {
  static Database?
      _database; // Add a static variable to store the database instance

  // Method to get or initialize the database
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    return await initDb();
  }

  Future initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "sqlite.db");
    final exist = await databaseExists(path);

    if (exist) {
      print("db already exist");
    } else {
      print("creating a copy from assets");
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      ByteData data = await rootBundle.load(join("assets", "sqlite.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
      print("db copied");
    }
    _database = await openDatabase(path); // Store the opened database instance
    return _database!;
  }
}

