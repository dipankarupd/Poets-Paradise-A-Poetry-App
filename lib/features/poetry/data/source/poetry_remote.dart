import 'dart:io';

import 'package:poets_paradise/cores/models/profile_model.dart';
import 'package:poets_paradise/features/poetry/data/model/poetry_model.dart';

abstract interface class PoetryRemoteSource {
  Future<ProfileModel> updateUserProfile(
    final File? avatar,
    final String username,
    final String bio,
  );

  Future<PoetryModel> uploadPoetry(PoetryModel poetry);

  Future<String> uploadPoetryImage(File image);
}
