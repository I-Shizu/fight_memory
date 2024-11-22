import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_model.freezed.dart';

@freezed
class Post with _$Post {
  const factory Post({
    int? localId,
    required String text,
    required DateTime date,
    String? imageFile,
  }) = _Post;
}