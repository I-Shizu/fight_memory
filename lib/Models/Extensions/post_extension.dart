import '../../Models/post_model.dart';

extension PostExtensions on Post {
  Map<String, dynamic> toSQLite() {
    return {
      'localId': localId,
      'text': text,
      'date': date.toIso8601String(),
      'imageUrl': imageUrl,
    };
  }
}