import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Data/Models/post_model.dart';
import '../Data/Repository/post_repository.dart';

//ビジネスロジックの状態管理をするProvider
//Provider(定数)を管理する
final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepository();
});

final postListProvider = FutureProvider<List<Post>>((ref) async {
  final repository = ref.watch(postRepositoryProvider);
  return await repository.getAllPosts();
});

final postDateProvider = StateProvider<DateTime?>((ref){ 
  return DateTime.now();
});

final localIdProvider = StateProvider<int?>((ref) {
  return null;
});

final currentIndexProvider = StateProvider<int>((ref) => 0);

//imageFileProviderの作成
final postImageFileProvider = StateProvider<File?>((ref) {
  return null;
});