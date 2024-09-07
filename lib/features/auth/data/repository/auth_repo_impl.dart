import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/cores/exceptions/server_exception.dart';
import 'package:poets_paradise/cores/utils/failure.dart';
import 'package:poets_paradise/features/auth/data/source/remote_source.dart';
import 'package:poets_paradise/features/auth/domain/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteSource source;

  AuthRepoImpl({required this.source});

  @override
  Future<Either<Failure, UserCredential>> signup(
      {required String username,
      required String email,
      required String password}) async {
    try {
      UserCredential user = await source.signupUser(
        username: username,
        email: email,
        password: password,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signin(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await source.signinUser(email: email, password: password);
      return right(userCredential);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Profile>> getCurrentUser() async {
    try {
      final profile = await source.getCurrentUser();
      if (profile == null) {
        throw left(Failure(message: 'User not logged in'));
      }
      return right(profile);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> signOutUser() async {
    try {
      await source.signOutUser();
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
