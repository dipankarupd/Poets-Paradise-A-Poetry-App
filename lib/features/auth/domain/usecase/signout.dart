import 'package:fpdart/fpdart.dart';
import 'package:poets_paradise/cores/usecases/use_case.dart';
import 'package:poets_paradise/cores/utils/failure.dart';
import 'package:poets_paradise/features/auth/domain/repository/auth_repo.dart';

class SignOut implements Usecase<void, NoParams> {
  final AuthRepo repo;

  SignOut({required this.repo});
  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repo.signOutUser();
  }
}
