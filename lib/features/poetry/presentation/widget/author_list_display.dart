import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/features/poetry/presentation/page/profile/profile_page.dart';

class AuthorListDisplay extends StatelessWidget {
  final Profile profile;
  const AuthorListDisplay({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: ProfilePage(profile: profile),
              );
            },
            child: CircleAvatar(
              radius: 36,
              backgroundImage: profile.dp.isEmpty
                  ? const AssetImage('assets/images/poetry.jpg')
                  : NetworkImage(profile.dp),
            ),
          ),
          Text(
            profile.username,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          )
        ],
      ),
    );
  }
}
