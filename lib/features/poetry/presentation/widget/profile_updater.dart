import 'package:flutter/material.dart';

class ProfileUpdater extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  const ProfileUpdater({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      maxLines: null,
      maxLength: 100,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }
}
