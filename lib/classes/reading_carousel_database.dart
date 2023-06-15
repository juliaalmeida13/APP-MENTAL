import 'dart:io';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:app_mental/model/reading_image_carousel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ReadingCarouselDatabase {
  ReadingCarouselDatabase._privateConstructor();
  static final ReadingCarouselDatabase instance =
      ReadingCarouselDatabase._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<String> getUserEmail() async {
    return await HelperFunctions.getUserEmailInSharedPreference();
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'readingCarousel.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE readingCarousel(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          readingId INTEGER,
          base64Image STRING
      )
      ''');
  }

  Future<List<String>> getImagesById(int idReading) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> readingRetrieved = await db.rawQuery(
        'SELECT base64Image FROM readingCarousel WHERE readingId = "$idReading"');
    List<String> base64ImageList = [];
    for (int i = 0; i < readingRetrieved.length; i++) {
      base64ImageList.add(readingRetrieved[i]['base64Image']);
    }
    return base64ImageList;
  }

  Future<int> add(ReadingImageCarousel reading) async {
    Database db = await instance.database;
    return await db.insert('readingCarousel', reading.toMap());
  }

  dropAllRows() async {
    Database db = await instance.database;
    await db.rawQuery('DELETE FROM readingCarousel');
  }
}
