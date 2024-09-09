// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/features/poetry/domain/entity/poetry.dart';
import 'package:poets_paradise/features/poetry/presentation/page/home/all_latest_list.dart';

class PoetryCategoryCard extends StatelessWidget {
  final Profile profile;
  final List<Poetry> poetries;
  final String category;
  const PoetryCategoryCard({
    super.key,
    required this.category,
    required this.poetries,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 140,
              child: Text(
                '$category poems',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: AllLatestList(
                          poetries: poetries,
                          categories: category,
                          profile: profile,
                        ));
                  },
                  icon: const Icon(CupertinoIcons.arrow_right),
                ),
                Column(
                  children: [
                    const Text('Total Poems'),
                    Text(
                      poetries.length.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
