import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/cores/palette/app_palette.dart';
import 'package:poets_paradise/features/poetry/presentation/page/profile/profile_page.dart';

class EachAuthorRow extends StatefulWidget {
  final Profile author;
  const EachAuthorRow({super.key, required this.author});

  @override
  State<EachAuthorRow> createState() => _EachAuthorRowState();
}

class _EachAuthorRowState extends State<EachAuthorRow> {
  bool isFollowed = false;
  @override
  Widget build(BuildContext context) {
    return Row(
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
        GestureDetector(
          onTap: () {
            FirebaseAuth auth = FirebaseAuth.instance;
            if (auth.currentUser!.uid == widget.author.userId) {
              return;
            }
            isFollowed = !isFollowed;
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color:
                  !isFollowed ? AppPallete.purpleColor : AppPallete.greyColor,
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
      ],
    );
  }
}
