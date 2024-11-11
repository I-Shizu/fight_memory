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