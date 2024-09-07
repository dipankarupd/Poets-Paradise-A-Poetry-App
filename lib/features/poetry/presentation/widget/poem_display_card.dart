import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:poets_paradise/features/poetry/domain/entity/poetry.dart';
import 'package:poets_paradise/features/poetry/presentation/page/read_poetry_page.dart';

class PoemDisplayCard extends StatelessWidget {
  final Poetry poem;
  const PoemDisplayCard({super.key, required this.poem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: ReadPoetryPage(poetry: poem),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        height: 130,
        width: 130,
        child: Image(
          image: NetworkImage(poem.image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
