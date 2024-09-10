import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:poets_paradise/features/auth/data/repository/auth_repo_impl.dart';
import 'package:poets_paradise/features/auth/data/source/remote_source.dart';
import 'package:poets_paradise/features/auth/data/source/remote_source_impl.dart';
import 'package:poets_paradise/features/auth/domain/repository/auth_repo.dart';
import 'package:poets_paradise/features/auth/domain/usecase/current_user.dart';
import 'package:poets_paradise/features/auth/domain/usecase/signin.dart';
import 'package:poets_paradise/features/auth/domain/usecase/signout.dart';
import 'package:poets_paradise/features/auth/domain/usecase/signup.dart';
import 'package:poets_paradise/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:poets_paradise/features/poetry/data/repository/poetry_repo_impl.dart';
import 'package:poets_paradise/features/poetry/data/source/poetry_remote.dart';
import 'package:poets_paradise/features/poetry/data/source/poetry_remote_impl.dart';
import 'package:poets_paradise/features/poetry/domain/repository/poetry_repo.dart';
import 'package:poets_paradise/features/poetry/domain/usecase/add_to_saved.dart';
import 'package:poets_paradise/features/poetry/domain/usecase/get_all_poetry.dart';
import 'package:poets_paradise/features/poetry/domain/usecase/get_all_profiles.dart';
import 'package:poets_paradise/features/poetry/domain/usecase/get_comments.dart';
import 'package:poets_paradise/features/poetry/domain/usecase/update_like.dart';
import 'package:poets_paradise/features/poetry/domain/usecase/update_profile.dart';
import 'package:poets_paradise/features/poetry/domain/usecase/upload_comment.dart';
import 'package:poets_paradise/features/poetry/domain/usecase/upload_poetry.dart';
import 'package:poets_paradise/features/poetry/presentation/bloc/poetry_bloc.dart';
import 'package:poets_paradise/firebase_options.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependancies() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  _initAuth();
  _initPoetry();
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteSource>(
      () => AuthRemoteSourceImpl(),
    )
    ..registerFactory<AuthRepo>(
      () => AuthRepoImpl(source: serviceLocator()),
    )
    ..registerFactory<SignUp>(
      () => SignUp(repo: serviceLocator()),
    )
    ..registerFactory<Signin>(
      () => Signin(repo: serviceLocator()),
    )
    ..registerFactory<CurrentUser>(
      () => CurrentUser(repo: serviceLocator()),
    )
    ..registerFactory(() => SignOut(repo: serviceLocator()))
    ..registerLazySingleton(
      () => AuthBloc(serviceLocator(), serviceLocator()),
    );
}

void _initPoetry() {
  serviceLocator
    ..registerFactory<PoetryRemoteSource>(() => PoetryRemoteImpl())
    ..registerFactory<PoetryRepo>(
      () => PoetryRepoImpl(source: serviceLocator()),
    )
    ..registerFactory<UploadPoetry>(
      () => UploadPoetry(repo: serviceLocator()),
    )
    ..registerFactory<UpdateProfile>(
      () => UpdateProfile(repo: serviceLocator()),
    )
    ..registerFactory<GetAllPoetry>(
      () => GetAllPoetry(repo: serviceLocator()),
    )
    ..registerFactory<GetAllProfiles>(
      () => GetAllProfiles(repo: serviceLocator()),
    )
    ..registerFactory<UpdateSaved>(
      () => UpdateSaved(repo: serviceLocator()),
    )
    ..registerFactory<UploadComment>(
      () => UploadComment(repo: serviceLocator()),
    )
    ..registerFactory<GetComments>(
      () => GetComments(repo: serviceLocator()),
    )
    ..registerFactory(
      () => UpdateLike(repo: serviceLocator()),
    )
    ..registerLazySingleton<PoetryBloc>(
      () => PoetryBloc(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );
}
