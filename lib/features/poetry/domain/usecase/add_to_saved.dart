import 'package:fpdart/src/either.dart';
import 'package:poets_paradise/cores/usecases/use_case.dart';
import 'package:poets_paradise/cores/utils/failure.dart';
import 'package:poets_paradise/features/poetry/domain/entity/poetry.dart';
import 'package:poets_paradise/features/poetry/domain/repository/poetry_repo.dart';

class UpdateSaved implements Usecase<void, Poetry> {
  final PoetryRepo repo;

  UpdateSaved({required this.repo});

  @override
  Future<Either<Failure, void>> call(Poetry params) async {
    return await repo.addToSaved(params);
  }
}
