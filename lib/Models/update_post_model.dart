class UpdatePost {
  final String? text;
  final String? imageUrl;
  final DateTime? date;

  const UpdatePost({
    this.text,
    this.imageUrl,
    this.date,
  });

  // SQLite用のデータ形式
  Map<String, dynamic> toSQLite() {
    return {
      if (text != null) 'text': text,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (date != null) 'date': date!.toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    };
  }
}