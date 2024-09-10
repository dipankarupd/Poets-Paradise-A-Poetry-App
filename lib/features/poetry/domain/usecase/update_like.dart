import 'package:fpdart/fpdart.dart';
import 'package:poets_paradise/cores/usecases/use_case.dart';
import 'package:poets_paradise/cores/utils/failure.dart';
import 'package:poets_paradise/features/poetry/domain/repository/poetry_repo.dart';

class UpdateLike implements Usecase<void, UpdateLikeParams> {
  final PoetryRepo repo;

  UpdateLike({required this.repo});

  @override
  Future<Either<Failure, void>> call(UpdateLikeParams params) async {
    return await repo.toggleLike(params.author, params.poetry, params.comment);
  }
}

class UpdateLikeParams {
  final String author;
  final String? poetry;
  final String? comment;

  UpdateLikeParams({
    required this.author,
    required this.poetry,
    required this.comment,
  });
}
