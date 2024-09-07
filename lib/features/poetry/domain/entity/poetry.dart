import 'package:poets_paradise/cores/entities/profile.dart';

class Poetry {
  final String id;
  final String title;
  final String content;
  final String image;
  final List<String> categories;
  final Profile author;
  final List<String> likes;
  final List<String> comments;
  final DateTime created_at;

  Poetry({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.categories,
    required this.author,
    required this.likes,
    required this.comments,
    required this.created_at,
  });
}
