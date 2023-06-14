import 'dart:io';
import 'package:app_mental/helper/helperfuncions.dart';
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
          version INTEGER,
          iconGroupImage STRING,
          idRelatedReading STRING
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

  Future<List<Reading>> getListRelatedReading(
      List<dynamic> idReadingList) async {
    Database db = await instance.database;
    List<Reading> readingList = [];
    idReadingList.forEach((idReading) async {
      List<Map<String, dynamic>> readingRetrieved =
          await db.query('readings', where: 'id = "$idReading"');
      readingList.add(Reading(
          id: readingRetrieved[0]['id'],
          group: readingRetrieved[0]['group'],
          name: readingRetrieved[0]['name'],
          text: readingRetrieved[0]['text'],
          version: readingRetrieved[0]['version'],
          iconGroupImage: readingRetrieved[0]['iconGroupImage'],
          idRelatedReading: readingRetrieved[0]['idRelatedReading']));
    });
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
    List<Map> reading = await db
        .rawQuery('SELECT DISTINCT `group`, iconGroupImage  FROM readings');
    return reading;
  }

  Future<int> getReadingGroupSize(String group) async {
    Database db = await instance.database;
    int? groupSize = Sqflite.firstIntValue(await db
        .rawQuery('SELECT COUNT(*) FROM readings WHERE `group` = "$group"'));
    return groupSize!;
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
