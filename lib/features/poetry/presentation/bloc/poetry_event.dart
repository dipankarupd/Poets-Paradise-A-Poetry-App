part of 'poetry_bloc.dart';

sealed class PoetryEvent {}

class ProfileSignoutEvent extends PoetryEvent {}

class PoetryInitialEvent extends PoetryEvent {}

class PoetryHomeProfileButtonPressedEvent extends PoetryEvent {}

class PoetryProfileEditButtonPressedEvent extends PoetryEvent {}

class PoetryEditProfileEvent extends PoetryEvent {
  final File? avatar;

  final String username;
  final String bio;

  PoetryEditProfileEvent({
    required this.avatar,
    required this.username,
    required this.bio,
  });
}

class PoetryUploadPoemEvent extends PoetryEvent {
  final File image;
  final Profile author;
  final String title;
  final String content;
  final List<String> categories;
  final List<String> likes;
  final List<String> comments;
  final DateTime createdAt;

  PoetryUploadPoemEvent({
    required this.image,
    required this.author,
    required this.title,
    required this.content,
    required this.categories,
    required this.likes,
    required this.comments,
    required this.createdAt,
  });
}

class PoetrySaveButtonPressEvent extends PoetryEvent {
  final Poetry poetry;

  PoetrySaveButtonPressEvent({required this.poetry});
}

class AddCommentEvent extends PoetryEvent {
  final Profile author;
  final Poetry poetry;
  final DateTime createdAt;
  final String content;
  final List<String> likes;

  AddCommentEvent({
    required this.author,
    required this.poetry,
    required this.createdAt,
    required this.content,
    required this.likes,
  });
}
