import 'package:poets_paradise/cores/models/profile_model.dart';
import 'package:poets_paradise/features/poetry/domain/entity/poetry.dart';

class PoetryModel extends Poetry {
  PoetryModel({
    required super.id,
    required super.title,
    required super.content,
    required super.image,
    required super.categories,
    required ProfileModel super.author,
    required super.likes,
    required super.comments,
    required super.created_at,
  });

  PoetryModel copyWith({
    String? id,
    String? title,
    String? content,
    String? image,
    List<String>? categories,
    ProfileModel? author,
    List<String>? likes,
    List<String>? comments,
    DateTime? created_at,
  }) {
    return PoetryModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      image: image ?? this.image,
      categories: categories ?? this.categories,
      author: author ?? this.author as ProfileModel,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      created_at: created_at ?? this.created_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'image': image,
      'categories': categories,
      'author': (author as ProfileModel).toMap(),
      'likes': likes,
      'comments': comments,
      'created_at': created_at.millisecondsSinceEpoch,
    };
  }

  factory PoetryModel.fromMap(Map<String, dynamic> map) {
    return PoetryModel(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      image: map['image'] as String,
      categories: List<String>.from((map['categories'] as List<dynamic>)),
      author: ProfileModel.fromMap(map['author'] as Map<String, dynamic>),
      likes: List<String>.from((map['likes'] as List<dynamic>)),
      comments: List<String>.from((map['comments'] as List<dynamic>)),
      created_at: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
    );
  }
}
