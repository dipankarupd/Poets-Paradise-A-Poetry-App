import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/features/poetry/presentation/widget/each_author_row.dart';

class AuthorsViewPage extends StatelessWidget {
  final List<Profile> authors;
  const AuthorsViewPage({super.key, required this.authors});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            PersistentNavBarNavigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text('Authors'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: authors.length,
          itemBuilder: (context, index) {
            return EachAuthorRow(author: authors[index]);
          },
        ),
      ),
    );
  }
}
