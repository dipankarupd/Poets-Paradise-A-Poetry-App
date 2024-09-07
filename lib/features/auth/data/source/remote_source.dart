import 'package:firebase_auth/firebase_auth.dart';
import 'package:poets_paradise/cores/models/profile_model.dart';

abstract interface class AuthRemoteSource {
  Future<UserCredential> signupUser({
    required String username,
    required String email,
    required String password,
  });

  Future<UserCredential> signinUser({
    required String email,
    required String password,
  });

  Future<ProfileModel?> getCurrentUser();

  Future<void> signOutUser();
}
