import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:poets_paradise/features/poetry/presentation/bloc/poetry_bloc.dart';
import 'package:poets_paradise/features/poetry/presentation/page/profile/profile_page.dart';

class HomePageHeader extends StatefulWidget {
  const HomePageHeader({super.key});

  @override
  State<HomePageHeader> createState() => _HomePageHeaderState();
}

class _HomePageHeaderState extends State<HomePageHeader> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PoetryBloc, PoetryState>(
      listener: (context, state) {
        // if (state is PoetryHomeNavigateToProfileState) {
        //   PersistentNavBarNavigator.pushNewScreen(
        //     context,
        //     screen: const ProfilePage(),
        //   );
        //   // Navigator.pushNamed(context, AppRoute.newPage);
        // }
      },
      builder: (context, state) {
        if (state is PoetryInitialState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hello ${state.profile.username},\nWhat types of poem you find',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  // context
                  //     .read<PoetryBloc>()
                  //     .add(PoetryHomeProfileButtonPressedEvent());

                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: ProfilePage(
                      profile: state.profile,
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    state.profile.dp,
                  ),
                ),
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
