import 'package:fpdart/fpdart.dart';
import 'package:poets_paradise/cores/usecases/use_case.dart';
import 'package:poets_paradise/cores/utils/failure.dart';
import 'package:poets_paradise/features/poetry/domain/entity/comments.dart';
import 'package:poets_paradise/features/poetry/domain/repository/poetry_repo.dart';

class UploadComment implements Usecase<Comments, UploadCommentParams> {
  final PoetryRepo repo;

  UploadComment({required this.repo});

  @override
  Future<Either<Failure, Comments>> call(UploadCommentParams params) async {
    return await repo.uploadComment(
      params.content,
      params.author,
      params.poetry,
      params.createdAt,
    );
  }
}

class UploadCommentParams {
  final String content;
  final String author;
  final String poetry;
  final DateTime createdAt;

  UploadCommentParams({
    required this.content,
    required this.author,
    required this.poetry,
    required this.createdAt,
  });
}
