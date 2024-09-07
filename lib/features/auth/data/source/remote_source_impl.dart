import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poets_paradise/cores/exceptions/server_exception.dart';
import 'package:poets_paradise/cores/models/profile_model.dart';
import 'package:poets_paradise/features/auth/data/source/remote_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteSourceImpl implements AuthRemoteSource {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<UserCredential> signupUser({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _addUserToDatabase(
        email,
        username,
        userCredential.user!.uid,
      );

      return userCredential;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<void> _addUserToDatabase(
    String email,
    String username,
    String userId,
  ) async {
    try {
      CollectionReference ref = firebaseFirestore.collection('users');

      final user = ProfileModel(
        userId: userId,
        username: username,
        dp: '',
        bio: '',
        email: email,
        followers: [],
        following: [],
        poetries: [],
      );

      await ref.doc(userId).set(user.toMap());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserCredential> signinUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ProfileModel?> getCurrentUser() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        String userId = user.uid;
        final ref =
            await firebaseFirestore.collection('users').doc(userId).get();
        if (!ref.exists) {
          throw ServerException(message: 'No such user exit');
        }
        return ProfileModel.fromMap(ref.data()!);
      }
      return null;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> signOutUser() async {
    try {
      await auth.signOut();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
