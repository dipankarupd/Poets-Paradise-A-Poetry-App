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

// create a response for the comment
class CommentResponse {
  final String id;
  final String content;

  final String poetry;
  final DateTime createdAt;
  final List<String> likes;
  final String authorId;
  final String authorName;
  final String authorDp;

  CommentResponse({
    required this.id,
    required this.content,
    required this.poetry,
    required this.createdAt,
    required this.likes,
    required this.authorId,
    required this.authorName,
    required this.authorDp,
  });
}
