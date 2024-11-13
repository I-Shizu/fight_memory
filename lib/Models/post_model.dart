import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Post {
  final int? localId;
  final String text;
  final DateTime date;
  final File? imageFile;

  Post( {
    this.localId,
    required this.text,
    required this.date,
    this.imageFile,
  });

  // SQLite用のMap形式に変換するメソッド
  Map<String, dynamic> toSQLite() {
    return {
      'text': text,
      'date': date.toIso8601String(),
      'imageUrl': imageFile,
    };
  }

  factory Post.fromSQLite(Map<String, dynamic> data) {
    return Post(
      text: data['text'] as String,
      date: DateTime.parse(data['date'] as String),
      imageFile: data['imageFile'] as File?,
    );
  }
}