import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

    static const _databaseName = "fight_memory.db";

  DatabaseHelper._privateConstructor();

  //データベースの初期化
  Future<Database> get database async {
    try {
      if (_database != null) return _database!;
      _database = await _initDatabase();
      return _database!;
    } catch (e) {
      // エラーを記録してクラッシュを防ぐ
      throw Exception('Failed to initialize database');
    }
  }

  //データベースの接続
  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);
    return await openDatabase(
      path,
      version: 1, 
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) { // バージョン1 → 2でカラム名変更
      await db.execute('ALTER TABLE posts RENAME COLUMN imageUrl TO imageFile');
    }
  }

  //データベースのテーブル作成
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE posts (
        localId INTEGER PRIMARY KEY AUTOINCREMENT,
        text TEXT NOT NULL,
        date TEXT NOT NULL,
        imageFile TEXT
      )
    ''');

    //サンプルデータ
    await db.insert('posts', {
      'text' : 'サンプル投稿',
      'date' : DateTime.now().toIso8601String(),
      'imageFile' : null,
    });
  }
}