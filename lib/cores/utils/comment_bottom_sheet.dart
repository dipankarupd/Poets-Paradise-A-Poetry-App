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
              showSnackbar(context, 'comment uploaded successfully');
              commentController.clear();
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
                      IconButton(onPressed: () {}, icon: const Icon(Icons.info))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 25,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: const EdgeInsets.all(4),
                            child: const Text('data'));
                      },
                    ),
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
                                      AddCommentEvent(
                                        author: author,
                                        poetry: poetry,
                                        createdAt: DateTime.now(),
                                        content: commentController.text.trim(),
                                        likes: [],
                                      ),
                                    );
                              }
                            },
                            child: const Text('Next'),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}
