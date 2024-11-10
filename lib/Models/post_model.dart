class Post {
  final int? localId; // 自動インクリメントのIDとして使う
  final String text;
  final DateTime date;
  final String? imageUrl;

  Post({
    this.localId,
    required this.text,
    required this.date,
    this.imageUrl,
  });

  // SQLiteからデータを取得するためのファクトリコンストラクタ
  factory Post.fromSQLite(Map<String, dynamic> data) {
    return Post(
      localId: data['localId'],
      text: data['text'],
      date: DateTime.parse(data['date']),
      imageUrl: data['imageUrl'],
    );
  }

  // SQLiteにデータを保存するためのメソッド
  Map<String, dynamic> toSQLite() {
    return {
      'text': text,
      'date': date.toIso8601String(),
      'imageUrl': imageUrl,
    };
  }
}