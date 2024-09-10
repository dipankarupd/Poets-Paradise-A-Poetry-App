// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'poetry_bloc.dart';

sealed class PoetryState {}

class ProfileSignoutSuccessState extends PoetryState {}

class ProfileSignoutFailureState extends PoetryState {
  final String message;

  ProfileSignoutFailureState({required this.message});
}

final class PoetryInitial extends PoetryState {}

class PoetryInitialState extends PoetryState {
  final Profile profile;
  final List<Poetry> poetries;
  final List<Profile> authors;
  PoetryInitialState({
    required this.profile,
    required this.poetries,
    required this.authors,
  });
}

class PoetryFailedState extends PoetryState {
  final String message;

  PoetryFailedState({required this.message});
}

class PoetryInitialLoadingState extends PoetryState {}

class PoetryHomeNavigateToProfileState extends PoetryState {}

class PoetryProfileNavigteToEditProfileState extends PoetryState {}

class PoetryProfileUpdateState extends PoetryState {
  final Profile profile;

  PoetryProfileUpdateState({required this.profile});
}

class PoetryUploadSuccessState extends PoetryState {
  final Poetry poetry;

  PoetryUploadSuccessState({required this.poetry});
}

class PoetryUploadingState extends PoetryState {}

class PoetrySaveState extends PoetryState {}

class AddCommentSuccessState extends PoetryState {}

class FetchCommentsSuccessState extends PoetryState {
  final List<CommentResponse> comments;

  FetchCommentsSuccessState({required this.comments});
}

class PoetryToggleLikeState extends PoetryState {}
