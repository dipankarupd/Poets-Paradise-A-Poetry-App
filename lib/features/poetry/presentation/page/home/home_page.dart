import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poets_paradise/cores/palette/app_palette.dart';
import 'package:poets_paradise/cores/utils/loader.dart';
import 'package:poets_paradise/cores/utils/poetry_categories.dart';
import 'package:poets_paradise/features/poetry/presentation/bloc/poetry_bloc.dart';
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Popular List',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'See all',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppPallete.greyColor,
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
                            poetry: state.poetries[index],
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
                            category: categoryList[index],
                          );
                        },
                        itemCount: categoryList.length,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Top Authors',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'See all',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppPallete.greyColor,
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
                          return const AuthorListDisplay();
                        },
                        itemCount: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold();
        }
      },
    );
  }
}
