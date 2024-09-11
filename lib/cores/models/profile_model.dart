import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/features/poetry/data/model/poetry_model.dart';

class ProfileModel extends Profile {
  ProfileModel({
    required super.userId,
    required super.username,
    required super.dp,
    required super.bio,
    required super.email,
    required super.followers,
    required super.following,
    required List<PoetryModel> poetries,
    required List<PoetryModel> savedPoetries,
  }) : super(
          poetries: poetries,
          savedPoetries: savedPoetries,
        );

  ProfileModel copyWith({
    String? userId,
    String? username,
    String? dp,
    String? bio,
    String? email,
    List<String>? followers,
    List<String>? following,
    List<PoetryModel>? poetries,
    List<PoetryModel>? savedPoetries,
  }) {
    return ProfileModel(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      dp: dp ?? this.dp,
      bio: bio ?? this.bio,
      email: email ?? this.email,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      poetries: poetries ?? this.poetries.cast<PoetryModel>(),
      savedPoetries: savedPoetries ?? this.savedPoetries.cast<PoetryModel>(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'username': username,
      'dp': dp,
      'bio': bio,
      'email': email,
      'followers': followers,
      'following': following,
      'poetries': poetries
          .map((poetry) => poetry is PoetryModel ? (poetry).toMap() : {})
          .toList(),
      'saved_poetries': savedPoetries
          .map((poetry) => poetry is PoetryModel ? (poetry).toMap() : {})
          .toList(),
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      userId: map['userId'] as String,
      username: map['username'] as String,
      dp: map['dp'] ?? '',
      bio: map['bio'] ?? '',
      email: map['email'] as String,
      followers: List<String>.from((map['followers'] as List<dynamic>)),
      following: List<String>.from((map['following'] as List<dynamic>)),
      poetries: (map['poetries'] as List)
          .map((poetry) => PoetryModel.fromMap(poetry))
          .toList(),
      savedPoetries: (map['saved_poetries'] as List)
          .map((poetry) => PoetryModel.fromMap(poetry))
          .toList(),
    );
  }
}
