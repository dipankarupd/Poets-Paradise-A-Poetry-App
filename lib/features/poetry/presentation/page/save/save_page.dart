import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poets_paradise/features/poetry/presentation/bloc/poetry_bloc.dart';
import 'package:poets_paradise/features/poetry/presentation/widget/popular_poetry_card.dart';

class SavePage extends StatelessWidget {
  const SavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PoetryBloc, PoetryState>(
      builder: (context, state) {
        if (state is PoetryInitialState) {
          final poetries = state.profile.savedPoetries;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Poetries'),
            ),
            body: poetries.isEmpty
                ? const Center(child: Text('No saved Poetries'))
                : Padding(
                    padding: EdgeInsets.all(16),
                    child: ListView.builder(
                        itemCount: poetries.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: SizedBox(
                              height: 140,
                              child: PopularPoetryCard(
                                currentUser: state.profile,
                                poetry: poetries[index],
                                isLiked: false,
                                isSaved: state.profile.savedPoetries
                                    .any((p) => p.id == poetries[index].id),
                              ),
                            ),
                          );
                        }),
                  ),
          );
        } else {
          return const Scaffold();
        }
      },
    );
  }
}
