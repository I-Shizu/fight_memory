import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Models/post_model.dart';
import '../Repository/post_repository.dart';

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