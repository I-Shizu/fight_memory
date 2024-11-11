import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_post_model.freezed.dart';
part 'create_post_model.g.dart';

@freezed
@JsonSerializable()
class CreatePost with _$CreatePost {
  const factory CreatePost({
    required String text,
    required DateTime date,
    String? imageUrl,
  }) = _CreatePost;

  // SQLite用のデータ形式
  //nullを許容しない
  Map<String, dynamic> toSQLite() {
    return {
      'text': text,
      'date': date.toIso8601String(),
      'imageUrl': imageUrl,
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    };
  }

  factory CreatePost.fromJson(Map<String, dynamic> json) => _$CreatePostFromJson(json);
}