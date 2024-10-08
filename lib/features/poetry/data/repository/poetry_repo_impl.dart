import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/cores/exceptions/server_exception.dart';
import 'package:poets_paradise/cores/models/profile_model.dart';
import 'package:poets_paradise/cores/utils/failure.dart';
import 'package:poets_paradise/features/poetry/data/model/comment_model.dart';
import 'package:poets_paradise/features/poetry/data/model/like_model.dart';
import 'package:poets_paradise/features/poetry/data/model/poetry_model.dart';
import 'package:poets_paradise/features/poetry/data/source/poetry_remote.dart';
import 'package:poets_paradise/features/poetry/domain/entity/comments.dart';
import 'package:poets_paradise/features/poetry/domain/entity/poetry.dart';
import 'package:poets_paradise/features/poetry/domain/repository/poetry_repo.dart';

class PoetryRepoImpl implements PoetryRepo {
  final PoetryRemoteSource source;

  PoetryRepoImpl({required this.source});
  @override
  Future<Either<Failure, Profile>> updateUserProfile(
    File? avatar,
    String username,
    String bio,
  ) async {
    try {
      final profile = await source.updateUserProfile(avatar, username, bio);
      return right(profile);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Poetry>> uploadPoetry(
      File image,
      Profile author,
      String title,
      String content,
      List<String> categories,
      List<String> likes,
      List<String> comments,
      DateTime createdAt) async {
    try {
      PoetryModel model = PoetryModel(
        id: '',
        title: title,
        content: content,
        image: '',
        categories: categories,
        author: author as ProfileModel,
        likes: likes,
        comments: comments,
        created_at: createdAt,
      );

      final poetryimage = await source.uploadPoetryImage(image);
      model = model.copyWith(image: poetryimage);

      await source.uploadPoetry(model);
      return right(model);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Poetry>>> getAllPoetry() async {
    try {
      final res = await source.getAllPoetries();
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Profile>>> getAllProfiles() async {
    try {
      final res = await source.getAllProfiles();
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> addToSaved(Poetry poetry) async {
    try {
      PoetryModel poem = PoetryModel(
        id: poetry.id,
        title: poetry.title,
        content: poetry.content,
        image: poetry.image,
        categories: poetry.categories,
        author: poetry.author as ProfileModel,
        likes: poetry.likes,
        comments: poetry.comments,
        created_at: poetry.created_at,
      );
      await source.addToSaved(poem);
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Comments>> uploadComment(
    String content,
    String author,
    String poetry,
    DateTime createdAt,
  ) async {
    try {
      CommentsModel comment = CommentsModel(
        id: '',
        content: content,
        author: author,
        poetry: poetry,
        createdAt: createdAt,
        likes: [],
      );

      final res = await source.uploadComment(comment);
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<CommentResponse>>> getComments(
      String poetryId) async {
    try {
      final res = await source.getComments(poetryId);
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> toggleLike(
      String author, String? poetry, String? comment) async {
    try {
      LikesModel like = LikesModel(
        id: '',
        user: author,
        createdAt: DateTime.now(),
        poetry: poetry,
        comment: comment,
      );

      await source.updateLike(like);
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> toggleFollower(
      String followerId, String followingId) async {
    try {
      final res = await source.toggleFollower(followerId, followingId);
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
