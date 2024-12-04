import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Data/Models/post_model.dart';
import '../../Data/Repository/post_repository.dart';
import '../../Provider/providers.dart';


final postProvider = StateNotifierProvider<PostViewModel, List<Post>>((ref) {
  final repository = ref.watch(postRepositoryProvider);
  return PostViewModel(repository);
});

class PostViewModel extends StateNotifier<List<Post>> {
  final PostRepository repository;

  PostViewModel(this.repository) : super([]) {
    fetchPosts(); // 初期化時に投稿リストを取得
  }

  // 投稿を全件取得
  Future<void> fetchPosts() async {
    final posts = await repository.getAllPosts();
    state = posts;
  }

   // 選択された日付に基づいて投稿を取得
  Future<void> fetchPostsForDay(DateTime selectedDay) async {
    final posts = await repository.getPostsForDay(selectedDay);
    state = posts;
  }

  // 投稿を追加
  Future<void> addPost(String text, File imageFile) async {
    final newPost = Post(
      localId: null,
      text: text,
      date: DateTime.now(),
      imageFile: imageFile.path,
    );

    await repository.addPost(newPost);
    fetchPosts(); 
  }

  // 投稿を更新
  Future<void> updatePost(int localId,Post updatedData) async {
    await repository.updatePost(localId, updatedData);
    fetchPosts(); 
  }

  // 投稿を削除
  Future<void> deletePost(int localId) async {
    await repository.deletePost(localId);
    fetchPosts(); 
  }
}