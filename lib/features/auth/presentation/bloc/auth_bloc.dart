import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:poets_paradise/features/auth/domain/usecase/signin.dart';
import 'package:poets_paradise/features/auth/domain/usecase/signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUp _signUpUsecase;
  final Signin _signinUsecase;
  AuthBloc(
    this._signUpUsecase,
    this._signinUsecase,
  ) : super(AuthInitial()) {
    on<AuthEvent>(authEvent);
    on<SignupButtonPressedEvent>(signupButtonPressedEvent);
    on<SigninButtonPressedEvent>(signinButtonPressedEvent);
  }

  FutureOr<void> authEvent(AuthEvent event, Emitter<AuthState> emit) {
    emit(AuthLoading());
  }

  FutureOr<void> signupButtonPressedEvent(
      SignupButtonPressedEvent event, Emitter<AuthState> emit) async {
    final res = await _signUpUsecase(
      SignUpParams(
        username: event.username,
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (l) => emit(AuthError(message: l.message)),
      (r) => emit(AuthSuccess()),
    );
  }

  FutureOr<void> signinButtonPressedEvent(
      SigninButtonPressedEvent event, Emitter<AuthState> emit) async {
    final res = await _signinUsecase(
      SigninParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (l) => emit(AuthError(message: l.message)),
      (r) {
        print(r.toString());
        emit(AuthSuccess());
      },
    );
  }
}
