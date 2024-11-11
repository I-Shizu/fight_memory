import '../Models/create_post_model.dart';
import '../Models/post_model.dart';
import '../Models/update_post_model.dart';
import '../database_helper.dart';

class PostRepository {
  final dbHelper = DatabaseHelper.instance;

  // 全投稿を取得
  Future<List<Post>> getAllPosts() async {
    final db = await dbHelper.database;
    final result = await db.query('posts', orderBy: 'date DESC');
    return result.map((data) => Post.fromSQLite(data)).toList();
  }

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
    return result.map((json) => Post.fromSQLite(json)).toList();
  }

  // 新規投稿を追加
  Future<void> addPost(CreatePost newPost) async {
    final db = await dbHelper.database;
    await db.insert('posts', newPost.toSQLite());
  }

  // 投稿を更新
  Future<void> updatePost(int localId, UpdatePost updatedData) async {
    final db = await dbHelper.database;
    await db.update(
      'posts',
      updatedData.toSQLite(),
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