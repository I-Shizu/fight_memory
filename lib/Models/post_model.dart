import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class Post {
  final int? localId;
  final String text;
  final DateTime date;
  final String? imageUrl;

  Post( {
    this.localId,
    required this.text,
    required this.date,
    this.imageUrl,
  });

  // SQLite用のMap形式に変換するメソッド
  Map<String, dynamic> toSQLite() {
    return {
      'text': text,
      'date': date.toIso8601String(),
      'imageUrl': imageUrl,
    };
  }

  // JSONからインスタンスを生成するファクトリメソッド
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  // JSONに変換するメソッド
  Map<String, dynamic> toJson() => _$PostToJson(this);

  factory Post.fromSQLite(Map<String, dynamic> data) {
    return Post(
      text: data['text'] as String,
      date: DateTime.parse(data['date'] as String),
      imageUrl: data['imageUrl'] as String?,
    );
  }
}