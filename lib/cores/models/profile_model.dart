import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/features/poetry/data/model/poetry_model.dart';

class ProfileModel extends Profile {
  ProfileModel({
    required super.userId,
    required super.username,
    required super.dp,
    required super.bio,
    required super.email,
    required List<ProfileModel> followers,
    required List<ProfileModel> following,
    required List<PoetryModel> poetries,
  }) : super(
          followers: followers,
          following: following,
          poetries: poetries,
        );

  ProfileModel copyWith({
    String? userId,
    String? username,
    String? dp,
    String? bio,
    String? email,
    List<ProfileModel>? followers,
    List<ProfileModel>? following,
    List<PoetryModel>? poetries,
  }) {
    return ProfileModel(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      dp: dp ?? this.dp,
      bio: bio ?? this.bio,
      email: email ?? this.email,
      followers: followers ?? this.followers.cast<ProfileModel>(),
      following: following ?? this.following.cast<ProfileModel>(),
      poetries: poetries ?? this.poetries.cast<PoetryModel>(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'username': username,
      'dp': dp,
      'bio': bio,
      'email': email,
      'followers': followers
          .map((follower) => follower is ProfileModel ? (follower).toMap() : {})
          .toList(),
      'following': following
          .map((follow) => follow is ProfileModel ? (follow).toMap() : {})
          .toList(),
      'poetries': poetries
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
      followers: (map['followers'] as List)
          .map((follower) => ProfileModel.fromMap(follower))
          .toList(),
      following: (map['following'] as List)
          .map((follow) => ProfileModel.fromMap(follow))
          .toList(),
      poetries: (map['poetries'] as List)
          .map((poetry) => PoetryModel.fromMap(poetry))
          .toList(),
    );
  }
}
