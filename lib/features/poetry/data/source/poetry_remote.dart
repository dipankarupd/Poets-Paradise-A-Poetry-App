import 'dart:io';

import 'package:poets_paradise/cores/models/profile_model.dart';
import 'package:poets_paradise/features/poetry/data/model/comment_model.dart';
import 'package:poets_paradise/features/poetry/data/model/like_model.dart';
import 'package:poets_paradise/features/poetry/data/model/poetry_model.dart';

abstract interface class PoetryRemoteSource {
  Future<ProfileModel> updateUserProfile(
    final File? avatar,
    final String username,
    final String bio,
  );

  Future<PoetryModel> uploadPoetry(PoetryModel poetry);

  Future<String> uploadPoetryImage(File image);

  Future<List<PoetryModel>> getAllPoetries();

  Future<List<ProfileModel>> getAllProfiles();

  Future<void> addToSaved(PoetryModel poetry);

  Future<CommentsModel> uploadComment(CommentsModel comment);

  Future<List<CommentResponseModel>> getComments(String poetryId);

  Future<void> updateLike(LikesModel likeModel);
}
