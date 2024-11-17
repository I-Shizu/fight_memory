import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  static const _databaseName = "fight_memory.db";

  DatabaseHelper._privateConstructor();

  //データベースの初期化
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  //データベースの接続
  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);
    return await openDatabase(
      path,
      version: 2, // バージョンを2に変更
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
  if (oldVersion < 2) {
    // 新しいテーブルを作成
    await db.execute('''
      CREATE TABLE posts_new (
        localId INTEGER PRIMARY KEY AUTOINCREMENT,
        text TEXT NOT NULL,
        date TEXT NOT NULL,
        imageFile TEXT
      )
    ''');

    // 古いテーブルからデータをコピー
    await db.execute('''
      INSERT INTO posts_new (localId, text, date, imageFile)
      SELECT localId, text, date, imageUrl FROM posts
    ''');

    // 古いテーブルを削除
    await db.execute('DROP TABLE posts');

    // 新しいテーブルをリネーム
    await db.execute('ALTER TABLE posts_new RENAME TO posts');
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
  }
}