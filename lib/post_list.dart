import 'package:fight_app2/Data/Models/post_model.dart';
import 'package:fight_app2/Data/Repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Provider/providers.dart';

//投稿リストプロバイダ(UI管理)
final postListProvider = StateNotifierProvider<PostList, List<Post>>((ref) {
  final repository = ref.watch(postRepositoryProvider);
  return PostList(repository);
});

class PostList extends StateNotifier<List<Post>> {
  //PostRepository型の変数を用意
  final PostRepository repository;

  PostList(this.repository) : super([]);

  List<Post> build() {
    //ビルドメソッド内は初期値を設定
    return [];
  }

  Future<void> fetchPosts() async {
    final posts = await repository.getAllPosts();
    state = posts;
  }

  void fetchPostsForDay(DateTime selectedDay) async {
    final posts = await repository.getPostsForDay(selectedDay);
    state = posts;
  }
  
  Future<void> addPost(Post post) async{
    await repository.addPost(post);
    state = [...state, post];
  }

  void update(List<Post> postList){
    state = postList;
  }

  Future<void> deletePost(int localId) async {
    await repository.deletePost(localId);
    fetchPosts(); 
  }
}