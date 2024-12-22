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

  //データベースの挿入(Create)
  Future<void> insertPost() async {
    final db = await database;
    final int localId = await db.insert(
      'posts',
      {
        'text': 'テスト投稿',
        'date': DateTime.now().toIso8601String(),
        'imageFile': 'test.jpg',
      },
    );
    print('inserted: $localId');
  }

  //データベースを取得(Read)
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

  //データベースを更新(Update)
  Future<void> updatePost() async {
    final db = await database;
    int count = await db.rawUpdate(
    'UPDATE Test SET name = ?, value = ? WHERE name = ?',
    ['updated name', '9876', 'some name']);
    print('updated: $count');
  }

  //特定のデータを削除(Delete)
  Future<void> deletePost() async {
    final db = await database;
    int count = await db.rawDelete('DELETE FROM Test WHERE name = ?', ['another name']);
    print('deleted: $count');
  }

  //データベースを閉じる
  Future<void> closeDb() async {
    final db = await database;
    db.close();
  }
}