import '../Data/Models/post_model.dart';

class SQLiteMapper {
  static Map<String, dynamic> toSQLite(Post post) {
    return {
      'text': post.text,
      'date': post.date.toIso8601String(),
      'imageFile': post.imageFile,
    };
  }

  static Post fromSQLite(Map<String, dynamic> data) {
    return Post(
      text: data['text'] as String,
      date: DateTime.parse(data['date'] as String),
      imageFile: data['imageFile'] as String?,
    );
  }
}