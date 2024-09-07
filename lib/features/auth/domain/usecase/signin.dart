import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:poets_paradise/cores/usecases/use_case.dart';
import 'package:poets_paradise/cores/utils/failure.dart';
import 'package:poets_paradise/features/auth/domain/repository/auth_repo.dart';

class Signin implements Usecase<UserCredential, SigninParams> {
  final AuthRepo repo;

  Signin({required this.repo});
  @override
  Future<Either<Failure, UserCredential>> call(SigninParams params) async {
    return await repo.signin(
      email: params.email,
      password: params.password,
    );
  }
}

class SigninParams {
  final String email;
  final String password;

  SigninParams({required this.email, required this.password});
}
