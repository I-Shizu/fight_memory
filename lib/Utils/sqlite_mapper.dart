import '../Data/Models/post_model.dart';

class SQLiteMapper {
  static Map<String, dynamic> toSQLite(Post post) {
    final map = {
      'text': post.text,
      'date': post.date.toIso8601String(),
      'imageFile': post.imageFile,
    };

    if(post.localId != null){
      map['localId'] = post.localId as String?;
    }

    return map;
  }

  static Post fromSQLite(Map<String, dynamic> data) {
    return Post(
      localId: data['localId'] as int?,
      text: data['text'] as String,
      date: DateTime.parse(data['date'] as String),
      imageFile: data['imageFile'] as String?, 
    );
  }
}