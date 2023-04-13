import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:app_mental/classes/audioDiaryClass.dart';
import 'package:app_mental/helper/helperfuncions.dart';

class AudioDatabase {
  AudioDatabase._privateConstructor();
  static final AudioDatabase instance = AudioDatabase._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<String> getUserEmail() async {
    return await HelperFunctions.getUserEmailInSharedPreference();
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'audiodiary.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE audiodiary(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          userEmail STRING,
          audioPath STRING
      )
      ''');
  }

  Future<List<AudioDiaryClass>> getAudioDiary() async {
    Database db = await instance.database;
    var audioDiary = await db.query('audiodiary',
        where: 'userEmail = ?',
        whereArgs: [await getUserEmail()],
        orderBy: 'audioPath DESC');
    List<AudioDiaryClass> audioDiaryList = audioDiary.isNotEmpty
        ? audioDiary.map((c) => AudioDiaryClass.fromMap(c)).toList()
        : [];
    return audioDiaryList;
  }

  Future<int> add(AudioDiaryClass audioDiary) async {
    Database db = await instance.database;
    return await db.insert('audiodiary', audioDiary.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('audiodiary', where: 'id = ?', whereArgs: [id]);
  }
}
