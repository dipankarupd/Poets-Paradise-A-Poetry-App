import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/cores/exceptions/server_exception.dart';
import 'package:poets_paradise/cores/models/profile_model.dart';
import 'package:poets_paradise/cores/utils/failure.dart';
import 'package:poets_paradise/features/poetry/data/model/poetry_model.dart';
import 'package:poets_paradise/features/poetry/data/source/poetry_remote.dart';
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
}
