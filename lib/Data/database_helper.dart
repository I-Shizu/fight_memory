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
    if (oldVersion < 2) { // バージョン1 → 2でカラム名変更
      await db.execute('ALTER TABLE posts RENAME COLUMN imageUrl TO imageFile');
      print('Upgraded database: Renamed column imageUrl to imageFile');
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