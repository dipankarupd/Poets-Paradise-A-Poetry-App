import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:poets_paradise/config/routes.dart';
import 'package:poets_paradise/cores/palette/app_palette.dart';
import 'package:poets_paradise/cores/utils/show_snackbar.dart';
import 'package:poets_paradise/features/poetry/presentation/bloc/poetry_bloc.dart';
import 'package:poets_paradise/features/poetry/presentation/page/profile/edit_profile_page.dart';
import 'package:poets_paradise/features/poetry/presentation/widget/poem_display_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PoetryBloc>().add(PoetryInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PoetryBloc, PoetryState>(
      listener: (context, state) {
        if (state is PoetryProfileNavigteToEditProfileState) {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: const EditProfilePage(),
          );
        } else if (state is ProfileSignoutFailureState) {
          return showSnackbar(context, state.message);
        } else if (state is ProfileSignoutSuccessState) {
          Navigator.of(
            context,
            rootNavigator: true,
          ).pushNamedAndRemoveUntil(
            AppRoute.onboarding,
            (Route<dynamic> route) => false,
          );
        }
      },
      builder: (context, state) {
        if (state is PoetryInitialState) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppPallete.backgroundColor,
              leading: IconButton(
                onPressed: () {
                  PersistentNavBarNavigator.pop(context);
                  context.read<PoetryBloc>().add(PoetryInitialEvent());
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text('Profile'),
              actions: [
                IconButton(
                    onPressed: () {
                      context.read<PoetryBloc>().add(ProfileSignoutEvent());
                    },
                    icon: const Icon(Icons.logout))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(state.profile.dp),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${state.profile.poetries.length}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'posts',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${state.profile.followers.length}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'followers',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${state.profile.followers.length}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'following',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${state.profile.username}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${state.profile.bio}',
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        context
                            .read<PoetryBloc>()
                            .add(PoetryProfileEditButtonPressedEvent());
                      },
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 188, 187, 187),
                        ),
                        child: const Center(
                            child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Expanded(
                    child: GridView.builder(
                        itemCount: state.profile.poetries.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          // return Container(
                          //   margin: const EdgeInsets.all(4),
                          //   width: 130,
                          //   height: 130,
                          //   color: Colors.green,
                          //   child: const Center(
                          //     child: Text('demo'),
                          //   ),
                          // );
                          return PoemDisplayCard(
                              poem: state.profile.poetries[index]);
                        }),
                  )
                ],
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
