import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_post_model.freezed.dart';
part 'update_post_model.g.dart';

@freezed
class UpdatePost with _$UpdatePost {
  const factory UpdatePost({
    String? text,
    String? imageUrl,
    DateTime? date,
  }) = _UpdatePost;

  // SQLite用のデータ形式
  //部分更新可能
  Map<String, dynamic> toSQLite() {
    return {
      if (text != null) 'text': text,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (date != null) 'date': date!.toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    };
  }
}