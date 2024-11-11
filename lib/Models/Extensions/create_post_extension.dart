import '../../Models/create_post_model.dart';

extension CreatePostExtensions on CreatePost {
  Map<String, dynamic> toSQLite() {
    return {
      'text': text,
      'date': date.toIso8601String(),
      'imageUrl': imageUrl,
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    };
  }
}