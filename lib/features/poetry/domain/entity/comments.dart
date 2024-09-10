class Comments {
  final String id;
  final String content;
  final String author;
  final String poetry;
  final DateTime createdAt;
  final List<String> likes;

  Comments({
    required this.id,
    required this.content,
    required this.author,
    required this.poetry,
    required this.createdAt,
    required this.likes,
  });
}
