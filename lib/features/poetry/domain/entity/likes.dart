class Likes {
  final String id;
  final String user;
  final String? poetry;
  final String? comment;
  final DateTime createdAt;

  Likes({
    required this.id,
    required this.user,
    this.poetry,
    this.comment,
    required this.createdAt,
  });
}
