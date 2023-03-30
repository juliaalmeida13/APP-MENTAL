import 'dart:io';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../model/reading.dart';

class ReadingDatabase {
  ReadingDatabase._privateConstructor();
  static final ReadingDatabase instance = ReadingDatabase._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<String> getUserEmail() async {
    return await HelperFunctions.getUserEmailInSharedPreference();
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'readings.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE readings(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          `group` STRING,
          name STRING,
          text STRING,
          type CHAR,
          image STRING,
          video STRING,
          version INTEGER
      )
      ''');
  }

  Future<List<Reading>> getReadings() async {
    Database db = await instance.database;
    var reading = await db.query('readings');
    List<Reading> readingList = reading.isNotEmpty
        ? reading.map((c) => Reading.fromMap(c)).toList()
        : [];
    return readingList;
  }

  Future<List<Reading>> getReadingsByGroup(String group) async {
    Database db = await instance.database;
    var reading = await db.query('readings', where: '`group` = "$group"');
    List<Reading> readingList = reading.isNotEmpty
        ? reading.map((c) => Reading.fromMap(c)).toList()
        : [];
    return readingList;
  }

  Future<List<Map>> getReadingGroups() async {
    Database db = await instance.database;
    List<Map> reading =
        await db.rawQuery('SELECT DISTINCT `group` FROM readings');
    return reading;
  }

  Future<int> getReadingVersion() async {
    Database db = await instance.database;
    List<Map> reading = await db.rawQuery('SELECT MAX(version) FROM readings');
    return reading.first['MAX(version)'];
  }

  Future<int> add(Reading reading) async {
    Database db = await instance.database;
    return await db.insert('readings', reading.toMap());
  }

  dropAllRows() async {
    Database db = await instance.database;
    await db.rawQuery('DELETE FROM readings');
  }
}
