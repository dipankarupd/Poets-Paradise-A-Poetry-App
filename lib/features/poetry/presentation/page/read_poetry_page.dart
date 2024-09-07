import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:poets_paradise/cores/palette/app_palette.dart';
import 'package:poets_paradise/cores/utils/format_time.dart';
import 'package:poets_paradise/features/poetry/domain/entity/poetry.dart';
import 'package:poets_paradise/features/poetry/presentation/widget/poetry_row_icons.dart';

class ReadPoetryPage extends StatelessWidget {
  final Poetry poetry;
  const ReadPoetryPage({super.key, required this.poetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            PersistentNavBarNavigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                poetry.title,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'By ${poetry.author.username}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                    text: 'Created At: ',
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      TextSpan(
                          text: formatTime(poetry.created_at),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image(
                  image: NetworkImage(poetry.image),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RowIcons(
                    unPressedIcon: Icon(CupertinoIcons.heart),
                    label: 'Like',
                    pressedIcon: Icon(
                      CupertinoIcons.heart_fill,
                      color: AppPallete.purpleColor,
                    ),
                  ),
                  RowIcons(
                    unPressedIcon: Icon(Icons.comment_outlined),
                    label: 'Comment',
                    pressedIcon: Icon(
                      Icons.comment,
                      color: AppPallete.purpleColor,
                    ),
                  ),
                  RowIcons(
                    unPressedIcon: Icon(Icons.bookmark_outline),
                    label: 'Save',
                    pressedIcon: Icon(
                      Icons.bookmark,
                      color: AppPallete.purpleColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                poetry.content,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  height: 1.8,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
