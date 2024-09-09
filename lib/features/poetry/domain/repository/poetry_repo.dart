import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/cores/utils/failure.dart';
import 'package:poets_paradise/features/poetry/domain/entity/poetry.dart';

abstract interface class PoetryRepo {
  Future<Either<Failure, Profile>> updateUserProfile(
    final File? avatar,
    final String username,
    final String bio,
  );

  Future<Either<Failure, Poetry>> uploadPoetry(
    final File image,
    final Profile author,
    final String title,
    final String content,
    final List<String> categories,
    final List<String> likes,
    final List<String> comments,
    final DateTime createdAt,
  );

  Future<Either<Failure, List<Poetry>>> getAllPoetry();

  Future<Either<Failure, List<Profile>>> getAllProfiles();

  Future<Either<Failure, Unit>> addToSaved(Poetry poetry);
}
