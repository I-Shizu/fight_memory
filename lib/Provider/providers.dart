import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Repository/post_repository.dart';

final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepository();
});

final selectedDayProvider = StateProvider<DateTime?>((ref){ 
  return DateTime.now();
});