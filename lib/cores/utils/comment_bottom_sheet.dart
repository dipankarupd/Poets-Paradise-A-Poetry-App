import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/cores/palette/app_palette.dart';
import 'package:poets_paradise/cores/utils/show_snackbar.dart';
import 'package:poets_paradise/features/poetry/domain/entity/poetry.dart';
import 'package:poets_paradise/features/poetry/presentation/bloc/poetry_bloc.dart';

void commentBottomSheet({
  required BuildContext context,
  required TextEditingController commentController,
  required Profile author,
  required Poetry poetry,
  required GlobalKey<FormState> key,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return BlocListener<PoetryBloc, PoetryState>(
        listener: (context, state) {
          if (state is PoetryFailedState) {
            return showSnackbar(context, state.message);
          } else if (state is AddCommentSuccessState) {
            showSnackbar(context, 'Comment uploaded successfully');
            commentController.clear();
            context
                .read<PoetryBloc>()
                .add(PoetryGetCommentsEvent(poetryId: poetry.id));
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppPallete.backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<PoetryBloc>().add(PoetryInitialEvent());
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    const Text(
                      'Comments',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.info_outline),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                BlocBuilder<PoetryBloc, PoetryState>(
                  builder: (context, state) {
                    if (state is FetchCommentsSuccessState) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: state.comments.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.all(4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                        state.comments[index].authorDp),
                                  ),
                                  const SizedBox(width: 8),

                                  // Add spacing between the avatar and text
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.comments[index].authorName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          state.comments[index].content,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(CupertinoIcons.heart_fill),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('Add a Comment'),
                      );
                    }
                  },
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                        inputDecorationTheme: const InputDecorationTheme()),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Value must be present';
                        }
                        return null;
                      },
                      controller: commentController,
                      maxLength: 100,
                      decoration: InputDecoration(
                        labelText: 'Enter the comment',
                        suffix: TextButton(
                          onPressed: () {
                            if (key.currentState!.validate()) {
                              context.read<PoetryBloc>().add(
                                    PoetryCommentUploadEvent(
                                      content: commentController.text.trim(),
                                      author: author.userId,
                                      poetry: poetry.id,
                                      createdAt: DateTime.now(),
                                    ),
                                  );
                            }
                          },
                          child: const Text('Next'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
