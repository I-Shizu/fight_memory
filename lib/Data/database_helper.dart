import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper extends AsyncNotifier<List<Map>>{
  late String path;
  late Database database;
  List<Map> listMap = [];
  
  @override
  Future<List<Map>> build() async {
    var databasesPath = await getDatabasesPath();
    // 取得したパスから本アプリ用にて生成するDB名を指定
    path = '$databasesPath/posts.db';
    // データベースを開く（pathに存在しなければ新規作成）
    database = await openDatabase(
        path,
        version: 1,
        // DBがpathに存在しなかった場合にonCreateが呼び出される
        onCreate: (Database db, int version) async {
          await db.execute(
            'CREATE TABLE posts('
            'localId INTEGER PRIMARY KEY AUTOINCREMENT,'
            'text TEXT,'
            'date TEXT,'
            'imageFile TEXT'
            ')',
          );
        });
    return [];
  }

  //データベースに新しいデータを挿入(Create)
  //テキストと画像をどこで管理するか？
  Future<void> insertDb(String text,String imageFile) async {
    final db = await readDb;
    await db.insert(
      'posts',
      {
        'text': text,
        'date': DateTime.now().toIso8601String(),
        'imageFile': imageFile,
      },
    );
    // SELECT
    listMap = await database.rawQuery('SELECT * FROM Test');
    // 状態更新
    
  }

  //データベースを取得する処理(Read)
  Future<Database> get readDb async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'posts.db');
    database = await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE posts('
        'localId INTEGER PRIMARY KEY AUTOINCREMENT,'
        'text TEXT,'
        'date TEXT,'
        'imageFile TEXT'
        ')',
      );
    });
    return database;
  }

  //データベースを編集した時の更新処理(Update)
  Future<void> updateDb(int localId,String text,String imageFile) async {
    final db = await readDb;
    await db.update(
      'posts',
      {
        'text': text,
        'image': imageFile,
      },
      where: 'localId = ?',
      whereArgs: [localId],
    );
  }

  //特定のデータを削除(Delete)
  Future<void> deleteDb(int localId) async {
    final db = await readDb;
    await db.delete(
      'posts',
      where: 'localId = ?',
      whereArgs: [localId],
    );
    //状態更新
  }

  //データベースを閉じる
  Future<void> closeDb() async {
    final db = await readDb;
    db.close();
  }
}