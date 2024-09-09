import 'package:fpdart/fpdart.dart';
import 'package:poets_paradise/cores/usecases/use_case.dart';
import 'package:poets_paradise/cores/utils/failure.dart';
import 'package:poets_paradise/features/poetry/domain/entity/comments.dart';
import 'package:poets_paradise/features/poetry/domain/entity/poetry.dart';
import 'package:poets_paradise/features/poetry/domain/repository/poetry_repo.dart';

class GetAllComments implements Usecase<List<Comments>, Poetry> {
  final PoetryRepo repo;

  GetAllComments({required this.repo});

  @override
  Future<Either<Failure, List<Comments>>> call(Poetry params) async {
    return await repo.getComments(params);
  }
}
