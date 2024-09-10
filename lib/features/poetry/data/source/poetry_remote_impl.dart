import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:poets_paradise/cores/exceptions/server_exception.dart';
import 'package:poets_paradise/cores/models/profile_model.dart';
import 'package:poets_paradise/features/poetry/data/model/comment_model.dart';
import 'package:poets_paradise/features/poetry/data/model/poetry_model.dart';
import 'package:poets_paradise/features/poetry/data/source/poetry_remote.dart';

class PoetryRemoteImpl implements PoetryRemoteSource {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<ProfileModel> updateUserProfile(
    File? avatar,
    String username,
    String bio,
  ) async {
    try {
      User? user = auth.currentUser;
      if (user == null) {
        throw ServerException(message: 'No user logged in');
      } else {
        final ref =
            await firebaseFirestore.collection('users').doc(user.uid).get();
        final data = ref.data();
        if (data == null) {
          throw ServerException(message: 'No user data found');
        }
        final userProfile = ProfileModel.fromMap(data);

        String newDp = userProfile.dp;
        if (avatar != null) {
          newDp = await _uploadToFirebaseCloud(avatar);
          if (newDp.isEmpty) {
            throw ServerException(message: 'Error uploading the image');
          }
        }

        final updatedProfile = userProfile.copyWith(
          username: username.isNotEmpty ? username : userProfile.username,
          bio: bio.isNotEmpty ? bio : userProfile.bio,
          dp: newDp,
        );

        await firebaseFirestore
            .collection('users')
            .doc(user.uid)
            .update(updatedProfile.toMap());
        return updatedProfile;
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  _uploadToFirebaseCloud(File avatar) async {
    final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    final reference =
        firebaseStorage.ref().child('user_avatars/${auth.currentUser!.uid}');

    await reference.putFile(avatar);
    return await reference.getDownloadURL();
  }

  @override
  Future<PoetryModel> uploadPoetry(PoetryModel poetry) async {
    try {
      final res =
          await firebaseFirestore.collection('poetries').add(poetry.toMap());
      final updatedPoetry = poetry.copyWith(id: res.id);

      await firebaseFirestore.collection('poetries').doc(res.id).update(
        {'id': res.id},
      );

      _updateProfilePoetryList(updatedPoetry);
      return updatedPoetry;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> uploadPoetryImage(File image) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    final ref = storage.ref().child('poetries/${DateTime.now()}');
    await ref.putFile(image);
    return await ref.getDownloadURL();
  }

  void _updateProfilePoetryList(PoetryModel profile) async {
    final User? user = auth.currentUser;
    if (user == null) {
      throw ServerException(message: 'No user logged in');
    }
    final ref = await firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get();
    final data = ref.data();
    if (data == null) {
      throw ServerException(message: 'error fetching data');
    } else {
      final userProfile = ProfileModel.fromMap(data);
      List<PoetryModel> poetryList = userProfile.poetries as List<PoetryModel>;
      poetryList.add(profile);
      final updatedProfile = userProfile.copyWith(poetries: poetryList);
      await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .update(updatedProfile.toMap());
    }
  }

  @override
  Future<List<PoetryModel>> getAllPoetries() async {
    try {
      // get the snapshot
      QuerySnapshot snapshot =
          await firebaseFirestore.collection('poetries').get();

      // get the data from snapshot
      List<PoetryModel> data = snapshot.docs.map((doc) {
        final res = doc.data() as Map<String, dynamic>;
        return PoetryModel.fromMap(res);
      }).toList();

      return data;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<ProfileModel>> getAllProfiles() async {
    try {
      QuerySnapshot querySnapshot =
          await firebaseFirestore.collection('users').get();
      List<ProfileModel> profiles = querySnapshot.docs.map((e) {
        final res = e.data() as Map<String, dynamic>;
        return ProfileModel.fromMap(res);
      }).toList();

      return profiles;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> addToSaved(PoetryModel poetry) async {
    try {
      User? user = auth.currentUser;
      if (user == null) {
        throw ServerException(message: 'No user logged in');
      }

      final ref =
          await firebaseFirestore.collection('users').doc(user.uid).get();
      final data = ref.data();

      if (data == null) {
        throw ServerException(message: 'No data available');
      }

      ProfileModel profile = ProfileModel.fromMap(data);
      List<PoetryModel> saved = profile.savedPoetries as List<PoetryModel>;
      if (saved.any((p) => p.id == poetry.id)) {
        saved.removeWhere((p) => p.id == poetry.id);
      } else {
        saved.add(poetry);
      }
      final updatedProfile = profile.copyWith(savedPoetries: saved);
      await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .update(updatedProfile.toMap());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<CommentsModel> uploadComment(CommentsModel comment) async {
    try {
      // upload the data to firebase
      final res =
          await firebaseFirestore.collection('comments').add(comment.toMap());

      // update the comment id in the model
      final updatedComment = comment.copyWith(id: res.id);

      // update the id in firebase to be safe
      await firebaseFirestore.collection('comments').doc(res.id).update(
        {'id': res.id},
      );

      // update the comments list in poetry collection
      final poetryDoc = await firebaseFirestore
          .collection('poetries')
          .doc(comment.poetry)
          .get();

      if (poetryDoc.exists) {
        List<String> commentIds =
            List<String>.from(poetryDoc.data()?['comments'] ?? []);

        commentIds.add(updatedComment.id);

        await firebaseFirestore
            .collection('poetries')
            .doc(comment.poetry)
            .update({'comments': commentIds});
      } else {
        throw ServerException(message: 'No such documents exist');
      }

      // return the response
      return updatedComment;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<CommentResponseModel>> getComments(String poetryId) async {
    try {
      // fetch the data of required poetry
      final poetryData =
          await firebaseFirestore.collection('poetries').doc(poetryId).get();
      if (!poetryData.exists) {
        throw ServerException(message: 'No poetry found');
      }

      // get all the comments from the data
      List<String> commentIds = List<String>.from(
        poetryData.data()?['comments'] ?? [],
      );

      List<CommentResponseModel> commentResponses = [];

      // iterate through each comment
      for (String commentId in commentIds) {
        // get the comment doc:
        final commentDoc =
            await firebaseFirestore.collection('comments').doc(commentId).get();

        // check for doc existance
        if (commentDoc.exists) {
          final comment = CommentsModel.fromMap(commentDoc.data()!);

          final authorId = comment.author;

          final authorDoc =
              await firebaseFirestore.collection('users').doc(authorId).get();

          if (authorDoc.exists) {
            final author = ProfileModel.fromMap(authorDoc.data()!);

            // create a response:
            CommentResponseModel commentResponse = CommentResponseModel(
              id: commentId,
              content: comment.content,
              poetry: comment.poetry,
              createdAt: comment.createdAt,
              likes: comment.likes,
              authorId: author.userId,
              authorName: author.username,
              authorDp: author.dp,
            );

            commentResponses.add(commentResponse);
          }
        }
      }

      return commentResponses;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
