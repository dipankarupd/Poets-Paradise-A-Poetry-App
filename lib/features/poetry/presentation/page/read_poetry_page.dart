import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/cores/palette/app_palette.dart';
import 'package:poets_paradise/cores/utils/comment_bottom_sheet.dart';
import 'package:poets_paradise/cores/utils/format_time.dart';
import 'package:poets_paradise/features/poetry/domain/entity/poetry.dart';
import 'package:poets_paradise/features/poetry/presentation/bloc/poetry_bloc.dart';
import 'package:poets_paradise/features/poetry/presentation/widget/poetry_row_icons.dart';

class ReadPoetryPage extends StatelessWidget {
  final Profile currentUser;
  final Poetry poetry;

  final bool isSaved;
  const ReadPoetryPage({
    super.key,
    required this.poetry,
    required this.currentUser,
    required this.isSaved,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController commentController = TextEditingController();
    final key = GlobalKey<FormState>();

    final bool isLiked = poetry.likes.contains(currentUser.userId);

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
          child: Form(
            key: key,
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
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RowIcons(
                      currentUser: currentUser,
                      unPressedIcon: isLiked
                          ? const Icon(
                              CupertinoIcons.heart_fill,
                              color: AppPallete.purpleColor,
                            )
                          : const Icon(CupertinoIcons.heart),
                      label: 'Like',
                      pressedIcon: isLiked
                          ? const Icon(CupertinoIcons.heart)
                          : const Icon(
                              CupertinoIcons.heart_fill,
                              color: AppPallete.purpleColor,
                            ),
                      poetry: poetry,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<PoetryBloc>().add(
                                PoetryGetCommentsEvent(poetryId: poetry.id));
                            commentBottomSheet(
                              context: context,
                              commentController: commentController,
                              key: key,
                              author: currentUser,
                              poetry: poetry,
                            );
                          },
                          icon: const Icon(Icons.comment_outlined),
                        ),
                        const Text('Comment')
                      ],
                    ),
                    RowIcons(
                      currentUser: currentUser,
                      unPressedIcon: isSaved
                          ? const Icon(
                              Icons.bookmark,
                              color: AppPallete.purpleColor,
                            )
                          : const Icon(Icons.bookmark_outline),
                      label: 'Save',
                      pressedIcon: isSaved
                          ? const Icon(Icons.bookmark_outline)
                          : const Icon(
                              Icons.bookmark,
                              color: AppPallete.purpleColor,
                            ),
                      poetry: poetry,
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
      ),
    );
  }
}
