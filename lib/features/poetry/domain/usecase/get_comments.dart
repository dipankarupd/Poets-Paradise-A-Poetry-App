import 'package:fpdart/fpdart.dart';
import 'package:poets_paradise/cores/usecases/use_case.dart';
import 'package:poets_paradise/cores/utils/failure.dart';
import 'package:poets_paradise/features/poetry/domain/entity/comments.dart';
import 'package:poets_paradise/features/poetry/domain/repository/poetry_repo.dart';

class GetComments implements Usecase<List<CommentResponse>, GetCommentsParams> {
  final PoetryRepo repo;

  GetComments({required this.repo});
  @override
  Future<Either<Failure, List<CommentResponse>>> call(
      GetCommentsParams params) async {
    return repo.getComments(params.poetryId);
  }
}

class GetCommentsParams {
  final String poetryId;

  GetCommentsParams({required this.poetryId});
}
