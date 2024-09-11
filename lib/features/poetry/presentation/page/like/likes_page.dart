import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poets_paradise/cores/palette/app_palette.dart';
import 'package:poets_paradise/cores/utils/loader.dart';
import 'package:poets_paradise/cores/utils/show_snackbar.dart';
import 'package:poets_paradise/features/poetry/presentation/bloc/poetry_bloc.dart';
import 'package:poets_paradise/features/poetry/presentation/widget/popular_poetry_card.dart';

class LikesPage extends StatelessWidget {
  const LikesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PoetryBloc, PoetryState>(
      listener: (context, state) {
        if (state is PoetryFailedState) {
          return showSnackbar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is PoetryInitialLoadingState) {
          return const Loader();
        } else if (state is PoetryInitialState) {
          final poetries = state.poetries;
          final likedPoetry = poetries.where((poetry) {
            return poetry.likes.contains(state.profile.userId);
          }).toList();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppPallete.backgroundColor,
              title: const Text('Liked Poetries'),
            ),
            body: likedPoetry.isEmpty
                ? const Center(
                    child: Text('No liked poetries'),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListView.builder(
                        itemCount: likedPoetry.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: SizedBox(
                              height: 140,
                              child: PopularPoetryCard(
                                  poetry: likedPoetry[index],
                                  isLiked: false,
                                  isSaved: state.profile.savedPoetries.any(
                                      (p) => p.id == likedPoetry[index].id),
                                  currentUser: state.profile),
                            ),
                          );
                        }),
                  ),
          );
        } else {
          return const Center(
            child: Text('likes'),
          );
        }
      },
    );
  }
}
