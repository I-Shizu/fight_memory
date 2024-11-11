import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
@JsonSerializable()
class Post with _$Post {
  const factory Post({
    int? localId, // 自動インクリメントのIDとして使う
    required String text,
    required DateTime date,
    String? imageUrl,
  }) = _Post;

  // SQLiteからデータを取得するためのファクトリコンストラクタ
  factory Post.fromSQLite(Map<String, dynamic> data) {
    return Post(
      localId: data['localId'] as int?,
      text: data['text'] as String,
      date: DateTime.parse(data['date'] as String),
      imageUrl: data['imageUrl'] as String?,
    );
  }

  // SQLiteにデータを保存するためのメソッド
  Map<String, dynamic> toSQLite() {
    return {
      'localId': localId,
      'text': text,
      'date': date.toIso8601String(),
      'imageUrl': imageUrl,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}