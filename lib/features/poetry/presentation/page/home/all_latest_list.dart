import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/features/poetry/domain/entity/poetry.dart';
import 'package:poets_paradise/features/poetry/presentation/widget/popular_poetry_card.dart';

class AllLatestList extends StatelessWidget {
  final Profile profile;
  final List<Poetry> poetries;
  final String? categories;
  const AllLatestList({
    super.key,
    required this.poetries,
    this.categories,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              PersistentNavBarNavigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: categories != null
            ? Text('$categories Poems')
            : const Text('Poetries'),
      ),
      body: poetries.isEmpty
          ? const Center(
              child: Text('No Poems in this category'),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: poetries.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      height: 140,
                      child: PopularPoetryCard(
                        currentUser: profile,
                        poetry: poetries[index],
                        isLiked: false,
                        isSaved: profile.savedPoetries
                            .any((p) => p.id == poetries[index].id),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
