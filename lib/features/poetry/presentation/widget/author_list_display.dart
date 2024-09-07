import 'package:flutter/material.dart';

class AuthorListDisplay extends StatelessWidget {
  const AuthorListDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: Colors.green,
          ),
          Text(
            'username',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          )
        ],
      ),
    );
  }
}
