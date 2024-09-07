import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/cores/utils/failure.dart';

abstract interface class AuthRepo {
  Future<Either<Failure, UserCredential>> signup({
    required String username,
    required String email,
    required String password,
  });
  Future<Either<Failure, UserCredential>> signin({
    required String email,
    required String password,
  });

  Future<Either<Failure, Profile>> getCurrentUser();
  Future<Either<Failure, Unit>> signOutUser();
}
