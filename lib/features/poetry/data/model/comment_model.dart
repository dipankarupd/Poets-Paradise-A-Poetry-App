import 'package:poets_paradise/cores/models/profile_model.dart';
import 'package:poets_paradise/features/poetry/data/model/poetry_model.dart';
import 'package:poets_paradise/features/poetry/domain/entity/comments.dart';

class CommentsModel extends Comments {
  CommentsModel({
    required super.id,
    required super.content,
    required ProfileModel author,
    required PoetryModel poem,
    required super.likes,
    required super.createdAt,
  }) : super(author: author, poem: poem);

  CommentsModel copyWith({
    String? id,
    String? content,
    ProfileModel? author,
    PoetryModel? poem,
    List<String>? likes,
    DateTime? createdAt,
  }) {
    return CommentsModel(
      id: id ?? this.id,
      content: content ?? this.content,
      author: author ?? this.author as ProfileModel,
      poem: poem ?? this.poem as PoetryModel,
      likes: likes ?? this.likes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'author': (author as ProfileModel).toMap(),
      'poem': (poem as PoetryModel).toMap(),
      'likes': likes,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  factory CommentsModel.fromMap(Map<String, dynamic> map) {
    return CommentsModel(
      id: map['id'] as String,
      content: map['content'] as String,
      author: ProfileModel.fromMap(map['author'] as Map<String, dynamic>),
      poem: PoetryModel.fromMap(map['poem'] as Map<String, dynamic>),
      likes: List<String>.from((map['likes'] as List<String>)),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
    );
  }
}
