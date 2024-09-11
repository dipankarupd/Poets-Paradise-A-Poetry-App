import 'package:poets_paradise/features/poetry/domain/entity/poetry.dart';

class Profile {
  final String userId;
  final String username;
  final String dp;
  final String bio;
  final String email;
  final List<String> followers;
  final List<String> following;
  final List<Poetry> poetries;
  final List<Poetry> savedPoetries;

  Profile({
    required this.userId,
    required this.username,
    required this.dp,
    required this.bio,
    required this.email,
    required this.followers,
    required this.following,
    required this.poetries,
    required this.savedPoetries,
  });
}
