import 'package:fpdart/fpdart.dart';
import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/cores/usecases/use_case.dart';
import 'package:poets_paradise/cores/utils/failure.dart';
import 'package:poets_paradise/features/poetry/domain/repository/poetry_repo.dart';

class GetAllProfiles implements Usecase<List<Profile>, NoParams> {
  final PoetryRepo repo;

  GetAllProfiles({required this.repo});
  @override
  Future<Either<Failure, List<Profile>>> call(NoParams params) async {
    return await repo.getAllProfiles();
  }
}
