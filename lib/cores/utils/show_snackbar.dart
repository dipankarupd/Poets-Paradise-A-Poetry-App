import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message) {
  // usage of cascade operator
  // .. means cascading where more than one method can be used on the same operator
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
      ),
    );
}
