import 'package:fpdart/fpdart.dart';
import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/cores/usecases/use_case.dart';
import 'package:poets_paradise/cores/utils/failure.dart';
import 'package:poets_paradise/features/auth/domain/repository/auth_repo.dart';

class CurrentUser implements Usecase<Profile, NoParams> {
  final AuthRepo repo;

  CurrentUser({required this.repo});
  @override
  Future<Either<Failure, Profile>> call(NoParams params) {
    return repo.getCurrentUser();
  }
}
