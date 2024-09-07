import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hint;
  final String label;
  final Icon leadingIcon;
  final TextEditingController controller;
  const AuthField({
    super.key,
    required this.hint,
    required this.label,
    required this.leadingIcon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        prefixIcon: leadingIcon,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }
}

class AuthPasswordField extends StatefulWidget {
  final String hint;
  final String label;
  final Icon leadingIcon;
  final TextEditingController controller;
  const AuthPasswordField({
    super.key,
    required this.hint,
    required this.label,
    required this.leadingIcon,
    required this.controller,
  });

  @override
  State<AuthPasswordField> createState() => _AuthPasswordFieldState();
}

class _AuthPasswordFieldState extends State<AuthPasswordField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: !showPassword,
      decoration: InputDecoration(
        hintText: widget.hint,
        labelText: widget.label,
        prefixIcon: widget.leadingIcon,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
          icon: showPassword
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        } else if (value.length < 6) {
          return 'Password must be atleast 6 characters';
        }
        return null;
      },
    );
  }
}
