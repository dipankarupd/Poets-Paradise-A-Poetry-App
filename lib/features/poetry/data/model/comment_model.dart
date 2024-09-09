import 'package:poets_paradise/features/poetry/domain/entity/comments.dart';

class CommentsModel extends Comments {
  CommentsModel({
    required super.id,
    required super.content,
    required super.author,
    required super.poem,
    required super.likes,
    required super.createdAt,
  });

  CommentsModel copyWith({
    String? id,
    String? content,
    String? author,
    String? poem,
    List<String>? likes,
    DateTime? createdAt,
  }) {
    return CommentsModel(
      id: id ?? this.id,
      content: content ?? this.content,
      author: author ?? this.author,
      poem: poem ?? this.poem,
      likes: likes ?? this.likes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'author': author,
      'poem': poem,
      'likes': likes,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  factory CommentsModel.fromMap(Map<String, dynamic> map) {
    return CommentsModel(
      id: map['id'] as String,
      content: map['content'] as String,
      author: map['author'] as String,
      poem: map['poem'] as String,
      likes: List<String>.from((map['likes'] as List<String>)),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
    );
  }
}
