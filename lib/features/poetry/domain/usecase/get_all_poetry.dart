// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fpdart/src/either.dart';

import 'package:poets_paradise/cores/usecases/use_case.dart';
import 'package:poets_paradise/cores/utils/failure.dart';
import 'package:poets_paradise/features/poetry/domain/entity/poetry.dart';
import 'package:poets_paradise/features/poetry/domain/repository/poetry_repo.dart';

class GetAllPoetry implements Usecase<List<Poetry>, NoParams> {
  PoetryRepo repo;
  GetAllPoetry({
    required this.repo,
  });
  @override
  Future<Either<Failure, List<Poetry>>> call(NoParams params) async {
    return await repo.getAllPoetry();
  }
}
