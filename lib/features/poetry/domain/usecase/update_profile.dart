import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/cores/usecases/use_case.dart';
import 'package:poets_paradise/cores/utils/failure.dart';
import 'package:poets_paradise/features/poetry/domain/repository/poetry_repo.dart';

class UpdateProfile implements Usecase<Profile, UpdateProfileParams> {
  final PoetryRepo repo;

  UpdateProfile({required this.repo});
  @override
  Future<Either<Failure, Profile>> call(UpdateProfileParams params) async {
    return await repo.updateUserProfile(
      params.avatar,
      params.username,
      params.bio,
    );
  }
}

class UpdateProfileParams {
  final File? avatar;
  final String username;
  final String bio;

  UpdateProfileParams({
    required this.avatar,
    required this.username,
    required this.bio,
  });
}
