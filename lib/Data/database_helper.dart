import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Database? _database;
  
  //アプリにデータベースを作成
  Future<Database> open(String path, {required int version, required Future<Null> Function(dynamic db, dynamic version) onCreate}) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'posts.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE posts('
          'localId INTEGER PRIMARY KEY AUTOINCREMENT,'
          'text TEXT,'
          'date TEXT,'
          'imageFile TEXT'
          ')',
        );
      },
    );
  }

  //データベースを取得
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'posts.db');
    _database = await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE posts('
        'localId INTEGER PRIMARY KEY AUTOINCREMENT,'
        'text TEXT,'
        'date TEXT,'
        'imageFile TEXT'
        ')',
      );
    });
    return _database!;
  }

  //データベースを閉じる
  Future<void> closeDb() async {
    final db = await database;
    db.close();
  }
}