import 'dart:io';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:app_mental/classes/textDiaryClass.dart';

class TextDatabase {
  TextDatabase._privateConstructor();
  static final TextDatabase instance = TextDatabase._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<String> getUserEmail() async {
    return await HelperFunctions.getUserEmailInSharedPreference();
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'textdiary.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE textdiary(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          userEmail STRING,
          createdDate STRING,
          descriptionText STRING
      )
      ''');
  }

  Future<List<TextDiaryClass>> getTextDiary() async {
    Database db = await instance.database;
    var textDiary = await db.query('textdiary',
        where: 'userEmail = ?',
        whereArgs: [await getUserEmail()],
        orderBy: 'createdDate DESC');
    List<TextDiaryClass> textDiaryList = textDiary.isNotEmpty
        ? textDiary.map((c) => TextDiaryClass.fromMap(c)).toList()
        : [];
    return textDiaryList;
  }

  Future<int> add(TextDiaryClass textDiary) async {
    Database db = await instance.database;
    return await db.insert('textdiary', textDiary.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('textdiary', where: 'id = ?', whereArgs: [id]);
  }
}
