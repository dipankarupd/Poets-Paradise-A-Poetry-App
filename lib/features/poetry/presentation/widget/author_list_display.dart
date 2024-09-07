import 'package:flutter/material.dart';
import 'package:poets_paradise/cores/entities/profile.dart';

class AuthorListDisplay extends StatelessWidget {
  final Profile profile;
  const AuthorListDisplay({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundImage: profile.dp.isEmpty
                ? const AssetImage('assets/images/poetry.jpg')
                : NetworkImage(profile.dp),
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
