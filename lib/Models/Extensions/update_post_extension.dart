import '../../Models/update_post_model.dart';

extension UpdatePostExtensions on UpdatePost {
  Map<String, dynamic> toSQLite() {
    return {
      if (text != null) 'text': text,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (date != null) 'date': date!.toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    };
  }
}