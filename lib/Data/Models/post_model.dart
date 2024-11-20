class Post {
  final int? localId;
  final String text;
  final DateTime date;
  final String? imageFile;

  Post( {
    this.localId,
    required this.text,
    required this.date,
    this.imageFile,
  });
}