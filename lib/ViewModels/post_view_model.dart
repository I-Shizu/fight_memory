import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Models/create_post_model.dart';
import '../Models/post_model.dart';
import '../Models/update_post_model.dart';
import '../Provider/providers.dart';
import '../Repository/post_repository.dart';

final postProvider = StateNotifierProvider<PostNotifier, List<Post>>((ref) {
  final repository = ref.watch(postRepositoryProvider);
  return PostNotifier(repository);
});

class PostNotifier extends StateNotifier<List<Post>> {
  final PostRepository _repository;

  PostNotifier(this._repository) : super([]) {
    fetchPosts(); // 初期化時に投稿リストを取得
  }

  // 投稿を全件取得
  Future<void> fetchPosts() async {
    final posts = await _repository.getAllPosts();
    state = posts;
  }

   // 選択された日付に基づいて投稿を取得
  Future<void> fetchPostsForDay(DateTime selectedDay) async {
    final posts = await _repository.getPostsForDay(selectedDay);
    state = posts;
  }

  // 投稿を追加
  Future<void> addPost(CreatePost newPost) async {
    await _repository.addPost(newPost);
    fetchPosts(); // リストを再取得
  }

  // 投稿を更新
  Future<void> updatePost(int localId, UpdatePost updatedData) async {
    await _repository.updatePost(localId, updatedData);
    fetchPosts(); // 更新後に再取得
  }

  // 投稿を削除
  Future<void> deletePost(int localId) async {
    await _repository.deletePost(localId);
    fetchPosts(); // 削除後に再取得
  }
}