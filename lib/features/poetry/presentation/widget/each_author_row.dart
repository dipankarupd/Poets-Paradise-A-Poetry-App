import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/cores/palette/app_palette.dart';
import 'package:poets_paradise/features/poetry/presentation/bloc/poetry_bloc.dart';
import 'package:poets_paradise/features/poetry/presentation/page/profile/profile_page.dart';

class EachAuthorRow extends StatefulWidget {
  Profile author;
  final Profile currentUser;

  EachAuthorRow({
    super.key,
    required this.author,
    required this.currentUser,
  });

  @override
  State<EachAuthorRow> createState() => _EachAuthorRowState();
}

class _EachAuthorRowState extends State<EachAuthorRow> {
  late bool isFollowed;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFollowed = widget.author.followers.contains(widget.currentUser.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: ProfilePage(profile: widget.author),
              );
            },
            child: CircleAvatar(
              radius: 36,
              backgroundImage: NetworkImage(widget.author.dp),
            ),
          ),
          Text(
            widget.author.username,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          BlocListener<PoetryBloc, PoetryState>(
            listener: (context, state) {
              if (state is PoetryToggleFollowState &&
                  state.updatedUserProfile.userId == widget.author.userId) {
                setState(() {
                  isFollowed = !isFollowed;
                  widget.author = state.updatedUserProfile;
                });
                context.read<PoetryBloc>().add(PoetryInitialEvent());
              }
            },
            child: widget.currentUser.userId != widget.author.userId
                ? GestureDetector(
                    onTap: () {
                      context.read<PoetryBloc>().add(
                            PoetryToggleFollowEvent(
                              follower: widget.currentUser.userId,
                              following: widget.author.userId,
                            ),
                          );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: !isFollowed
                            ? AppPallete.purpleColor
                            : AppPallete.greyColor,
                      ),
                      width: 100,
                      padding: const EdgeInsets.all(8),
                      child: isFollowed
                          ? const Center(
                              child: Text(
                              'Following',
                              style: TextStyle(color: AppPallete.whiteColor),
                            ))
                          : const Center(
                              child: Text(
                              'Follow',
                              style: TextStyle(color: AppPallete.whiteColor),
                            )),
                    ),
                  )
                : Container(
                    width: 100,
                  ),
          ),
        ],
      ),
    );
  }
}
