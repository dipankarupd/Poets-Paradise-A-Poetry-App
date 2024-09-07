import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:poets_paradise/cores/usecases/use_case.dart';
import 'package:poets_paradise/cores/utils/failure.dart';
import 'package:poets_paradise/features/auth/domain/repository/auth_repo.dart';

class SignUp implements Usecase<UserCredential, SignUpParams> {
  final AuthRepo repo;

  SignUp({required this.repo});
  @override
  Future<Either<Failure, UserCredential>> call(SignUpParams params) async {
    return await repo.signup(
      username: params.username,
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpParams {
  final String username;
  final String email;
  final String password;

  SignUpParams({
    required this.username,
    required this.email,
    required this.password,
  });
}
