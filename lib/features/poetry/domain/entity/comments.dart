class Comments {
  final String id;
  final String content;
  final String author;
  final String poem;
  final List<String> likes;
  final DateTime createdAt;

  Comments({
    required this.id,
    required this.content,
    required this.author,
    required this.poem,
    required this.likes,
    required this.createdAt,
  });
}
