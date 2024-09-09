import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:poets_paradise/cores/palette/app_palette.dart';
import 'package:poets_paradise/cores/utils/loader.dart';
import 'package:poets_paradise/cores/utils/poetry_categories.dart';
import 'package:poets_paradise/features/poetry/presentation/bloc/poetry_bloc.dart';
import 'package:poets_paradise/features/poetry/presentation/page/home/all_latest_list.dart';
import 'package:poets_paradise/features/poetry/presentation/page/profile/all_authors_page.dart';
import 'package:poets_paradise/features/poetry/presentation/widget/author_list_display.dart';
import 'package:poets_paradise/features/poetry/presentation/widget/home_header.dart';
import 'package:poets_paradise/features/poetry/presentation/widget/poetry_category_card.dart';
import 'package:poets_paradise/features/poetry/presentation/widget/popular_poetry_card.dart';
import 'package:poets_paradise/features/poetry/presentation/widget/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<PoetryBloc>().add(PoetryInitialEvent());
  }

  final categoryList = getCategoriesList();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PoetryBloc, PoetryState>(
      builder: (context, state) {
        if (state is PoetryInitialLoadingState) {
          return const Scaffold(
            body: Center(
              child: Loader(),
            ),
          );
        } else if (state is PoetryInitialState) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppPallete.backgroundColor,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomePageHeader(),
                    const SizedBox(height: 30),
                    const CustomSearchBar(),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Latest List',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: AllLatestList(
                                poetries: state.poetries,
                                profile: state.profile,
                              ),
                            );
                          },
                          child: const Text(
                            'See all',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppPallete.greyColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return PopularPoetryCard(
                            currentUser: state.profile,
                            poetry: state.poetries[index],
                            isLiked: false,
                            isSaved: state.profile.savedPoetries
                                .any((p) => p.id == state.poetries[index].id),
                          );
                        },
                        itemCount: state.poetries.length,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return PoetryCategoryCard(
                            profile: state.profile,
                            category: categoryList[index],
                            poetries: state.poetries.where((p) {
                              return p.categories.contains(categoryList[index]);
                            }).toList(),
                          );
                        },
                        itemCount: categoryList.length,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Top Authors',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: AuthorsViewPage(authors: state.authors),
                            );
                          },
                          child: const Text(
                            'See all',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppPallete.greyColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return AuthorListDisplay(
                            profile: state.authors[index],
                          );
                        },
                        itemCount: state.authors.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Scaffold();
        }
      },
    );
  }
}
