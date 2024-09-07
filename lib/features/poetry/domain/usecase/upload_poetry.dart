import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/cores/usecases/use_case.dart';
import 'package:poets_paradise/cores/utils/failure.dart';
import 'package:poets_paradise/features/poetry/domain/entity/poetry.dart';
import 'package:poets_paradise/features/poetry/domain/repository/poetry_repo.dart';

class UploadPoetry implements Usecase<Poetry, UploadParams> {
  final PoetryRepo repo;

  UploadPoetry({required this.repo});
  @override
  Future<Either<Failure, Poetry>> call(UploadParams params) async {
    return repo.uploadPoetry(
      params.image,
      params.author,
      params.title,
      params.content,
      params.categories,
      params.likes,
      params.comments,
      params.createdAt,
    );
  }
}

class UploadParams {
  final File image;
  final Profile author;
  final String title;
  final String content;
  final List<String> categories;
  final List<String> likes;
  final List<String> comments;
  final DateTime createdAt;

  UploadParams(
      {required this.image,
      required this.author,
      required this.title,
      required this.content,
      required this.categories,
      required this.likes,
      required this.comments,
      required this.createdAt});
}
