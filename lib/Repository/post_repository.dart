import 'dart:io';
import '../Repository/post_image_repository.dart';
import '../sqlite_mapper.dart';
import '../Models/post_model.dart';
import '../database_helper.dart';

class PostRepository {
  final PostImageRepository _postImageRepository = PostImageRepository();
  final dbHelper = DatabaseHelper.instance;

  // 全投稿を取得
  Future<List<Post>> getAllPostsFromDB() async {
    final db = await dbHelper.database;
    final result = await db.query('posts', orderBy: 'date DESC');
    return result.map((data) => SQLiteMapper.fromSQLite(data)).toList();
  }

  //日にちごとに投稿を取得
  Future<List<Post>> getPostsForDay(DateTime selectedDay) async {
    final db = await dbHelper.database;
    // 選択された日付の0時と23時59分59秒を取得して、その日の投稿を取得
    final startOfDay = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
    final endOfDay = DateTime(selectedDay.year, selectedDay.month, selectedDay.day, 23, 59, 59);

    // データベースクエリで、日付範囲内の投稿を取得
    final result = await db.query(
      'posts',
      where: 'date >= ? AND date <= ?',
      whereArgs: [startOfDay.toIso8601String(), endOfDay.toIso8601String()],
    );

    // 取得した結果をPostモデルに変換
    return result.map((json) => SQLiteMapper.fromSQLite(json)).toList();
  }

  // 新規投稿を追加
  Future<void> addPostToDB(String text, DateTime date, {File? image}) async {
    // 画像がある場合は保存し、パスを取得
    String? imagePath;
    if (image != null) {
      imagePath = await _postImageRepository.saveImagePathToPersistentDirectory(image);
      print("保存した画像パス: $imagePath"); // デバッグ用
    }

    // Post モデルを作成
    final newPost = Post(
      localId: null, // 自動生成されるため null
      text: text,
      date: date,
      imageFile: imagePath,
    );

    // データベースに保存
    final db = await dbHelper.database;
    await db.insert('posts', SQLiteMapper.toSQLite(newPost));
  }

  // 投稿を更新
  Future<void> updatePost(int localId,Post updatedData) async {
    final db = await dbHelper.database;
    await db.update(
      'posts',
      SQLiteMapper.toSQLite(updatedData),
      where: 'localId = ?',
      whereArgs: [localId],
    );
  }

  // 特定の投稿を削除
  Future<void> deletePost(int localId) async {
    final db = await dbHelper.database;
    await db.delete(
      'posts',
      where: 'localId = ?',
      whereArgs: [localId],
    );
  }
}