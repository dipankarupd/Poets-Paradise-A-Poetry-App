import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/cores/usecases/use_case.dart';
import 'package:poets_paradise/features/auth/domain/usecase/current_user.dart';
import 'package:poets_paradise/features/auth/domain/usecase/signout.dart';
import 'package:poets_paradise/features/poetry/domain/entity/poetry.dart';
import 'package:poets_paradise/features/poetry/domain/usecase/update_profile.dart';
import 'package:poets_paradise/features/poetry/domain/usecase/upload_poetry.dart';

part 'poetry_event.dart';
part 'poetry_state.dart';

class PoetryBloc extends Bloc<PoetryEvent, PoetryState> {
  final CurrentUser _currentUser;
  final SignOut _signOut;
  final UpdateProfile _updateProfile;
  final UploadPoetry _poetry;
  PoetryBloc(
    this._currentUser,
    this._updateProfile,
    this._signOut,
    this._poetry,
  ) : super(PoetryInitial()) {
    on<PoetryInitialEvent>(poetryInitialEvent);

    on<ProfileSignoutEvent>(profileSignoutEvent);
    on<PoetryHomeProfileButtonPressedEvent>(
        poetryHomeProfileButtonPressedEvent);

    on<PoetryProfileEditButtonPressedEvent>(
        poetryProfileEditButtonPressedEvent);

    on<PoetryEditProfileEvent>(poetryEditProfileEvent);
    on<PoetryUploadPoemEvent>(poetryUploadPoemEvent);
  }

  FutureOr<void> poetryInitialEvent(
    PoetryInitialEvent event,
    Emitter<PoetryState> emit,
  ) async {
    emit(PoetryInitialLoadingState());
    final res = await _currentUser.call(NoParams());

    res.fold(
      (l) => emit(PoetryFailedState(message: l.message)),
      (r) => emit(PoetryInitialState(profile: r)),
    );
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
}
