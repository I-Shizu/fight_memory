import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../database_helper.dart';

class PostImageRepository {

  //永続ディレクトリに画像のパスを保存する
  Future<String> saveImagePathToPersistentDirectory(File image) async {
    //永続ディレクトリを取得
    final directory = await getApplicationDocumentsDirectory();
    //ファイル名を取得
    final fileName = image.path.split('/').last;
    //新しい保存先を指定
    final newPath = '${directory.path}/$fileName';
    //永続ディレクトリにコピー
    final savedImage = await image.copy(newPath);
    //画像のパスを返す
    return savedImage.path;
  }

  //SQLiteに画像パスを保存する
  Future<void> saveImagePathToDatebase(String filePath) async {
    final db = await DatabaseHelper.instance.database;
    //永続ディレクトリに保存したパスをデータベースに挿入する
    await db.insert('images', {'path': filePath});
  }

  //SQLiteから画像ファイルを取得する
  Future<File?> getImagePathFromDatabase(String filePath) async {
    final db = await DatabaseHelper.instance.database;

    // 特定の画像パスを検索
    final List<Map<String, dynamic>> images = await db.query(
      'images',
      where: 'path = ?',
      whereArgs: [filePath],
    );

    if (images.isEmpty) return null;

    final retrievedPath = images.first['path'] as String;
    final file = File(retrievedPath);

    return file.existsSync() ? file : null;
  } 
}