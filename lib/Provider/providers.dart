import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Data/Models/post_model.dart';
import '../Data/Repository/post_repository.dart';

//ビジネスロジックの状態管理をするProvider
//Provider(定数)を管理する
final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepository();
});

//投稿リストの管理
final postListProvider = FutureProvider<List<Post>>((ref) async {
  final repository = ref.watch(postRepositoryProvider);
  return await repository.getAllPosts();
});

//投稿日時の管理
final postDateProvider = StateProvider<DateTime?>((ref){ 
  return DateTime.now();
});

//
final localIdProvider = StateProvider<int?>((ref) {
  return null;
});

//ページの場所を管理
final currentIndexProvider = StateProvider<int>((ref) => 0);

//選択した画像の表示を管理
final postImageFileProvider = StateProvider<File?>((ref) {
  return null;
});

//写真フォルダへのアクセス許可を管理
final permissionGrantedProvider = StateProvider<bool>((ref) => false);