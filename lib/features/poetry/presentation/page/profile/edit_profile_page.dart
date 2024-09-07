import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:poets_paradise/cores/utils/choose_image.dart';
import 'package:poets_paradise/cores/utils/show_snackbar.dart';
import 'package:poets_paradise/features/poetry/presentation/bloc/poetry_bloc.dart';
import 'package:poets_paradise/features/poetry/presentation/widget/profile_updater.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController bioController = TextEditingController();

  File? image;

  void addImage() async {
    final pickedImage = await chooseImage();

    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<PoetryBloc>().add(PoetryInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PoetryBloc, PoetryState>(
      listener: (context, state) {
        if (state is PoetryProfileUpdateState) {
          PersistentNavBarNavigator.pop(context);
          showSnackbar(context, 'Profile updated successfully');
          context.read<PoetryBloc>().add(PoetryInitialEvent());
        }
      },
      builder: (context, state) {
        if (state is PoetryInitialState) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  PersistentNavBarNavigator.pop(context);
                  context.read<PoetryBloc>().add(PoetryInitialEvent());
                },
              ),
              title: const Text('Edit Profile'),
              actions: [
                IconButton(
                    onPressed: () {
                      context.read<PoetryBloc>().add(
                            PoetryEditProfileEvent(
                              avatar: image,
                              username: usernameController.text.trim(),
                              bio: bioController.text.trim(),
                            ),
                          );
                    },
                    icon: const Icon(Icons.done))
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                addImage();
                              },
                              child: CircleAvatar(
                                radius: 58,
                                backgroundImage: image != null
                                    ? FileImage(image!)
                                    : NetworkImage(state.profile.dp),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              'Update your avatar',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ProfileUpdater(
                          controller: usernameController,
                          label: 'Enter new username'),
                      const SizedBox(
                        height: 20,
                      ),
                      ProfileUpdater(
                          controller: bioController, label: 'Enter new bio'),
                    ],
                  ),
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
