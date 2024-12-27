import 'package:fight_app2/Utils/sqlite_mapper.dart';

import '../Models/post_model.dart';
import '../database_helper.dart';

class PostRepository {
  DatabaseHelper dbHelper = DatabaseHelper();

  // 全投稿を取得
  Future<List<Post>> getAllPosts() async {
    final db = await dbHelper.readDb;
    final result = await db.query('posts', orderBy: 'date DESC');
    return result.map((data) => SQLiteMapper.fromSQLite(data)).toList();
  }

  //日にちごとに投稿を取得
  Future<List<Post>> getPostsForDay(DateTime selectedDay) async {
    final db = await dbHelper.readDb;
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
  Future<int> addPost(Post newPost) async {
    final db = await dbHelper.readDb;
    final int localId = await db.insert('posts', SQLiteMapper.toSQLite(newPost));
    return localId;
  }

  // 投稿を更新?
  Future<void> updatePost(int localId,String text,String imageFile) async {
    await dbHelper.updateDb(localId, text, imageFile);
  }

  // 特定の投稿を削除
  Future<void> deletePost(int localId) async {
    await dbHelper.deleteDb(localId);
  }
}