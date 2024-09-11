import 'package:fpdart/fpdart.dart';
import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/cores/usecases/use_case.dart';
import 'package:poets_paradise/cores/utils/failure.dart';
import 'package:poets_paradise/features/poetry/domain/repository/poetry_repo.dart';

class ToggleFollow implements Usecase<void, ToggleFollowParama> {
  final PoetryRepo repo;

  ToggleFollow({required this.repo});

  @override
  Future<Either<Failure, Profile>> call(params) async {
    return await repo.toggleFollower(params.follower, params.following);
  }
}

class ToggleFollowParama {
  final String follower;
  final String following;

  ToggleFollowParama({required this.follower, required this.following});
}
