import 'package:fpdart/fpdart.dart';
import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/cores/usecases/use_case.dart';
import 'package:poets_paradise/cores/utils/failure.dart';
import 'package:poets_paradise/features/poetry/domain/entity/comments.dart';
import 'package:poets_paradise/features/poetry/domain/entity/poetry.dart';
import 'package:poets_paradise/features/poetry/domain/repository/poetry_repo.dart';

class UploadComment implements Usecase<Comments, UploadCommentUseCaseParams> {
  final PoetryRepo repo;

  UploadComment({required this.repo});

  @override
  Future<Either<Failure, Comments>> call(
      UploadCommentUseCaseParams params) async {
    return await repo.uploadComment(
      params.author,
      params.poetry,
      params.createdAt,
      params.content,
      params.likes,
    );
  }
}

class UploadCommentUseCaseParams {
  final Profile author;
  final Poetry poetry;
  final DateTime createdAt;
  final String content;
  final List<String> likes;

  UploadCommentUseCaseParams({
    required this.author,
    required this.poetry,
    required this.createdAt,
    required this.content,
    required this.likes,
  });
}
