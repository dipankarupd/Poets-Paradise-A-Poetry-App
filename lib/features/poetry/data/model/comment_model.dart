import 'package:poets_paradise/features/poetry/domain/entity/comments.dart';

class CommentsModel extends Comments {
  CommentsModel({
    required super.id,
    required super.content,
    required super.author,
    required super.poetry,
    required super.createdAt,
    required super.likes,
  });

  CommentsModel copyWith({
    String? id,
    String? content,
    String? author,
    String? poetry,
    DateTime? createdAt,
    List<String>? likes,
  }) {
    return CommentsModel(
      id: id ?? this.id,
      content: content ?? this.content,
      author: author ?? this.author,
      poetry: poetry ?? this.poetry,
      createdAt: createdAt ?? this.createdAt,
      likes: likes ?? this.likes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'author': author,
      'poetry': poetry,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'likes': likes,
    };
  }

  factory CommentsModel.fromMap(Map<String, dynamic> map) {
    return CommentsModel(
      id: map['id'] as String,
      content: map['content'] as String,
      author: map['author'] as String,
      poetry: map['poetry'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      likes: List<String>.from((map['likes'] as List<dynamic>)),
    );
  }
}

// create a response model for comment
class CommentResponseModel extends CommentResponse {
  CommentResponseModel({
    required super.id,
    required super.content,
    required super.poetry,
    required super.createdAt,
    required super.likes,
    required super.authorId,
    required super.authorName,
    required super.authorDp,
  });

  CommentResponseModel copyWith({
    String? id,
    String? content,
    String? poetry,
    DateTime? createdAt,
    List<String>? likes,
    String? authorId,
    String? authorName,
    String? authorDp,
  }) {
    return CommentResponseModel(
      id: id ?? this.id,
      content: content ?? this.content,
      poetry: poetry ?? this.poetry,
      createdAt: createdAt ?? this.createdAt,
      likes: likes ?? this.likes,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      authorDp: authorDp ?? this.authorDp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'poetry': poetry,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'likes': likes,
      'author_id': authorId,
      'author_name': authorName,
      'author_dp': authorDp,
    };
  }

  factory CommentResponseModel.fromMap(Map<String, dynamic> map) {
    return CommentResponseModel(
      id: map['id'] as String,
      content: map['content'] as String,
      poetry: map['poetry'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      likes: List<String>.from((map['likes'] as List<String>)),
      authorId: map['author_id'] as String,
      authorName: map['author_name'] as String,
      authorDp: map['author_dp'] as String,
    );
  }
}
