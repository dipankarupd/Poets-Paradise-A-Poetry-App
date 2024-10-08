import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/cores/usecases/use_case.dart';
import 'package:poets_paradise/features/auth/domain/usecase/current_user.dart';
import 'package:poets_paradise/features/auth/domain/usecase/signout.dart';
import 'package:poets_paradise/features/poetry/domain/entity/comments.dart';
import 'package:poets_paradise/features/poetry/domain/entity/poetry.dart';
import 'package:poets_paradise/features/poetry/domain/usecase/add_to_saved.dart';
import 'package:poets_paradise/features/poetry/domain/usecase/get_all_poetry.dart';
import 'package:poets_paradise/features/poetry/domain/usecase/get_all_profiles.dart';
import 'package:poets_paradise/features/poetry/domain/usecase/get_comments.dart';
import 'package:poets_paradise/features/poetry/domain/usecase/toggle_follow.dart';
import 'package:poets_paradise/features/poetry/domain/usecase/update_like.dart';
import 'package:poets_paradise/features/poetry/domain/usecase/update_profile.dart';
import 'package:poets_paradise/features/poetry/domain/usecase/upload_comment.dart';
import 'package:poets_paradise/features/poetry/domain/usecase/upload_poetry.dart';

part 'poetry_event.dart';
part 'poetry_state.dart';

class PoetryBloc extends Bloc<PoetryEvent, PoetryState> {
  final CurrentUser _currentUser;
  final SignOut _signOut;
  final UpdateProfile _updateProfile;
  final UploadPoetry _poetry;
  final GetAllPoetry _getAllPoetry;
  final GetAllProfiles _getAllProfiles;
  final UpdateSaved _addToSaved;
  final UploadComment _uploadComment;
  final GetComments _getComments;
  final UpdateLike _updateLike;
  final ToggleFollow _toggleFollow;

  PoetryBloc(
    this._currentUser,
    this._updateProfile,
    this._signOut,
    this._poetry,
    this._getAllPoetry,
    this._getAllProfiles,
    this._addToSaved,
    this._uploadComment,
    this._getComments,
    this._updateLike,
    this._toggleFollow,
  ) : super(PoetryInitial()) {
    on<PoetryInitialEvent>(poetryInitialEvent);

    on<ProfileSignoutEvent>(profileSignoutEvent);
    on<PoetryHomeProfileButtonPressedEvent>(
        poetryHomeProfileButtonPressedEvent);

    on<PoetryProfileEditButtonPressedEvent>(
        poetryProfileEditButtonPressedEvent);

    on<PoetryEditProfileEvent>(poetryEditProfileEvent);
    on<PoetryUploadPoemEvent>(poetryUploadPoemEvent);

    on<PoetrySaveButtonPressEvent>(poetrySaveButtonPressEvent);

    on<PoetryCommentUploadEvent>(poetryCommentUploadEvent);
    on<PoetryGetCommentsEvent>(poetryGetCommentsEvent);

    on<PoetryToggleLikeEvent>(poetryToggleLikeEvent);

    on<PoetryToggleFollowEvent>(poetryToggleFollowEvent);
  }

  Future<void> poetryInitialEvent(
    PoetryInitialEvent event,
    Emitter<PoetryState> emit,
  ) async {
    emit(PoetryInitialLoadingState());

    final res = await _currentUser.call(NoParams());

    // Ensure event handler is still active before emitting new state
    if (!emit.isDone) {
      await res.fold(
        (l) async {
          // Ensure event handler is still active before emitting error state
          if (!emit.isDone) {
            emit(PoetryFailedState(message: l.message));
          }
        },
        (profile) async {
          final poetryResult = await _getAllPoetry(NoParams());

          await poetryResult.fold(
            (l) async {
              // Ensure event handler is still active before emitting error state
              if (!emit.isDone) {
                emit(PoetryFailedState(message: l.message));
              }
            },
            (poetries) async {
              // Ensure event handler is still active before emitting success state
              if (!emit.isDone) {
                final profileResult = await _getAllProfiles(NoParams());

                await profileResult.fold(
                  (l) async {
                    if (!emit.isDone) {
                      emit(PoetryFailedState(message: l.message));
                    }
                  },
                  (profiles) async {
                    if (!emit.isDone) {
                      emit(
                        PoetryInitialState(
                          profile: profile,
                          poetries: poetries,
                          authors: profiles,
                        ),
                      );
                    }
                  },
                );
              }
            },
          );
        },
      );
    }
  }

  FutureOr<void> poetryHomeProfileButtonPressedEvent(
      PoetryHomeProfileButtonPressedEvent event, Emitter<PoetryState> emit) {
    emit(PoetryHomeNavigateToProfileState());
  }

  FutureOr<void> poetryProfileEditButtonPressedEvent(
      PoetryProfileEditButtonPressedEvent event, Emitter<PoetryState> emit) {
    emit(PoetryProfileNavigteToEditProfileState());
  }

  FutureOr<void> poetryEditProfileEvent(
      PoetryEditProfileEvent event, Emitter<PoetryState> emit) async {
    final res = await _updateProfile(UpdateProfileParams(
      avatar: event.avatar,
      username: event.username,
      bio: event.bio,
    ));

    res.fold(
      (l) => emit(PoetryFailedState(message: l.message)),
      (r) => emit(PoetryProfileUpdateState(profile: r)),
    );
  }

  FutureOr<void> profileSignoutEvent(
    ProfileSignoutEvent event,
    Emitter<PoetryState> emit,
  ) async {
    final res = await _signOut(NoParams());
    res.fold(
      (l) => emit(ProfileSignoutFailureState(message: l.message)),
      (r) => emit(ProfileSignoutSuccessState()),
    );
  }

  FutureOr<void> poetryUploadPoemEvent(
    PoetryUploadPoemEvent event,
    Emitter<PoetryState> emit,
  ) async {
    emit(PoetryUploadingState());
    final res = await _poetry(
      UploadParams(
        image: event.image,
        author: event.author,
        title: event.title,
        content: event.content,
        categories: event.categories,
        likes: event.likes,
        comments: event.comments,
        createdAt: event.createdAt,
      ),
    );

    res.fold(
      (l) => emit(PoetryFailedState(message: l.message)),
      (r) => emit(PoetryUploadSuccessState(poetry: r)),
    );
  }

  FutureOr<void> poetrySaveButtonPressEvent(
      PoetrySaveButtonPressEvent event, Emitter<PoetryState> emit) async {
    final res = await _addToSaved(event.poetry);

    res.fold(
      (l) => emit(PoetryFailedState(message: l.message)),
      (r) => emit(PoetrySaveState()),
    );

    add(PoetryInitialEvent());
  }

  FutureOr<void> poetryCommentUploadEvent(
    PoetryCommentUploadEvent event,
    Emitter<PoetryState> emit,
  ) async {
    final res = await _uploadComment(
      UploadCommentParams(
        content: event.content,
        author: event.author,
        poetry: event.poetry,
        createdAt: event.createdAt,
      ),
    );

    res.fold(
      (l) => emit(PoetryFailedState(message: l.message)),
      (r) => emit(AddCommentSuccessState()),
    );
  }

  FutureOr<void> poetryGetCommentsEvent(
      PoetryGetCommentsEvent event, Emitter<PoetryState> emit) async {
    final res = await _getComments(
      GetCommentsParams(poetryId: event.poetryId),
    );

    res.fold(
      (l) => emit(PoetryFailedState(message: l.message)),
      (r) => emit(FetchCommentsSuccessState(comments: r)),
    );
  }

  FutureOr<void> poetryToggleLikeEvent(
    PoetryToggleLikeEvent event,
    Emitter<PoetryState> emit,
  ) async {
    final res = await _updateLike(
      UpdateLikeParams(
        author: event.author,
        poetry: event.poetry,
        comment: event.comment,
      ),
    );

    res.fold(
      (l) => emit(PoetryFailedState(message: l.message)),
      (r) => emit(PoetryToggleLikeState()),
    );

    add(PoetryInitialEvent());
  }

  FutureOr<void> poetryToggleFollowEvent(
      PoetryToggleFollowEvent event, Emitter<PoetryState> emit) async {
    //emit(PoetryInitialLoadingState());
    final res = await _toggleFollow(ToggleFollowParama(
        follower: event.follower, following: event.following));

    res.fold(
      (l) => emit(PoetryFailedState(message: l.toString())),
      (r) => emit(PoetryToggleFollowState(updatedUserProfile: r)),
    );
  }
}
