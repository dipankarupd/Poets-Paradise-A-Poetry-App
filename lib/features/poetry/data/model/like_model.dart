import 'package:poets_paradise/features/poetry/domain/entity/likes.dart';

class LikesModel extends Likes {
  LikesModel({
    required super.id,
    required super.user,
    required super.createdAt,
    super.poetry,
    super.comment,
  });

  LikesModel copyWith({
    String? id,
    String? user,
    String? poetry,
    String? comment,
    DateTime? createdAt,
  }) {
    return LikesModel(
      id: id ?? this.id,
      user: user ?? this.user,
      poetry: poetry ?? this.poetry,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user,
      'poetry': poetry,
      'comment': comment,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory LikesModel.fromMap(Map<String, dynamic> map) {
    return LikesModel(
      id: map['id'] as String,
      user: map['user'] as String,
      poetry: map['poetry'] != null ? map['poetry'] as String : null,
      comment: map['comment'] != null ? map['comment'] as String : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }
}
