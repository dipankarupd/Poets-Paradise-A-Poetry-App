import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:poets_paradise/features/poetry/domain/entity/poetry.dart';
import 'package:poets_paradise/features/poetry/presentation/widget/popular_poetry_card.dart';

class AllLatestList extends StatelessWidget {
  final List<Poetry> poetries;
  const AllLatestList({super.key, required this.poetries});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              PersistentNavBarNavigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Poetries'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: poetries.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                  height: 140,
                  child: PopularPoetryCard(poetry: poetries[index])),
            );
          },
        ),
      ),
    );
  }
}
