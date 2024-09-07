import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poets_paradise/cores/palette/app_palette.dart';
import 'package:poets_paradise/cores/utils/loader.dart';
import 'package:poets_paradise/features/poetry/presentation/bloc/poetry_bloc.dart';
import 'package:poets_paradise/features/poetry/presentation/widget/home_header.dart';
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
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppPallete.backgroundColor,
            ),
            body: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomePageHeader(),
                  SizedBox(height: 30),
                  CustomSearchBar(),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
