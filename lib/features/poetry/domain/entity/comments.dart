// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/features/poetry/domain/entity/poetry.dart';

class Comments {
  final String id;
  final String content;
  final Profile author;
  final Poetry poem;
  final List<String> likes;
  final DateTime createdAt;

  Comments({
    required this.id,
    required this.content,
    required this.author,
    required this.poem,
    required this.likes,
    required this.createdAt,
  });
}
