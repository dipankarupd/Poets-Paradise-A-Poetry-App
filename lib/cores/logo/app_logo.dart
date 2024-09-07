import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientText(
      'Poets\' Paradise',
      colors: [Colors.red, Colors.teal, Colors.blue],
      style: TextStyle(fontSize: 40),
    );
  }
}
