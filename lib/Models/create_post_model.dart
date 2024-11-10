class CreatePost {
  final String text;
  final DateTime date;
  final String? imageUrl;

  const CreatePost({
    required this.text,
    required this.date,
    this.imageUrl,
  });

  // SQLite用のデータ形式
  Map<String, dynamic> toSQLite() {
    return {
      'text': text,
      'date': date.toIso8601String(),
      'imageUrl': imageUrl,
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    };
  }
}